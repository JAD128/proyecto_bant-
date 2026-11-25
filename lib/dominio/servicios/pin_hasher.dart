import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import 'validadores.dart';

class PinHasher {
  const PinHasher();

  static const int iteraciones = 100000;
  static const int longitudHash = 32;
  static const int longitudSalt = 16;

  Map<String, String> crear(String pin) {
    Validadores.pin(pin);
    final salt = _saltAleatorio();
    final hash = _pbkdf2(pin, salt);
    return {'hash': base64.encode(hash), 'salt': base64.encode(salt)};
  }

  bool verificar({
    required String pin,
    required String hash,
    required String salt,
  }) {
    if (!RegExp(r'^\d{4,6}$').hasMatch(pin)) {
      return false;
    }

    final esperado = base64.decode(hash);
    final calculado = _pbkdf2(pin, base64.decode(salt));
    if (esperado.length != calculado.length) {
      return false;
    }

    var diferencia = 0;
    for (var i = 0; i < esperado.length; i++) {
      diferencia |= esperado[i] ^ calculado[i];
    }
    return diferencia == 0;
  }

  static Uint8List _pbkdf2(String pin, Uint8List salt) {
    final hmac = Hmac(sha256, utf8.encode(pin));
    final bloques = (longitudHash / 32).ceil();
    final salida = <int>[];

    for (var bloque = 1; bloque <= bloques; bloque++) {
      final entrada = <int>[...salt, ..._enteroA4Bytes(bloque)];
      var u = hmac.convert(entrada).bytes;
      final resultado = List<int>.from(u);

      for (var vuelta = 1; vuelta < iteraciones; vuelta++) {
        u = hmac.convert(u).bytes;
        for (var i = 0; i < resultado.length; i++) {
          resultado[i] ^= u[i];
        }
      }

      salida.addAll(resultado.take(longitudHash - salida.length));
    }

    return Uint8List.fromList(salida);
  }

  static List<int> _enteroA4Bytes(int valor) => [
        (valor >> 24) & 0xFF,
        (valor >> 16) & 0xFF,
        (valor >> 8) & 0xFF,
        valor & 0xFF,
      ];

  static Uint8List _saltAleatorio() {
    final aleatorio = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(longitudSalt, (_) => aleatorio.nextInt(256)),
    );
  }
}
