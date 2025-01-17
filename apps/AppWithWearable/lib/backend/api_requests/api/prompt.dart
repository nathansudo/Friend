import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friend_private/backend/api_requests/api/llm.dart';
import 'package:friend_private/backend/database/memory.dart';
import 'package:friend_private/backend/database/message.dart';
import 'package:friend_private/backend/preferences.dart';
import 'package:friend_private/backend/schema/plugin.dart';
import 'package:friend_private/utils/other/string_utils.dart';
import 'package:instabug_flutter/instabug_flutter.dart';
import 'package:tuple/tuple.dart';

class SummaryResult {
  final Structured structured;
  final List<Tuple2<Plugin, String>> pluginsResponse;

  SummaryResult(this.structured, this.pluginsResponse);
}

Future<SummaryResult> summarizeMemory(
  String transcript,
  List<Memory> previousMemories, {
  bool forceProcess = false,
  bool ignoreCache = false,
  DateTime? conversationDate,
}) async {
  debugPrint('summarizeMemory transcript length: ${transcript.length}');
  if (transcript.isEmpty || transcript.split(' ').length < 7) {
    return SummaryResult(Structured('', ''), []);
  }
  if (transcript.split(' ').length > 100) {
    // TODO: try lower count?
    forceProcess = true;
  }

  // TODO: try later with temperature 0
  // NOTE: PROMPT IS VERY DELICATE, IT CAN DISCARD EVERYTHING IF NOT HANDLED PROPERLY
  // The purpose for structuring this memory is to remember important conversations, decisions, and action items. If there's nothing like that in the transcript, output an empty title.

  // TODO: improve overview with conversation summarizer plugin?
  // TODO: Generate tags/topics relevant to better query?
  var prompt =
      '''Based on the following recording transcript of a conversation, provide structure and clarity to the memory in JSON according rules stated below.
    The conversation language is ${SharedPreferencesUtil().recordingsLanguage}. Make sure to use English for your response.

    ${forceProcess ? "" : "It is possible that the conversation is not worth storing, there are no interesting topics, facts, or information, in that case, output an empty title, overview, and action items."}  
    
    For the title, use the main topic of the conversation.
    For the overview, condense the conversation into a brief summary with the main topics discussed, make sure to capture the key points and important details from the conversation.
    For the action items, include a list of commitments, specific tasks or actionable next steps from the conversation.
    For the category, classify the conversation into one of the available categories.
    For Calendar Events, include a list of events extracted from the conversation, that the user must have on his calendar. For date context, this conversation happened on ${(conversationDate ?? DateTime.now()).toIso8601String()}.
        
    Here is the transcript ```${transcript.trim()}```.
    
    The output should be formatted as a JSON instance that conforms to the JSON schema below.
    
    As an example, for the schema {"properties": {"foo": {"title": "Foo", "description": "a list of strings", "type": "array", "items": {"type": "string"}}}, "required": ["foo"]}
    the object {"foo": ["bar", "baz"]} is a well-formatted instance of the schema. The object {"properties": {"foo": ["bar", "baz"]}} is not well-formatted.
    
    Here is the output schema:
    ```
    {"properties": {"title": {"title": "Title", "description": "A title/name for this conversation", "default": "", "type": "string"}, "overview": {"title": "Overview", "description": "A brief summary with the main topics discussed, make sure to capture the key details.", "default": "", "type": "string"}, "action_items": {"title": "Action Items", "description": "A list of action items from the conversation", "default": [], "type": "array", "items": {"type": "string"}}, "category": {"description": "A category for this memory", "default": "other", "allOf": [{"\$ref": "#/definitions/CategoryEnum"}]}, "emoji": {"title": "Emoji", "description": "An emoji to represent the memory", "default": "\ud83e\udde0", "type": "string"}, "events": {"title": "Events", "description": "A list of events extracted from the conversation, that the user must have on his calendar.", "default": [], "type": "array", "items": {"\$ref": "#/definitions/CalendarEvent"}}}, "definitions": {"CategoryEnum": {"title": "CategoryEnum", "description": "An enumeration.", "enum": ["personal", "education", "health", "finance", "legal", "phylosophy", "spiritual", "science", "entrepreneurship", "parenting", "romantic", "travel", "inspiration", "technology", "business", "social", "work", "other"], "type": "string"}, "CalendarEvent": {"title": "CalendarEvent", "type": "object", "properties": {"title": {"title": "Title", "description": "The title of the event", "type": "string"}, "description": {"title": "Description", "description": "A brief description of the event", "default": "", "type": "string"}, "startsAt": {"title": "Starts At", "description": "The start date and time of the event", "type": "string", "format": "date-time"}, "duration": {"title": "Duration", "description": "The duration of the event in minutes", "default": 30, "type": "integer"}}, "required": ["title", "startsAt"]}}}
    ```
    '''
          .replaceAll('     ', '')
          .replaceAll('    ', '')
          .trim();
  debugPrint(prompt);
  var structuredResponse = extractJson(await executeGptPrompt(prompt, ignoreCache: ignoreCache));
  var structured = Structured.fromJson(jsonDecode(structuredResponse));
  if (structured.title.isEmpty) return SummaryResult(structured, []);
  var pluginsResponse = await executePlugins(transcript);
  return SummaryResult(structured, pluginsResponse);
}

Future<List<Tuple2<Plugin, String>>> executePlugins(String transcript) async {
  final pluginsList = SharedPreferencesUtil().pluginsList;
  final pluginsEnabled = SharedPreferencesUtil().pluginsEnabled;
  final enabledPlugins = pluginsList.where((e) => pluginsEnabled.contains(e.id)).toList();
  // TODO: include memory details parsed already as extra context?
  // TODO: improve plugin result, include result + id to map it to.
  List<Future<Tuple2<Plugin, String>>> pluginPrompts = enabledPlugins.map((plugin) async {
    try {
      String response = await executeGptPrompt('''
        Your are an AI with the following characteristics:
        Name: ${plugin.name}, 
        Description: ${plugin.description},
        Task: ${plugin.prompt}
        
        Note: It is possible that the conversation you are given, has nothing to do with your task, \
        in that case, output just an empty string. (For example, you are given a business conversation, but your task is medical analysis)
        
        Conversation: ```${transcript.trim()}```,
       
        Output your response in plain text, without markdown.
        Make sure to be concise and clear.
        '''
          .replaceAll('     ', '')
          .replaceAll('    ', '')
          .trim());
      return Tuple2(plugin, response.replaceAll('```', '').replaceAll('""', '').trim());
    } catch (e, stacktrace) {
      CrashReporting.reportHandledCrash(e, stacktrace, level: NonFatalExceptionLevel.critical, userAttributes: {
        'plugin': plugin.id,
        'plugins_count': pluginsEnabled.length.toString(),
        'transcript_length': transcript.length.toString(),
      });
      debugPrint('Error executing plugin ${plugin.id}');
      return Tuple2(plugin, '');
    }
  }).toList();

  Future<List<Tuple2<Plugin, String>>> allPluginResponses = Future.wait(pluginPrompts);
  try {
    var responses = await allPluginResponses;
    return responses.where((e) => e.item2.length > 5).toList();
  } catch (e, stacktrace) {
    CrashReporting.reportHandledCrash(e, stacktrace, level: NonFatalExceptionLevel.critical, userAttributes: {
      'plugins_count': pluginsEnabled.length.toString(),
      'transcript_length': transcript.length.toString(),
    });
    return [];
  }
}

Future<List<String>> getSemanticSummariesForEmbedding(String transcript) async {
  var prompt = '''
  Please analyze the following transcript and identify the distinct topics discussed within the conversation. \ 
  For each identified topic, provide a detailed summary that captures the key points and important details. \
  Ensure that each summary is comprehensive yet concise, reflecting the main ideas and any relevant subtopics. \
  Separate each topic summary clearly using '###' as a delimiter. Aim for each summary to be between 100-150 words.
  
  Example Transcript:
  Speaker 1: Hi, how are you doing today?
  Speaker 2: I'm good, thanks. I wanted to discuss our plans for the upcoming project.
  Speaker 1: Sure, let's dive in.
  Speaker 2: First, we need to outline the key deliverables and timelines. I think the initial prototype should be ready by the end of next month.
  Speaker 1: That sounds reasonable. What about the budget? Do we have an estimate yet?
  Speaker 2: We're looking at around \$50,000 for the initial phase. This includes development, testing, and some marketing.
  Speaker 1: We should also consider potential risks, like delays in development or additional costs for unforeseen issues.
  Speaker 2: Definitely. We need a risk management plan to address these possibilities.
  ...
  Speaker 1: That’s a good point. We should also consider the budget implications.
  
  Example of Desired Output:
  Topic 1: Project Planning and Timeline
  Summary: Discussed the upcoming project, focusing on the key deliverables and timelines. Agreed that the initial prototype should be ready by the end of next month. Emphasized the importance of outlining key tasks and milestones to ensure timely progress.
  ###
  Topic 2: Budget and Financial Considerations
  Summary: Estimated a budget of around \$50,000 for the initial phase, covering development, testing, and marketing. Highlighted the need to consider potential risks, such as delays in development and additional costs for unforeseen issues. Discussed the importance of a risk management plan to mitigate these risks.
  ###
  Topic 3: Risk Management
  Summary: Identified potential risks including development delays and unforeseen costs. Stressed the importance of creating a risk management plan to address these challenges proactively. Discussed strategies for monitoring and mitigating risks throughout the project lifecycle.
  ###
  
  Transcript:
  $transcript
  '''
      .replaceAll('  ', '')
      .trim();
  // debugPrint(prompt);
  var response = await executeGptPrompt(prompt);
  return response.split('###').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
}

Future<String> postMemoryCreationNotification(Memory memory) async {
  if (memory.structured.target!.title.isEmpty) return '';
  if (memory.structured.target!.actionItems.isEmpty) return '';

  var prompt = '''
  The following is the structuring from a transcript of a conversation that just finished.
  First determine if there's crucial value to notify a busy entrepreneur about it.
  If not, simply output an empty string, but if it is output 10 words (at most) with the most important action item from the conversation.
  Be short, concise, and helpful, and specially strict on determining if it's worth notifying or not.
   
  Transcript:
  ${memory.transcript}
  
  Structured version:
  ${memory.structured.target!.toJson()}
  ''';
  debugPrint(prompt);
  var result = await executeGptPrompt(prompt);
  debugPrint('postMemoryCreationNotification result: $result');
  if (result.contains('N/A') || result.split(' ').length < 5) return '';
  return result.replaceAll('```', '').trim();
}

Future<String> dailySummaryNotifications(List<Memory> memories) async {
  var msg = 'There were no memories today, don\'t forget to wear your Friend tomorrow 😁';
  if (memories.isEmpty) return msg;
  if (memories.where((m) => !m.discarded).length <= 1) return msg;

  var prompt = '''
  The following are a list of user memories with the transcripts with its respective structuring, that were saved during the user's day.
  The user wants to get a daily summary of the key action items he has to take based on his day memories.

  Remember the person is busy so this has to be very efficient and concise.
  Respond in at most 50 words.
  
  Output your response in plain text, without markdown.
  ```
  ${Memory.memoriesToString(memories, includeTranscript: true)}
  ```
  ''';
  debugPrint(prompt);
  var result = await executeGptPrompt(prompt);
  debugPrint('dailySummaryNotifications result: $result');
  return result.replaceAll('```', '').trim();
}

// ------

Future<Tuple2<List<String>, List<DateTime>>?> determineRequiresContext(List<Message> messages) async {
  String message = '''
        Based on the current conversation an AI is having with a Human, determine if the AI requires context outside the conversation to respond to the user's message.
        More context could mean, user stored old conversations, notes, or information that seems very user-specific.
        
        - First determine if the conversation requires context, in the field "requires_context".
        - Context could be 2 different things:
          - A list of topics (each topic being 1 or 2 words, e.g. "Startups" "Funding" "Business Meeting" "Artificial Intelligence") that are going to be used to retrieve more context, in the field "topics". Leave an empty list if not context is needed.
          - A dates range, if the context is time-based, in the field "dates_range". Leave an empty list if not context is needed. FYI if the user says today, today is ${DateTime.now().toIso8601String()}.
        
        Conversation:
        ${Message.getMessagesAsString(messages)}
        
        The output should be formatted as a JSON instance that conforms to the JSON schema below.
        
        As an example, for the schema {"properties": {"foo": {"title": "Foo", "description": "a list of strings", "type": "array", "items": {"type": "string"}}}, "required": ["foo"]}
        the object {"foo": ["bar", "baz"]} is a well-formatted instance of the schema. The object {"properties": {"foo": ["bar", "baz"]}} is not well-formatted.
        
        Here is the output schema:
        ```
        {"properties": {"requires_context": {"title": "Requires Context", "description": "Based on the conversation, this tells if context is needed to respond", "default": false, "type": "string"}, "topics": {"title": "Topics", "description": "If context is required, the topics to retrieve context from", "default": [], "type": "array", "items": {"type": "string"}}, "dates_range": {"title": "Dates Range", "description": "The dates range to retrieve context from", "default": [], "type": "array", "minItems": 2, "maxItems": 2, "items": [{"type": "string", "format": "date-time"}, {"type": "string", "format": "date-time"}]}}}
        ```
        '''
      .replaceAll('        ', '');
  debugPrint('determineRequiresContext message: $message');
  var response = await gptApiCall(model: 'gpt-4o', messages: [
    {"role": "user", "content": message}
  ]);
  debugPrint('determineRequiresContext response: $response');
  var cleanedResponse = response.toString().replaceAll('```', '').replaceAll('json', '').trim();
  try {
    var data = jsonDecode(cleanedResponse);
    debugPrint(data.toString());
    List<String> topics = data['topics'].map<String>((e) => e.toString()).toList();
    List<String> datesRange = data['dates_range'].map<String>((e) => e.toString()).toList();
    List<DateTime> dates = datesRange.map((e) => DateTime.parse(e)).toList();
    debugPrint('topics: $topics, dates: $dates');
    return Tuple2<List<String>, List<DateTime>>(topics, dates);
  } catch (e) {
    CrashReporting.reportHandledCrash(e, StackTrace.current, level: NonFatalExceptionLevel.critical, userAttributes: {
      'response': cleanedResponse,
      'message_length': message.length.toString(),
      'message_words': message.split(' ').length.toString(),
    });
    debugPrint('Error determining requires context: $e');
    return null;
  }
}

String qaRagPrompt(String context, List<Message> messages) {
  var prompt = '''
    You are an assistant for question-answering tasks. Use the following pieces of retrieved context and the conversation history to continue the conversation. 
    If you don't know the answer, just say that you don't know. Use three sentences maximum and keep the answer concise.
    If the message doesn't require context, it will be empty, so answer the question casually.
    
    Conversation History:
    ${Message.getMessagesAsString(messages)}

    Context:
    ``` 
    $context
    ```
    Answer:
    '''
      .replaceAll('    ', '');
  debugPrint(prompt);
  return prompt;
}
