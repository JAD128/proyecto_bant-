import 'package:bantu/dominio/servicios/validadores.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validadores', () {
    test('pin acepta entre 4 y 6 digitos', () {
      expect(() => Validadores.pin('1234'), returnsNormally);
      expect(() => Validadores.pin('123456'), returnsNormally);
      expect(() => Validadores.pin('123'), throwsA(isA<ArgumentError>()));
      expect(() => Validadores.pin('1234567'), throwsA(isA<ArgumentError>()));
      expect(() => Validadores.pin('12a4'), throwsA(isA<ArgumentError>()));
    });

    test('dinero rechaza negativos', () {
      expect(() => Validadores.dinero(0, 'valor'), returnsNormally);
      expect(() => Validadores.dinero(-1, 'valor'), throwsA(isA<ArgumentError>()));
    });

    test('fechaLocal exige YYYY-MM-DD', () {
      expect(() => Validadores.fechaLocal('2026-01-01'), returnsNormally);
      expect(
        () => Validadores.fechaLocal('01-01-2026'),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => Validadores.fechaLocal('2026-13-01'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('horaLocal exige HH:mm', () {
      expect(() => Validadores.horaLocal('09:30'), returnsNormally);
      expect(() => Validadores.horaLocal('9:30'), throwsA(isA<ArgumentError>()));
      expect(() => Validadores.horaLocal('25:00'), throwsA(isA<ArgumentError>()));
    });

    test('texto rechaza vacio y demasiado largo', () {
      expect(() => Validadores.texto('Bantú', 'nombre'), returnsNormally);
      expect(() => Validadores.texto('   ', 'nombre'), throwsA(isA<ArgumentError>()));
      expect(
        () => Validadores.texto('x' * 121, 'nombre'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
