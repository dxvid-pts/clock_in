import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = ChangeNotifierProvider.family(
    (ref, String userId) => UserDataNotifier(userId));

class UserDataNotifier extends ChangeNotifier {
  UserDataNotifier(String userId);
}
