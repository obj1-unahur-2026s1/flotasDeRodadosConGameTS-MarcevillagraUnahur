import wollok.game.*
import colores.*
import game_elementos.*

// ============================
// RODADOS (Etapas 1, 4 y 5)
// ============================

class ChevroletCorsa {
  var property color
  var position = game.at(0,0)
  const posicionesVisitadas = []
  var ultimaDireccion = null
  
  method capacidad() = 4
  method velocidadMaxima() = 150
  method peso() = 1300
  
  // --- Game y Posiciones ---
  
  var posicionAnterior = game.at(0,0)
  
  method image() = color.image()
  
  method position() = position
  
  method position(nuevaPosicion) {
    posicionAnterior = position
    position = nuevaPosicion
    posicionesVisitadas.add(nuevaPosicion)
  }
  
  method deshacerMovimiento() {
    position = posicionAnterior
    if (!posicionesVisitadas.isEmpty()) {
      posicionesVisitadas.remove(posicionesVisitadas.last())
    }
  }
  
  method pasoPor(posicionBuscada) = posicionesVisitadas.contains(posicionBuscada)
  
  method pasoPorFila(numero) = posicionesVisitadas.any({ p => p.x() == numero })
  
  method recorrioFilas(lista) = lista.all({ n => self.pasoPorFila(n) })
  
  method moverseHacia(direccion) {
    ultimaDireccion = direccion
    const nuevaPosicion = direccion.siguiente(position)
    if (self.esPosicionValida(nuevaPosicion)) {
      self.position(nuevaPosicion)
    }
  }
  
  method esPosicionValida(pos) {
    return pos.x().between(0, game.width() - 1) && pos.y().between(0, game.height() - 1)
  }
  
  method repetirUltimoMovimiento() {
    if (ultimaDireccion != null) {
      self.moverseHacia(ultimaDireccion)
    }
  }
  
  method estaEn(region) = region.contiene(position)
}

class RenaultKwid {
  var property tieneTanqueAdicional = false
  
  method color() = azul
  
  method capacidad() {
    if (tieneTanqueAdicional) return 3
    else return 4
  }
  
  method velocidadMaxima() {
    if (tieneTanqueAdicional) return 120
    else return 110
  }
  
  method peso() {
    if (tieneTanqueAdicional) return 1200 + 150
    else return 1200
  }
}

class AutoEspecial {
  var property capacidad
  var property velocidadMaxima
  var property peso
  var property color
}

// ============================
// TRAFIC Y COMPONENTES
// ============================

object trafic {
  var property interior = interiorPopular
  var property motor = motorBataton
  
  method color() = blanco
  
  method capacidad() = interior.capacidad()
  
  method velocidadMaxima() = motor.velocidadMaxima()
  
  method peso() = 4000 + interior.peso() + motor.peso()
}

object interiorComodo {
  method capacidad() = 5
  method peso() = 700
}

object interiorPopular {
  method capacidad() = 12
  method peso() = 1000
}

object motorPulenta {
  method velocidadMaxima() = 130
  method peso() = 800
}

object motorBataton {
  method velocidadMaxima() = 80
  method peso() = 500
}
