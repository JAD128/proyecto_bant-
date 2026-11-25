import 'package:bantu/dominio/entidades/item_carrito.dart';
import 'package:bantu/dominio/entidades/producto.dart';
import 'package:bantu/dominio/servicios/calculador_pedido.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/dominio/valores/modalidad_pedido.dart';
import 'package:flutter_test/flutter_test.dart';

Producto producto({
  String id = 'p1',
  int precioLocal = 1000,
  int? precioLlevar,
  int costoEmpaque = 0,
  EstrategiaLlevar estrategia = EstrategiaLlevar.baseMasEmpaque,
  bool activo = true,
}) {
  final ahora = DateTime.utc(2026, 1, 1, 12);
  return Producto(
    id: id,
    categoriaId: 'c1',
    nombre: 'Producto $id',
    precioLocal: precioLocal,
    precioLlevar: precioLlevar,
    costoEmpaque: costoEmpaque,
    estrategiaLlevar: estrategia,
    activo: activo,
    creadoEn: ahora,
    actualizadoEn: ahora,
  );
}

void main() {
  const calculador = CalculadorPedido();

  group('CalculadorPedido', () {
    test('modalidad local ignora el costo de empaque', () {
      final resultado = calculador.calcular([
        ItemCarrito(producto: producto(costoEmpaque: 500), cantidad: 2),
      ]);

      expect(resultado.lineas, hasLength(1));
      expect(resultado.lineas.single.precioUnitario, 1000);
      expect(resultado.lineas.single.costoEmpaqueUnitario, 0);
      expect(resultado.subtotal, 2000);
      expect(resultado.costoEmpaque, 0);
      expect(resultado.total, 2000);
    });

    test('precioFijo no suma el empaque encubierto', () {
      final resultado = calculador.calcular([
        ItemCarrito(
          producto: producto(
            precioLlevar: 3500,
            costoEmpaque: 500,
            estrategia: EstrategiaLlevar.precioFijo,
          ),
          cantidad: 2,
          modalidad: ModalidadPedido.llevar,
        ),
      ]);

      expect(resultado.lineas.single.precioUnitario, 3500);
      expect(resultado.lineas.single.costoEmpaqueUnitario, 0);
      expect(resultado.subtotal, 7000);
      expect(resultado.costoEmpaque, 0);
      expect(resultado.total, 7000);
    });

    test('baseMasEmpaque suma precio local y empaque', () {
      final resultado = calculador.calcular([
        ItemCarrito(
          producto: producto(precioLocal: 1000, costoEmpaque: 300),
          cantidad: 3,
          modalidad: ModalidadPedido.llevar,
        ),
      ]);

      expect(resultado.lineas.single.precioUnitario, 1000);
      expect(resultado.lineas.single.costoEmpaqueUnitario, 300);
      expect(resultado.subtotal, 3000);
      expect(resultado.costoEmpaque, 900);
      expect(resultado.total, 3900);
    });

    test('suma varias lineas con modalidades mixtas', () {
      final resultado = calculador.calcular([
        ItemCarrito(producto: producto(costoEmpaque: 500), cantidad: 2),
        ItemCarrito(
          producto: producto(id: 'p2', precioLocal: 2000, costoEmpaque: 300),
          cantidad: 3,
          modalidad: ModalidadPedido.llevar,
        ),
      ]);

      expect(resultado.subtotal, 8000);
      expect(resultado.costoEmpaque, 900);
      expect(resultado.total, 8900);
    });

    test('rechaza carrito vacio', () {
      expect(() => calculador.calcular(const []), throwsA(isA<ArgumentError>()));
    });

    test('rechaza cantidad menor o igual a cero', () {
      expect(
        () => calculador.calcular([
          ItemCarrito(producto: producto(), cantidad: 0),
        ]),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('rechaza producto inactivo', () {
      expect(
        () => calculador.calcular([
          ItemCarrito(producto: producto(activo: false), cantidad: 1),
        ]),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('rechaza producto duplicado', () {
      expect(
        () => calculador.calcular([
          ItemCarrito(producto: producto(), cantidad: 1),
          ItemCarrito(producto: producto(), cantidad: 2),
        ]),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('rechaza precioFijo sin precio para llevar', () {
      expect(
        () => calculador.calcular([
          ItemCarrito(
            producto: producto(estrategia: EstrategiaLlevar.precioFijo),
            cantidad: 1,
            modalidad: ModalidadPedido.llevar,
          ),
        ]),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
