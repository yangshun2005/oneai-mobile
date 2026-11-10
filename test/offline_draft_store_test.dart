import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oneai_mobile/src/offline_draft_store.dart';

void main() {
  test('drafts are scoped by user/session/mode and bounded', () async {
    SharedPreferences.setMockInitialValues({});
    final store = OfflineDraftStore(await SharedPreferences.getInstance());
    await store.write('hola', userId: 'u1', sessionId: 's1', mode: 'personalKnowledge');
    expect(store.read(userId: 'u1', sessionId: 's1', mode: 'personalKnowledge'), 'hola');
    expect(store.read(userId: 'u2', sessionId: 's1', mode: 'personalKnowledge'), '');
    await store.write('x' * 25000, userId: 'u1');
    expect(store.read(userId: 'u1').length, OfflineDraftStore.maxCharacters);
  });
}
