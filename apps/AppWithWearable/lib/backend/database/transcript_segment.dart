import 'package:objectbox/objectbox.dart';

@Entity()
class TranscriptSegment {
  @Id()
  int id = 0;

  String text;
  String? speaker;
  late int speakerId;
  bool isUser;

  // @Property(type: PropertyType.date)
  // DateTime? createdAt;
  double start;
  double end;

  TranscriptSegment({
    required this.text,
    required this.speaker,
    required this.isUser,
    required this.start,
    required this.end,
    // this.createdAt,
  }) {
    speakerId = speaker != null ? int.parse(speaker!.split('_')[1]) : 0;
    // createdAt ??= DateTime.now(); // TODO: -30 seconds + start time ? max(now, (now-30)
  }

  @override
  String toString() {
    return 'TranscriptSegment: {id: $id text: $text, speaker: $speakerId, isUser: $isUser, start: $start, end: $end}';
  }

  // Factory constructor to create a new Message instance from a map
  factory TranscriptSegment.fromJson(Map<String, dynamic> json) {
    return TranscriptSegment(
      text: json['text'] as String,
      speaker: (json['speaker'] ?? 'SPEAKER_00') as String,
      isUser: (json['is_user'] ?? false) as bool,
      start: json['start'] as double,
      end: json['end'] as double,
      // createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  // Method to convert a Message instance into a map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'speaker': speaker,
      'speaker_id': speakerId,
      'is_user': isUser,
      // 'created_at': createdAt?.toIso8601String(),
      'start': start,
      'end': end,
    };
  }

  static List<TranscriptSegment> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => TranscriptSegment.fromJson(e)).toList();
  }

  static cleanSegments(List<TranscriptSegment> segments) {
    var hallucinations = ['Thank you.', 'I don\'t know what to do,', 'I\'m', 'It was the worst case.', 'and,'];
    // TODO: do this with any words that gets repeated twice
    // - Replicate apparently has much more hallucinations
    for (var i = 0; i < segments.length; i++) {
      for (var hallucination in hallucinations) {
        segments[i].text = segments[i]
            .text
            .replaceAll('$hallucination $hallucination $hallucination', '')
            .replaceAll('$hallucination $hallucination', '')
            .replaceAll('  ', ' ')
            .trim();
      }
    }
    // remove empty segments
    segments.removeWhere((element) => element.text.isEmpty);
  }

  static combineSegments(
    List<TranscriptSegment> segments,
    List<TranscriptSegment> newSegments, {
    int elapsedSeconds = 0,
  }) {
    // TODO: combine keeping the time at which each segment was created?
    // currentTranscriptStartedAt - 30 seconds as input, segments processed til now.
    // what if they are 1 minute or more
    if (newSegments.isEmpty) return;

    // var lastSegmentSecondsElapsed = segments.isNotEmpty ? DateTime.now().difference(segments.last.createdAt!) : 0;
    // debugPrint('lastSegmentSecondsElapsed: $lastSegmentSecondsElapsed');

    var joinedSimilarSegments = <TranscriptSegment>[];
    for (var newSegment in newSegments) {
      newSegment.start += elapsedSeconds;
      newSegment.end += elapsedSeconds;

      if (joinedSimilarSegments.isNotEmpty &&
          (joinedSimilarSegments.last.speaker == newSegment.speaker ||
              (joinedSimilarSegments.last.isUser && newSegment.isUser))) {
        joinedSimilarSegments.last.text += ' ${newSegment.text}';
        joinedSimilarSegments.last.end = newSegment.end;
      } else {
        joinedSimilarSegments.add(newSegment);
      }
    }
    // segments is not empty
    // prev segment speaker is same as first new segment speaker || prev segment is user and first new segment is user
    // and the difference between the end of the last segment and the start of the first new segment is less than 30 seconds

    if (segments.isNotEmpty &&
        (segments.last.speaker == joinedSimilarSegments[0].speaker ||
            (segments.last.isUser && joinedSimilarSegments[0].isUser)) &&
        (joinedSimilarSegments[0].start - segments.last.end < 30)) {
      segments.last.text += ' ${joinedSimilarSegments[0].text}';
      segments.last.end = joinedSimilarSegments[0].end;
      joinedSimilarSegments.removeAt(0);
    }

    cleanSegments(segments);
    cleanSegments(joinedSimilarSegments);

    segments.addAll(joinedSimilarSegments);
  }

  static String buildDiarizedTranscriptMessage(List<TranscriptSegment> segments) {
    String transcript = '';
    for (var segment in segments) {
      if (segment.isUser) {
        transcript += 'You said: ${segment.text} ';
      } else {
        transcript += 'Speaker ${segment.speakerId}: ${segment.text} ';
      }
      transcript += '\n\n';
    }
    return transcript.trim();
  }
}
