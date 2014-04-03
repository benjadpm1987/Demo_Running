package
{
	import flash.display.Sprite;
	
	public class C_Enemigo extends Sprite
	{
		
		public function C_Enemigo()
		{
			super();
			f_crearEnemigo();
		}
		
		private function f_crearEnemigo():void
		{
			var enemy:enemigo = new enemigo();
			this.addChild(enemy);
			
		}
	}
}