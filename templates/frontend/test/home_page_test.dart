import 'package:flutter_test/flutter_test.dart';
import 'package:minha_app/src/app.dart';

void main() {
  testWidgets('o app monta com o tema e o TOAT', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Minha API'), findsOneWidget);
    expect(find.text('Testar notificação'), findsOneWidget);
  });
}
