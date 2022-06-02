class Nave {
	var velocidad = 0
	
	method velocidad() = velocidad
		
	method aumentarVelocidad(cantidad) {
		velocidad = (velocidad + cantidad).min(300000)
	} 
	
	method propulsar() {
		self.aumentarVelocidad(20000)	
	}
	
	method preparar() {
		self.aumentarVelocidad(15000)	
	}
	
	method recibirAmenaza()
			
	method encontrarEnemigo(){
		self.recibirAmenaza()
		self.propulsar()
	}
}

class NaveDeCarga inherits Nave{
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}	
}

class NaveDeResiduosRadiactivos inherits NaveDeCarga{
	var property selladaAlVacio = false

	override method recibirAmenaza() {
		velocidad = 0		
	}
	
	override method preparar() {
		super()		
		selladaAlVacio = true
	}
}

class NaveDePasajeros  inherits Nave{
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}
}

class NaveDeCombate  inherits Nave{
	var property modo = reposo
	const property mensajesEmitidos = []

	method velocidad(_velocidad) {
		velocidad = _velocidad
	}
	
	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	override method preparar() {
		super()
		modo.preparar(self)
	}

}

object reposo {
	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}
	
	method preparar(nave) {
		nave.emitirMensaje("Saliendo en misión")
		nave.modo(ataque)
	}
}

object ataque {
	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method preparar(nave) {
		nave.emitirMensaje("Volviendo a la base")
	}
}