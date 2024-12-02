//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'monitoring_data_dto.g.dart';

/// MonitoringDataDto
///
/// Properties:
/// * [timestamp] - Timestamp of the data point
/// * [value] - Value at the given timestamp in watts
@BuiltValue()
abstract class MonitoringDataDto
    implements Built<MonitoringDataDto, MonitoringDataDtoBuilder> {
  /// Timestamp of the data point
  @BuiltValueField(wireName: r'timestamp')
  DateTime get timestamp;

  /// Value at the given timestamp in watts
  @BuiltValueField(wireName: r'value')
  num get value;

  MonitoringDataDto._();

  factory MonitoringDataDto([void updates(MonitoringDataDtoBuilder b)]) =
      _$MonitoringDataDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MonitoringDataDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MonitoringDataDto> get serializer =>
      _$MonitoringDataDtoSerializer();
}

class _$MonitoringDataDtoSerializer
    implements PrimitiveSerializer<MonitoringDataDto> {
  @override
  final Iterable<Type> types = const [MonitoringDataDto, _$MonitoringDataDto];

  @override
  final String wireName = r'MonitoringDataDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MonitoringDataDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'timestamp';
    yield serializers.serialize(
      object.timestamp,
      specifiedType: const FullType(DateTime),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MonitoringDataDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MonitoringDataDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timestamp = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.value = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MonitoringDataDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MonitoringDataDtoBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
