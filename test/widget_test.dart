// Vitrin uygulaması için temel smoke test.
//
// Splash ekranının render olduğunu ve uygulama başlığının (Vitrin)
// göründüğünü doğrular.

import 'package:flutter_test/flutter_test.dart';

import 'package:vitrin/main.dart';

void main() {
  testWidgets('Splash ekranı render olur ve marka adını gösterir', (WidgetTester tester) async {
    await tester.pumpWidget(const VitrinApp());

    expect(find.text('Vitrin'), findsOneWidget);
    expect(find.text('Teknoloji Vitrini'), findsOneWidget);
  });
}
