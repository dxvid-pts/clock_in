// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacation_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VacationEntry _$VacationEntryFromJson(Map<String, dynamic> json) {
  return _VacationEntry.fromJson(json);
}

/// @nodoc
mixin _$VacationEntry {
  @JsonKey(name: "id")
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "start")
  @HiveField(1)
  int get start => throw _privateConstructorUsedError;
  @JsonKey(name: "end")
  @HiveField(2)
  int get end => throw _privateConstructorUsedError;
  @JsonKey(name: "category")
  @HiveField(3)
  VacationCategory get category => throw _privateConstructorUsedError;
  @JsonKey(name: "comment")
  @HiveField(4)
  String? get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VacationEntryCopyWith<VacationEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VacationEntryCopyWith<$Res> {
  factory $VacationEntryCopyWith(
          VacationEntry value, $Res Function(VacationEntry) then) =
      _$VacationEntryCopyWithImpl<$Res, VacationEntry>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") @HiveField(0) String id,
      @JsonKey(name: "start") @HiveField(1) int start,
      @JsonKey(name: "end") @HiveField(2) int end,
      @JsonKey(name: "category") @HiveField(3) VacationCategory category,
      @JsonKey(name: "comment") @HiveField(4) String? comment});
}

/// @nodoc
class _$VacationEntryCopyWithImpl<$Res, $Val extends VacationEntry>
    implements $VacationEntryCopyWith<$Res> {
  _$VacationEntryCopyWithImpl(this._value, this._then);

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
    Object? category = null,
    Object? comment = freezed,
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as VacationCategory,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VacationEntryCopyWith<$Res>
    implements $VacationEntryCopyWith<$Res> {
  factory _$$_VacationEntryCopyWith(
          _$_VacationEntry value, $Res Function(_$_VacationEntry) then) =
      __$$_VacationEntryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") @HiveField(0) String id,
      @JsonKey(name: "start") @HiveField(1) int start,
      @JsonKey(name: "end") @HiveField(2) int end,
      @JsonKey(name: "category") @HiveField(3) VacationCategory category,
      @JsonKey(name: "comment") @HiveField(4) String? comment});
}

/// @nodoc
class __$$_VacationEntryCopyWithImpl<$Res>
    extends _$VacationEntryCopyWithImpl<$Res, _$_VacationEntry>
    implements _$$_VacationEntryCopyWith<$Res> {
  __$$_VacationEntryCopyWithImpl(
      _$_VacationEntry _value, $Res Function(_$_VacationEntry) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
    Object? category = null,
    Object? comment = freezed,
  }) {
    return _then(_$_VacationEntry(
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as VacationCategory,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 7, adapterName: 'VacationEntryAdapter')
class _$_VacationEntry with DiagnosticableTreeMixin implements _VacationEntry {
  const _$_VacationEntry(
      {@JsonKey(name: "id") @HiveField(0) required this.id,
      @JsonKey(name: "start") @HiveField(1) required this.start,
      @JsonKey(name: "end") @HiveField(2) required this.end,
      @JsonKey(name: "category") @HiveField(3) required this.category,
      @JsonKey(name: "comment") @HiveField(4) required this.comment});

  factory _$_VacationEntry.fromJson(Map<String, dynamic> json) =>
      _$$_VacationEntryFromJson(json);

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
  @JsonKey(name: "category")
  @HiveField(3)
  final VacationCategory category;
  @override
  @JsonKey(name: "comment")
  @HiveField(4)
  final String? comment;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VacationEntry(id: $id, start: $start, end: $end, category: $category, comment: $comment)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VacationEntry'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('comment', comment));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VacationEntry &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, start, end, category, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VacationEntryCopyWith<_$_VacationEntry> get copyWith =>
      __$$_VacationEntryCopyWithImpl<_$_VacationEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VacationEntryToJson(
      this,
    );
  }
}

abstract class _VacationEntry implements VacationEntry {
  const factory _VacationEntry(
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
          required final VacationCategory category,
      @JsonKey(name: "comment")
      @HiveField(4)
          required final String? comment}) = _$_VacationEntry;

  factory _VacationEntry.fromJson(Map<String, dynamic> json) =
      _$_VacationEntry.fromJson;

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
  @JsonKey(name: "category")
  @HiveField(3)
  VacationCategory get category;
  @override
  @JsonKey(name: "comment")
  @HiveField(4)
  String? get comment;
  @override
  @JsonKey(ignore: true)
  _$$_VacationEntryCopyWith<_$_VacationEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
