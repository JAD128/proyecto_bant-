import 'package:intl/intl.dart';

class FormatoMoneda {
  static final NumberFormat _numero = NumberFormat('#,##0', 'es_CO');

  static String cop(int valor) => r'$ ' + _numero.format(valor);
}
