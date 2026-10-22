import 'package:flutter_test/flutter_test.dart';
import 'package:atena_app/src/app.dart';

void main() {
  testWidgets('o app monta com o tema e o TOAT', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Atena App'), findsOneWidget);
    expect(find.text('Testar notificação'), findsOneWidget);
  });
}
