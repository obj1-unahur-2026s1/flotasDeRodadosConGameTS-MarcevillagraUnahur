import wollok.game.*

// ============================
// DIRECCIONES (Etapa 5)
// ============================

object norte {
  method siguiente(position) = position.up(1)
}

object sur {
  method siguiente(position) = position.down(1)
}

object este {
  method siguiente(position) = position.right(1)
}

object oeste {
  method siguiente(position) = position.left(1)
}

// ============================
// PAREDES
// ============================

class Pared {
  var property resistencia
  var property position
  
  method image() {
    if (resistencia >= 3) return "paredLadrillos3.jpg"
    if (resistencia == 2) return "paredLadrillos2.jpg"
    return "paredLadrillos1.jpg"
  }
  
  method chocar() {
    if (resistencia > 0) {
      resistencia -= 1
    }
    if (resistencia == 0) {
      game.removeVisual(self)
    }
  }
}

// ============================
// REGIONES
// ============================

class RegionRectangular {
  var property xInicial
  var property yInicial
  var property xFinal
  var property yFinal
  
  method contiene(position) = 
       position.x() >= xInicial && position.x() <= xFinal 
    && position.y() >= yInicial && position.y() <= yFinal
    
  method interseccion(otraRegion) {
    return new RegionRectangular(
      xInicial = self.xInicial().max(otraRegion.xInicial()),
      xFinal   = self.xFinal().min(otraRegion.xFinal()),
      yInicial = self.yInicial().max(otraRegion.yInicial()),
      yFinal   = self.yFinal().min(otraRegion.yFinal())
    )
  }
  
  // union() retornaría una región, pero como la unión de dos rectángulos puede no ser rectangular,
  // devolvemos una RegionCompuesta
  method union(otraRegion) = new RegionCompuesta(region1 = self, region2 = otraRegion)
}

class RegionCompuesta {
  var property region1
  var property region2
  
  method contiene(position) = region1.contiene(position) || region2.contiene(position)
}
