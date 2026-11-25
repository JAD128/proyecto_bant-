import '../../dominio/entidades/gasto.dart';

abstract class GastoRepositorio {
  Future<List<Gasto>> obtenerTodos();

  Future<List<Gasto>> obtenerPorFecha(String fechaLocal);

  Future<Gasto?> obtenerPorId(String id);

  Future<void> guardar(Gasto gasto);

  Future<void> actualizar(Gasto gasto);
}
