import rodados.*
import pedidos.*

// ============================
// DEPENDENCIAS (Etapas 1 y 3 y Extras)
// ============================

class Dependencia {
  var property empleados = 0
  const flota = []
  const pedidos = []
  
  // --- Flota (Etapa 1) ---
  
  method agregarAFlota(rodado) {
    flota.add(rodado)
  }
  
  method quitarDeFlota(rodado) {
    flota.remove(rodado)
  }
  
  method pesoTotalFlota() = flota.sum({ r => r.peso() })
  
  method estaBienEquipada() = flota.size() >= 3 && flota.all({ r => r.velocidadMaxima() >= 100 })
  
  method capacidadTotalEnColor(colorBuscado) {
    return self.rodadosDeColor(colorBuscado).sum({ r => r.capacidad() })
  }
  
  method rodadosDeColor(colorBuscado) = flota.filter({ r => r.color() == colorBuscado })
  
  method colorDelRodadoMasRapido() = flota.max({ r => r.velocidadMaxima() }).color()
  
  method capacidadTotalFlota() = flota.sum({ r => r.capacidad() })
  
  method capacidadFaltante() = 0.max(empleados - self.capacidadTotalFlota())
  
  method esGrande() = empleados >= 40 && flota.size() >= 5
  
  // --- Pedidos (Etapa 3) ---
  
  method agregarPedido(pedido) {
    pedidos.add(pedido)
  }
  
  method quitarPedido(pedido) {
    pedidos.remove(pedido)
  }
  
  method totalPasajerosPedidos() = pedidos.sum({ p => p.cantPasajeros() })
  
  method pedidosNoSatisfacibles() {
    return pedidos.filter({ p => !self.algunoPuedeSatisfacer(p) })
  }
  
  method algunoPuedeSatisfacer(pedido) = flota.any({ r => pedido.puedeSerSatisfechoPor(r) })
  
  method todosRechazanColor(colorBuscado) = pedidos.all({ p => p.coloresIncompatibles().contains(colorBuscado) })
  
  method relajarPedidos() {
    pedidos.forEach({ p => p.relajar() })
  }
  
  // --- Desafíos con colecciones (Extras) ---
  
  method coloresIncompatiblesDeTodos() {
    // flatten() convierte una lista de listas/sets en una lista plana. Luego asSet() quita repetidos.
    return pedidos.map({ p => p.coloresIncompatibles() }).flatten().asSet()
  }
  
  method coloresDeLaFlota() = flota.map({ r => r.color() }).asSet()
  
  method cantidadDeRodadosDeColor(unColor) = flota.count({ r => r.color() == unColor })
  
  method colorMasPopular() = self.coloresDeLaFlota().max({ c => self.cantidadDeRodadosDeColor(c) })
  
  method hayColorRepetido() = self.coloresDeLaFlota().any({ c => self.cantidadDeRodadosDeColor(c) > 1 })
  
  method ordenDeLlegada(vehiculo) {
    // Buscamos manual el índice + 1
    const size = flota.size()
    if (size == 0) return 0
    const indices = (0 .. size - 1)
    const indice = indices.find({ i => flota.get(i) == vehiculo })
    return indice + 1
  }
  
  method vehiculosQueLlegaronAntesQue(vehiculo) {
    const orden = self.ordenDeLlegada(vehiculo)
    if (orden <= 1) return []
    return flota.take(orden - 1)
  }
}
