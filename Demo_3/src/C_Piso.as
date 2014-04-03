package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class C_Piso extends Sprite
	{
		public function C_Piso()
		{
			super();
			f_crearPiso();
			
		}
		
		private function f_crearPiso():void
		{
			var piso:mc_front_full = new mc_front_full();
			//piso.addEventListener(Event.ENTER_FRAME,MoverPista,false,0,true);
			this.addChild(piso);
			
		}
		
		/*protected function MoverPista(event:Event):void
		{
			trace("Mover Pista");
			
		}*/
	}
}