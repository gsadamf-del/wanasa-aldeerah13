import 'package:flutter_test/flutter_test.dart';
import 'package:wanasa_aldeerah/main.dart';

void main() {
  testWidgets('V13 starts', (tester) async {
    await tester.pumpWidget(const WanasaApp());
    expect(find.text('وناسة الديرة'), findsOneWidget);
    expect(find.text('أهلاً بك 👋'), findsOneWidget);
  });
}
