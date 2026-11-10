import 'package:flutter_test/flutter_test.dart';
import 'package:oneai_mobile/main.dart';

void main() {
  testWidgets('OneAI shell renders a mobile composer', (tester) async {
    await tester.pumpWidget(const OneAiApp());
    expect(find.text('OneAI'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
