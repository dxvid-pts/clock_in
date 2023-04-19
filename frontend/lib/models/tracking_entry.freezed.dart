// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TrackingEntry _$TrackingEntryFromJson(Map<String, dynamic> json) {
  return _TrackingEntry.fromJson(json);
}

/// @nodoc
mixin _$TrackingEntry {
  @JsonKey(name: "id")
  @HiveField(0)
  String get id =>
      throw _privateConstructorUsedError; //milliseconds since epoch
  @JsonKey(name: "start")
  @HiveField(1)
  int get start =>
      throw _privateConstructorUsedError; //milliseconds since epoch
  @JsonKey(name: "end")
  @HiveField(2)
  int get end => throw _privateConstructorUsedError;
  @JsonKey(name: "category")
  @HiveField(3)
  DateRangeCategory? get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackingEntryCopyWith<TrackingEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingEntryCopyWith<$Res> {
  factory $TrackingEntryCopyWith(
          TrackingEntry value, $Res Function(TrackingEntry) then) =
      _$TrackingEntryCopyWithImpl<$Res, TrackingEntry>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") @HiveField(0) String id,
      @JsonKey(name: "start") @HiveField(1) int start,
      @JsonKey(name: "end") @HiveField(2) int end,
      @JsonKey(name: "category") @HiveField(3) DateRangeCategory? category});
}

/// @nodoc
class _$TrackingEntryCopyWithImpl<$Res, $Val extends TrackingEntry>
    implements $TrackingEntryCopyWith<$Res> {
  _$TrackingEntryCopyWithImpl(this._value, this._then);

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
    Object? category = freezed,
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as DateRangeCategory?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrackingEntryCopyWith<$Res>
    implements $TrackingEntryCopyWith<$Res> {
  factory _$$_TrackingEntryCopyWith(
          _$_TrackingEntry value, $Res Function(_$_TrackingEntry) then) =
      __$$_TrackingEntryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") @HiveField(0) String id,
      @JsonKey(name: "start") @HiveField(1) int start,
      @JsonKey(name: "end") @HiveField(2) int end,
      @JsonKey(name: "category") @HiveField(3) DateRangeCategory? category});
}

/// @nodoc
class __$$_TrackingEntryCopyWithImpl<$Res>
    extends _$TrackingEntryCopyWithImpl<$Res, _$_TrackingEntry>
    implements _$$_TrackingEntryCopyWith<$Res> {
  __$$_TrackingEntryCopyWithImpl(
      _$_TrackingEntry _value, $Res Function(_$_TrackingEntry) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
    Object? category = freezed,
  }) {
    return _then(_$_TrackingEntry(
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as DateRangeCategory?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 3, adapterName: 'TrackingEntryAdapter')
class _$_TrackingEntry implements _TrackingEntry {
  const _$_TrackingEntry(
      {@JsonKey(name: "id")
      @HiveField(0)
          required this.id,
      @JsonKey(name: "start")
      @HiveField(1)
          required this.start,
      @JsonKey(name: "end")
      @HiveField(2)
          required this.end,
      @JsonKey(name: "category")
      @HiveField(3)
          this.category = DateRangeCategory.office});

  factory _$_TrackingEntry.fromJson(Map<String, dynamic> json) =>
      _$$_TrackingEntryFromJson(json);

  @override
  @JsonKey(name: "id")
  @HiveField(0)
  final String id;
//milliseconds since epoch
  @override
  @JsonKey(name: "start")
  @HiveField(1)
  final int start;
//milliseconds since epoch
  @override
  @JsonKey(name: "end")
  @HiveField(2)
  final int end;
  @override
  @JsonKey(name: "category")
  @HiveField(3)
  final DateRangeCategory? category;

  @override
  String toString() {
    return 'TrackingEntry(id: $id, start: $start, end: $end, category: $category)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrackingEntry &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, start, end, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrackingEntryCopyWith<_$_TrackingEntry> get copyWith =>
      __$$_TrackingEntryCopyWithImpl<_$_TrackingEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TrackingEntryToJson(
      this,
    );
  }
}

abstract class _TrackingEntry implements TrackingEntry {
  const factory _TrackingEntry(
      {@JsonKey(name: "id")
      @HiveField(0)
          required final String id,
      @JsonKey(name: "start")
      @HiveField(1)
          required final int start,
      @JsonKey(name: "end")
      @HiveField(2)
          required final int end,
      @JsonKey(name: "category")
      @HiveField(3)
          final DateRangeCategory? category}) = _$_TrackingEntry;

  factory _TrackingEntry.fromJson(Map<String, dynamic> json) =
      _$_TrackingEntry.fromJson;

  @override
  @JsonKey(name: "id")
  @HiveField(0)
  String get id;
  @override //milliseconds since epoch
  @JsonKey(name: "start")
  @HiveField(1)
  int get start;
  @override //milliseconds since epoch
  @JsonKey(name: "end")
  @HiveField(2)
  int get end;
  @override
  @JsonKey(name: "category")
  @HiveField(3)
  DateRangeCategory? get category;
  @override
  @JsonKey(ignore: true)
  _$$_TrackingEntryCopyWith<_$_TrackingEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
