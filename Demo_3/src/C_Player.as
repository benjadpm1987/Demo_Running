package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class C_Player extends Sprite
	{
		
		private var jugador:mc_jugador;
				
		
		public function C_Player()
		{
			super();
			f_CrearPlayer();
			//this.addEventListener(Eventos.MOSTRAR_A,Animacion_1,false,0,true);
		}
		
		protected function Animacion_1(event:Event):void
		{
			jugador.gotoAndStop(2);
			
		}		
		
		public function Animacion_():void
		{
			jugador.gotoAndStop(2);
			
		}	
		
		public function _Animacion_():void
		{
			jugador.gotoAndStop(1);
			
		}	
		
		public function _Animacion_nave():void
		{
			jugador.gotoAndStop(5);
			
		}	
		
		
		
		private function f_CrearPlayer():void
		{
			jugador = new mc_jugador();
			this.addChild(jugador);
		}
		
		public function _Animacion_dash():void
		{
			jugador.gotoAndStop(3);
			
		}	
		public function _Animacion_impac():void
		{
			jugador.gotoAndStop(4);
			
		}	
		
		
	}
}