import 'dart:convert';

import 'package:bantu/dominio/servicios/pin_hasher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const hasher = PinHasher();

  group('PinHasher', () {
    test('crea hash y salt con longitudes esperadas', () {
      final datos = hasher.crear('1234');

      expect(base64.decode(datos['hash']!).length, PinHasher.longitudHash);
      expect(base64.decode(datos['salt']!).length, PinHasher.longitudSalt);
    });

    test('verifica el PIN correcto', () {
      final datos = hasher.crear('1234');
      final verificacion = hasher.verificar(
        pin: '1234',
        hash: datos['hash']!,
        salt: datos['salt']!,
      );

      expect(verificacion, isTrue);
    });

    test('rechaza PIN incorrecto', () {
      final datos = hasher.crear('1234');
      final verificacion = hasher.verificar(
        pin: '9999',
        hash: datos['hash']!,
        salt: datos['salt']!,
      );

      expect(verificacion, isFalse);
    });

    test('rechaza PIN no numerico al verificar', () {
      final datos = hasher.crear('1234');
      final verificacion = hasher.verificar(
        pin: 'abc',
        hash: datos['hash']!,
        salt: datos['salt']!,
      );

      expect(verificacion, isFalse);
    });

    test('rechaza PIN invalido al crear', () {
      expect(() => hasher.crear('12'), throwsA(isA<ArgumentError>()));
    });
  });
}
