// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'backend/database/memory.dart';
import 'backend/database/message.dart';
import 'backend/database/transcript_segment.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 1521024926543535),
      name: 'Memory',
      lastPropertyId: const obx_int.IdUid(8, 970897693726655020),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 8192907449372324122),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 1146945244623312213),
            name: 'createdAt',
            type: 10,
            flags: 8,
            indexId: const obx_int.IdUid(1, 4862313103417962125)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 1067066826133615759),
            name: 'transcript',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 8255028376208853529),
            name: 'recordingFilePath',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 1519520653454061032),
            name: 'discarded',
            type: 1,
            flags: 8,
            indexId: const obx_int.IdUid(2, 2359101042900121877)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 1385167281437281076),
            name: 'structuredId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(4, 7578069314509735145),
            relationTarget: 'Structured'),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 8550625374874609345),
            name: 'startedAt',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 970897693726655020),
            name: 'finishedAt',
            type: 10,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[
        obx_int.ModelRelation(
            id: const obx_int.IdUid(2, 4703245221378113920),
            name: 'transcriptSegments',
            targetId: const obx_int.IdUid(6, 4187059965573492189))
      ],
      backlinks: <obx_int.ModelBacklink>[
        obx_int.ModelBacklink(
            name: 'pluginsResponse',
            srcEntity: 'PluginResponse',
            srcField: 'memory')
      ]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 6427539297124375252),
      name: 'Structured',
      lastPropertyId: const obx_int.IdUid(7, 4057508104512714772),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 3948118750863357078),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 9195755445020816093),
            name: 'title',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 2794378035287238174),
            name: 'overview',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 1092528478436176027),
            name: 'emoji',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 4057508104512714772),
            name: 'category',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[
        obx_int.ModelBacklink(
            name: 'actionItems',
            srcEntity: 'ActionItem',
            srcField: 'structured'),
        obx_int.ModelBacklink(
            name: 'events', srcEntity: 'Event', srcField: 'structured')
      ]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(3, 9190753393137293311),
      name: 'ActionItem',
      lastPropertyId: const obx_int.IdUid(4, 3090374185978757862),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 2694083310188604862),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 6712185592055014870),
            name: 'description',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 54520819618183643),
            name: 'completed',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 3090374185978757862),
            name: 'structuredId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(3, 2460795322279972178),
            relationTarget: 'Structured')
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(4, 8944838570398231806),
      name: 'PluginResponse',
      lastPropertyId: const obx_int.IdUid(6, 4389894679139533208),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6229771852928788263),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 691957194881154364),
            name: 'memoryId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(6, 2436940497868764355),
            relationTarget: 'Memory'),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 2860027525438426963),
            name: 'content',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 4389894679139533208),
            name: 'pluginId',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(5, 3905873968765933532),
      name: 'Message',
      lastPropertyId: const obx_int.IdUid(5, 5337649766892625543),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 1878881834426487468),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 9040753066664612555),
            name: 'createdAt',
            type: 10,
            flags: 8,
            indexId: const obx_int.IdUid(7, 296619579137476887)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 3367360249871802822),
            name: 'text',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 3325943223378277861),
            name: 'sender',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 5337649766892625543),
            name: 'type',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[
        obx_int.ModelRelation(
            id: const obx_int.IdUid(1, 7091380547659316419),
            name: 'memories',
            targetId: const obx_int.IdUid(1, 1521024926543535))
      ],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(6, 4187059965573492189),
      name: 'TranscriptSegment',
      lastPropertyId: const obx_int.IdUid(7, 4627200910621033983),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 4980495793887661277),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 9071133227098548567),
            name: 'text',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 9196505048325675409),
            name: 'speaker',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 407443881337783951),
            name: 'speakerId',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 5971131167901661375),
            name: 'isUser',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 4843588352934686711),
            name: 'start',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 4627200910621033983),
            name: 'end',
            type: 8,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(7, 265133176252396324),
      name: 'Event',
      lastPropertyId: const obx_int.IdUid(7, 7098116187702997412),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 1288962548328890994),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 4790234918480393406),
            name: 'title',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 2151476491244407949),
            name: 'startsAt',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 7841939327187751919),
            name: 'duration',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 6399120598852890710),
            name: 'description',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 8016636007871233432),
            name: 'created',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 7098116187702997412),
            name: 'structuredId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(8, 5225160858485949527),
            relationTarget: 'Structured')
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(7, 265133176252396324),
      lastIndexId: const obx_int.IdUid(8, 5225160858485949527),
      lastRelationId: const obx_int.IdUid(2, 4703245221378113920),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [2159273736567567467],
      retiredPropertyUids: const [
        2626201971202508244,
        1809459319638310611,
        6229900676402028868,
        8014962203152976278
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    Memory: obx_int.EntityDefinition<Memory>(
        model: _entities[0],
        toOneRelations: (Memory object) => [object.structured],
        toManyRelations: (Memory object) => {
              obx_int.RelInfo<Memory>.toMany(2, object.id):
                  object.transcriptSegments,
              obx_int.RelInfo<PluginResponse>.toOneBacklink(4, object.id,
                      (PluginResponse srcObject) => srcObject.memory):
                  object.pluginsResponse
            },
        getId: (Memory object) => object.id,
        setId: (Memory object, int id) {
          object.id = id;
        },
        objectToFB: (Memory object, fb.Builder fbb) {
          final transcriptOffset = fbb.writeString(object.transcript);
          final recordingFilePathOffset = object.recordingFilePath == null
              ? null
              : fbb.writeString(object.recordingFilePath!);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.createdAt.millisecondsSinceEpoch);
          fbb.addOffset(2, transcriptOffset);
          fbb.addOffset(3, recordingFilePathOffset);
          fbb.addBool(4, object.discarded);
          fbb.addInt64(5, object.structured.targetId);
          fbb.addInt64(6, object.startedAt?.millisecondsSinceEpoch);
          fbb.addInt64(7, object.finishedAt?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final startedAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 16);
          final finishedAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 18);
          final createdAtParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0));
          final transcriptParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final discardedParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 12, false);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final recordingFilePathParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10);
          final startedAtParam = startedAtValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(startedAtValue);
          final finishedAtParam = finishedAtValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(finishedAtValue);
          final object = Memory(createdAtParam, transcriptParam, discardedParam,
              id: idParam,
              recordingFilePath: recordingFilePathParam,
              startedAt: startedAtParam,
              finishedAt: finishedAtParam);
          object.structured.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          object.structured.attach(store);
          obx_int.InternalToManyAccess.setRelInfo<Memory>(
              object.transcriptSegments,
              store,
              obx_int.RelInfo<Memory>.toMany(2, object.id));
          obx_int.InternalToManyAccess.setRelInfo<Memory>(
              object.pluginsResponse,
              store,
              obx_int.RelInfo<PluginResponse>.toOneBacklink(4, object.id,
                  (PluginResponse srcObject) => srcObject.memory));
          return object;
        }),
    Structured: obx_int.EntityDefinition<Structured>(
        model: _entities[1],
        toOneRelations: (Structured object) => [],
        toManyRelations: (Structured object) => {
              obx_int.RelInfo<ActionItem>.toOneBacklink(4, object.id,
                      (ActionItem srcObject) => srcObject.structured):
                  object.actionItems,
              obx_int.RelInfo<Event>.toOneBacklink(
                      7, object.id, (Event srcObject) => srcObject.structured):
                  object.events
            },
        getId: (Structured object) => object.id,
        setId: (Structured object, int id) {
          object.id = id;
        },
        objectToFB: (Structured object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          final overviewOffset = fbb.writeString(object.overview);
          final emojiOffset = fbb.writeString(object.emoji);
          final categoryOffset = fbb.writeString(object.category);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, overviewOffset);
          fbb.addOffset(5, emojiOffset);
          fbb.addOffset(6, categoryOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final overviewParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final emojiParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 14, '');
          final categoryParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 16, '');
          final object = Structured(titleParam, overviewParam,
              id: idParam, emoji: emojiParam, category: categoryParam);
          obx_int.InternalToManyAccess.setRelInfo<Structured>(
              object.actionItems,
              store,
              obx_int.RelInfo<ActionItem>.toOneBacklink(4, object.id,
                  (ActionItem srcObject) => srcObject.structured));
          obx_int.InternalToManyAccess.setRelInfo<Structured>(
              object.events,
              store,
              obx_int.RelInfo<Event>.toOneBacklink(
                  7, object.id, (Event srcObject) => srcObject.structured));
          return object;
        }),
    ActionItem: obx_int.EntityDefinition<ActionItem>(
        model: _entities[2],
        toOneRelations: (ActionItem object) => [object.structured],
        toManyRelations: (ActionItem object) => {},
        getId: (ActionItem object) => object.id,
        setId: (ActionItem object, int id) {
          object.id = id;
        },
        objectToFB: (ActionItem object, fb.Builder fbb) {
          final descriptionOffset = fbb.writeString(object.description);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, descriptionOffset);
          fbb.addBool(2, object.completed);
          fbb.addInt64(3, object.structured.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final descriptionParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, '');
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final completedParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 8, false);
          final object = ActionItem(descriptionParam,
              id: idParam, completed: completedParam);
          object.structured.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.structured.attach(store);
          return object;
        }),
    PluginResponse: obx_int.EntityDefinition<PluginResponse>(
        model: _entities[3],
        toOneRelations: (PluginResponse object) => [object.memory],
        toManyRelations: (PluginResponse object) => {},
        getId: (PluginResponse object) => object.id,
        setId: (PluginResponse object, int id) {
          object.id = id;
        },
        objectToFB: (PluginResponse object, fb.Builder fbb) {
          final contentOffset = fbb.writeString(object.content);
          final pluginIdOffset = object.pluginId == null
              ? null
              : fbb.writeString(object.pluginId!);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addInt64(3, object.memory.targetId);
          fbb.addOffset(4, contentOffset);
          fbb.addOffset(5, pluginIdOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final contentParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final pluginIdParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 14);
          final object = PluginResponse(contentParam,
              id: idParam, pluginId: pluginIdParam);
          object.memory.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.memory.attach(store);
          return object;
        }),
    Message: obx_int.EntityDefinition<Message>(
        model: _entities[4],
        toOneRelations: (Message object) => [],
        toManyRelations: (Message object) =>
            {obx_int.RelInfo<Message>.toMany(1, object.id): object.memories},
        getId: (Message object) => object.id,
        setId: (Message object, int id) {
          object.id = id;
        },
        objectToFB: (Message object, fb.Builder fbb) {
          final textOffset = fbb.writeString(object.text);
          final senderOffset = fbb.writeString(object.sender);
          final typeOffset = fbb.writeString(object.type);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.createdAt.millisecondsSinceEpoch);
          fbb.addOffset(2, textOffset);
          fbb.addOffset(3, senderOffset);
          fbb.addOffset(4, typeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final createdAtParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0));
          final textParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final senderParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final typeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final object = Message(createdAtParam, textParam, senderParam,
              id: idParam, type: typeParam);
          obx_int.InternalToManyAccess.setRelInfo<Message>(object.memories,
              store, obx_int.RelInfo<Message>.toMany(1, object.id));
          return object;
        }),
    TranscriptSegment: obx_int.EntityDefinition<TranscriptSegment>(
        model: _entities[5],
        toOneRelations: (TranscriptSegment object) => [],
        toManyRelations: (TranscriptSegment object) => {},
        getId: (TranscriptSegment object) => object.id,
        setId: (TranscriptSegment object, int id) {
          object.id = id;
        },
        objectToFB: (TranscriptSegment object, fb.Builder fbb) {
          final textOffset = fbb.writeString(object.text);
          final speakerOffset =
              object.speaker == null ? null : fbb.writeString(object.speaker!);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, textOffset);
          fbb.addOffset(2, speakerOffset);
          fbb.addInt64(3, object.speakerId);
          fbb.addBool(4, object.isUser);
          fbb.addFloat64(5, object.start);
          fbb.addFloat64(6, object.end);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final textParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final speakerParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final isUserParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 12, false);
          final startParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 14, 0);
          final endParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 16, 0);
          final object = TranscriptSegment(
              text: textParam,
              speaker: speakerParam,
              isUser: isUserParam,
              start: startParam,
              end: endParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0)
            ..speakerId =
                const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);

          return object;
        }),
    Event: obx_int.EntityDefinition<Event>(
        model: _entities[6],
        toOneRelations: (Event object) => [object.structured],
        toManyRelations: (Event object) => {},
        getId: (Event object) => object.id,
        setId: (Event object, int id) {
          object.id = id;
        },
        objectToFB: (Event object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          final descriptionOffset = fbb.writeString(object.description);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addInt64(2, object.startsAt.millisecondsSinceEpoch);
          fbb.addInt64(3, object.duration);
          fbb.addOffset(4, descriptionOffset);
          fbb.addBool(5, object.created);
          fbb.addInt64(6, object.structured.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final startsAtParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0));
          final durationParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          final descriptionParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 12, '');
          final createdParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 14, false);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final object = Event(titleParam, startsAtParam, durationParam,
              description: descriptionParam,
              created: createdParam,
              id: idParam);
          object.structured.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0);
          object.structured.attach(store);
          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Memory] entity fields to define ObjectBox queries.
class Memory_ {
  /// See [Memory.id].
  static final id =
      obx.QueryIntegerProperty<Memory>(_entities[0].properties[0]);

  /// See [Memory.createdAt].
  static final createdAt =
      obx.QueryDateProperty<Memory>(_entities[0].properties[1]);

  /// See [Memory.transcript].
  static final transcript =
      obx.QueryStringProperty<Memory>(_entities[0].properties[2]);

  /// See [Memory.recordingFilePath].
  static final recordingFilePath =
      obx.QueryStringProperty<Memory>(_entities[0].properties[3]);

  /// See [Memory.discarded].
  static final discarded =
      obx.QueryBooleanProperty<Memory>(_entities[0].properties[4]);

  /// See [Memory.structured].
  static final structured =
      obx.QueryRelationToOne<Memory, Structured>(_entities[0].properties[5]);

  /// See [Memory.startedAt].
  static final startedAt =
      obx.QueryDateProperty<Memory>(_entities[0].properties[6]);

  /// See [Memory.finishedAt].
  static final finishedAt =
      obx.QueryDateProperty<Memory>(_entities[0].properties[7]);

  /// see [Memory.transcriptSegments]
  static final transcriptSegments =
      obx.QueryRelationToMany<Memory, TranscriptSegment>(
          _entities[0].relations[0]);

  /// see [Memory.pluginsResponse]
  static final pluginsResponse =
      obx.QueryBacklinkToMany<PluginResponse, Memory>(PluginResponse_.memory);
}

/// [Structured] entity fields to define ObjectBox queries.
class Structured_ {
  /// See [Structured.id].
  static final id =
      obx.QueryIntegerProperty<Structured>(_entities[1].properties[0]);

  /// See [Structured.title].
  static final title =
      obx.QueryStringProperty<Structured>(_entities[1].properties[1]);

  /// See [Structured.overview].
  static final overview =
      obx.QueryStringProperty<Structured>(_entities[1].properties[2]);

  /// See [Structured.emoji].
  static final emoji =
      obx.QueryStringProperty<Structured>(_entities[1].properties[3]);

  /// See [Structured.category].
  static final category =
      obx.QueryStringProperty<Structured>(_entities[1].properties[4]);

  /// see [Structured.actionItems]
  static final actionItems =
      obx.QueryBacklinkToMany<ActionItem, Structured>(ActionItem_.structured);

  /// see [Structured.events]
  static final events =
      obx.QueryBacklinkToMany<Event, Structured>(Event_.structured);
}

/// [ActionItem] entity fields to define ObjectBox queries.
class ActionItem_ {
  /// See [ActionItem.id].
  static final id =
      obx.QueryIntegerProperty<ActionItem>(_entities[2].properties[0]);

  /// See [ActionItem.description].
  static final description =
      obx.QueryStringProperty<ActionItem>(_entities[2].properties[1]);

  /// See [ActionItem.completed].
  static final completed =
      obx.QueryBooleanProperty<ActionItem>(_entities[2].properties[2]);

  /// See [ActionItem.structured].
  static final structured = obx.QueryRelationToOne<ActionItem, Structured>(
      _entities[2].properties[3]);
}

/// [PluginResponse] entity fields to define ObjectBox queries.
class PluginResponse_ {
  /// See [PluginResponse.id].
  static final id =
      obx.QueryIntegerProperty<PluginResponse>(_entities[3].properties[0]);

  /// See [PluginResponse.memory].
  static final memory = obx.QueryRelationToOne<PluginResponse, Memory>(
      _entities[3].properties[1]);

  /// See [PluginResponse.content].
  static final content =
      obx.QueryStringProperty<PluginResponse>(_entities[3].properties[2]);

  /// See [PluginResponse.pluginId].
  static final pluginId =
      obx.QueryStringProperty<PluginResponse>(_entities[3].properties[3]);
}

/// [Message] entity fields to define ObjectBox queries.
class Message_ {
  /// See [Message.id].
  static final id =
      obx.QueryIntegerProperty<Message>(_entities[4].properties[0]);

  /// See [Message.createdAt].
  static final createdAt =
      obx.QueryDateProperty<Message>(_entities[4].properties[1]);

  /// See [Message.text].
  static final text =
      obx.QueryStringProperty<Message>(_entities[4].properties[2]);

  /// See [Message.sender].
  static final sender =
      obx.QueryStringProperty<Message>(_entities[4].properties[3]);

  /// See [Message.type].
  static final type =
      obx.QueryStringProperty<Message>(_entities[4].properties[4]);

  /// see [Message.memories]
  static final memories =
      obx.QueryRelationToMany<Message, Memory>(_entities[4].relations[0]);
}

/// [TranscriptSegment] entity fields to define ObjectBox queries.
class TranscriptSegment_ {
  /// See [TranscriptSegment.id].
  static final id =
      obx.QueryIntegerProperty<TranscriptSegment>(_entities[5].properties[0]);

  /// See [TranscriptSegment.text].
  static final text =
      obx.QueryStringProperty<TranscriptSegment>(_entities[5].properties[1]);

  /// See [TranscriptSegment.speaker].
  static final speaker =
      obx.QueryStringProperty<TranscriptSegment>(_entities[5].properties[2]);

  /// See [TranscriptSegment.speakerId].
  static final speakerId =
      obx.QueryIntegerProperty<TranscriptSegment>(_entities[5].properties[3]);

  /// See [TranscriptSegment.isUser].
  static final isUser =
      obx.QueryBooleanProperty<TranscriptSegment>(_entities[5].properties[4]);

  /// See [TranscriptSegment.start].
  static final start =
      obx.QueryDoubleProperty<TranscriptSegment>(_entities[5].properties[5]);

  /// See [TranscriptSegment.end].
  static final end =
      obx.QueryDoubleProperty<TranscriptSegment>(_entities[5].properties[6]);
}

/// [Event] entity fields to define ObjectBox queries.
class Event_ {
  /// See [Event.id].
  static final id = obx.QueryIntegerProperty<Event>(_entities[6].properties[0]);

  /// See [Event.title].
  static final title =
      obx.QueryStringProperty<Event>(_entities[6].properties[1]);

  /// See [Event.startsAt].
  static final startsAt =
      obx.QueryDateProperty<Event>(_entities[6].properties[2]);

  /// See [Event.duration].
  static final duration =
      obx.QueryIntegerProperty<Event>(_entities[6].properties[3]);

  /// See [Event.description].
  static final description =
      obx.QueryStringProperty<Event>(_entities[6].properties[4]);

  /// See [Event.created].
  static final created =
      obx.QueryBooleanProperty<Event>(_entities[6].properties[5]);

  /// See [Event.structured].
  static final structured =
      obx.QueryRelationToOne<Event, Structured>(_entities[6].properties[6]);
}
