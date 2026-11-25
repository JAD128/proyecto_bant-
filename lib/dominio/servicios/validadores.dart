import '../../utilidades/fechas.dart';

class Validadores {
  static void pin(String valor) {
    if (!RegExp(r'^\d{4,6}$').hasMatch(valor)) {
      throw ArgumentError.value(valor, 'pin', 'Debe tener entre 4 y 6 dígitos.');
    }
  }

  static void texto(String valor, String campo, {int max = 120}) {
    final recortado = valor.trim();
    if (recortado.isEmpty || recortado.length > max) {
      throw ArgumentError.value(valor, campo, 'Texto vacío o demasiado largo.');
    }
  }

  static void descripcion(String? valor, {int max = 500}) {
    if (valor != null && valor.length > max) {
      throw ArgumentError.value(valor, 'descripcion', 'Texto demasiado largo.');
    }
  }

  static void dinero(int valor, String campo) {
    if (valor < 0) {
      throw ArgumentError.value(valor, campo, 'El valor no puede ser negativo.');
    }
  }

  static void fechaLocal(String valor) {
    final fecha = DateTime.tryParse(valor);
    if (fecha == null || Fechas.claveLocal(fecha) != valor) {
      throw ArgumentError.value(valor, 'fechaLocal', 'Formato YYYY-MM-DD inválido.');
    }
  }

  static void horaLocal(String valor) {
    const patron = r'^(\d{2}):(\d{2})$';
    final coincidencia = RegExp(patron).firstMatch(valor);
    if (coincidencia == null) {
      throw ArgumentError.value(valor, 'horaLocal', 'Formato HH:mm inválido.');
    }
    final hora = int.parse(coincidencia.group(1)!);
    final minuto = int.parse(coincidencia.group(2)!);
    if (hora > 23 || minuto > 59) {
      throw ArgumentError.value(valor, 'horaLocal', 'Hora fuera de rango.');
    }
  }
}
