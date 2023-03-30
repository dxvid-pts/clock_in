// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_range.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DateRange _$DateRangeFromJson(Map<String, dynamic> json) {
  return _DateRange.fromJson(json);
}

/// @nodoc
mixin _$DateRange {
  @JsonKey(name: "id")
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "start")
  @HiveField(1)
  int get start => throw _privateConstructorUsedError;
  @JsonKey(name: "end")
  @HiveField(2)
  int get end => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DateRangeCopyWith<DateRange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateRangeCopyWith<$Res> {
  factory $DateRangeCopyWith(DateRange value, $Res Function(DateRange) then) =
      _$DateRangeCopyWithImpl<$Res, DateRange>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") @HiveField(0) String id,
      @JsonKey(name: "start") @HiveField(1) int start,
      @JsonKey(name: "end") @HiveField(2) int end});
}

/// @nodoc
class _$DateRangeCopyWithImpl<$Res, $Val extends DateRange>
    implements $DateRangeCopyWith<$Res> {
  _$DateRangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DateRangeCopyWith<$Res> implements $DateRangeCopyWith<$Res> {
  factory _$$_DateRangeCopyWith(
          _$_DateRange value, $Res Function(_$_DateRange) then) =
      __$$_DateRangeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") @HiveField(0) String id,
      @JsonKey(name: "start") @HiveField(1) int start,
      @JsonKey(name: "end") @HiveField(2) int end});
}

/// @nodoc
class __$$_DateRangeCopyWithImpl<$Res>
    extends _$DateRangeCopyWithImpl<$Res, _$_DateRange>
    implements _$$_DateRangeCopyWith<$Res> {
  __$$_DateRangeCopyWithImpl(
      _$_DateRange _value, $Res Function(_$_DateRange) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$_DateRange(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 2, adapterName: 'DateRangeAdapter')
class _$_DateRange with DiagnosticableTreeMixin implements _DateRange {
  const _$_DateRange(
      {@JsonKey(name: "id") @HiveField(0) required this.id,
      @JsonKey(name: "start") @HiveField(1) required this.start,
      @JsonKey(name: "end") @HiveField(2) required this.end});

  factory _$_DateRange.fromJson(Map<String, dynamic> json) =>
      _$$_DateRangeFromJson(json);

  @override
  @JsonKey(name: "id")
  @HiveField(0)
  final String id;
  @override
  @JsonKey(name: "start")
  @HiveField(1)
  final int start;
  @override
  @JsonKey(name: "end")
  @HiveField(2)
  final int end;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DateRange(id: $id, start: $start, end: $end)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DateRange'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DateRange &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, start, end);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DateRangeCopyWith<_$_DateRange> get copyWith =>
      __$$_DateRangeCopyWithImpl<_$_DateRange>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DateRangeToJson(
      this,
    );
  }
}

abstract class _DateRange implements DateRange {
  const factory _DateRange(
          {@JsonKey(name: "id") @HiveField(0) required final String id,
          @JsonKey(name: "start") @HiveField(1) required final int start,
          @JsonKey(name: "end") @HiveField(2) required final int end}) =
      _$_DateRange;

  factory _DateRange.fromJson(Map<String, dynamic> json) =
      _$_DateRange.fromJson;

  @override
  @JsonKey(name: "id")
  @HiveField(0)
  String get id;
  @override
  @JsonKey(name: "start")
  @HiveField(1)
  int get start;
  @override
  @JsonKey(name: "end")
  @HiveField(2)
  int get end;
  @override
  @JsonKey(ignore: true)
  _$$_DateRangeCopyWith<_$_DateRange> get copyWith =>
      throw _privateConstructorUsedError;
}
