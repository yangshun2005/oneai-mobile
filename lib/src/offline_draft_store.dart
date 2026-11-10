import 'package:shared_preferences/shared_preferences.dart';

class OfflineDraftStore {
  OfflineDraftStore(this.preferences);

  final SharedPreferences preferences;
  static const maxCharacters = 20000;

  String key({required String userId, String sessionId = 'new', String mode = 'general'}) =>
      'oneai-draft:$userId:${sessionId.isEmpty ? 'new' : sessionId}:$mode';

  String read({required String userId, String sessionId = 'new', String mode = 'general'}) =>
      (preferences.getString(key(userId: userId, sessionId: sessionId, mode: mode)) ?? '')
          .substring(0, (preferences.getString(key(userId: userId, sessionId: sessionId, mode: mode)) ?? '').length.clamp(0, maxCharacters));

  Future<bool> write(String value, {required String userId, String sessionId = 'new', String mode = 'general'}) {
    final bounded = value.characters.take(maxCharacters).toString();
    final draftKey = key(userId: userId, sessionId: sessionId, mode: mode);
    if (bounded.trim().isEmpty) return preferences.remove(draftKey);
    return preferences.setString(draftKey, bounded);
  }

  Future<bool> clear({required String userId, String sessionId = 'new', String mode = 'general'}) =>
      preferences.remove(key(userId: userId, sessionId: sessionId, mode: mode));
}
