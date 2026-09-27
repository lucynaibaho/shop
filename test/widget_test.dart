// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shop/main.dart';

void main() {
  testWidgets('login screen is the initial route', (WidgetTester tester) async {
    await tester.pumpWidget(const ShopApp());

    expect(find.text('Ruang Belanja'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Masuk'), findsOneWidget);
  });

  testWidgets('empty login shows validation errors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ShopApp());
    await tester.tap(find.text('Masuk'));
    await tester.pump();

    expect(find.text('Username wajib diisi'), findsOneWidget);
    expect(find.text('Password wajib diisi'), findsOneWidget);
    expect(find.text('Username atau password salah.'), findsOneWidget);
  });

  testWidgets('specified credentials open the shop', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ShopApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'Lucy Naibaho');
    await tester.enterText(find.byType(TextFormField).at(1), '124240040');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Pilihan untukmu'), findsOneWidget);
    expect(find.text('Ruang Belanja'), findsOneWidget);
    expect(find.text('Username'), findsNothing);
  });

  testWidgets('incorrect credentials are rejected', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ShopApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'mahasiswa');
    await tester.enterText(find.byType(TextFormField).at(1), 'belajar123');
    await tester.tap(find.text('Masuk'));
    await tester.pump();

    expect(find.text('Username tidak sesuai'), findsOneWidget);
    expect(find.text('Password tidak sesuai'), findsOneWidget);
    expect(find.text('Username atau password salah.'), findsOneWidget);
  });
}
