// ============================
// PEDIDOS (Etapa 2)
// ============================

class Pedido {
  var property distancia
  var property tiempoMaximo
  var property cantPasajeros
  var property coloresIncompatibles = #{} // Usamos un Set para los colores
  
  method velocidadRequerida() = distancia / tiempoMaximo
  
  method puedeSerSatisfechoPor(auto) {
    return auto.velocidadMaxima() >= (self.velocidadRequerida() + 10) 
        && auto.capacidad() >= cantPasajeros 
        && !coloresIncompatibles.contains(auto.color())
  }
  
  method acelerar() {
    tiempoMaximo -= 1
  }
  
  method relajar() {
    tiempoMaximo += 1
  }
}
