import 'dart:math';

String generateRandomToken(int length) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
          (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ),
  );
}
