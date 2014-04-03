package
{
	import flash.display.Sprite;
	
	public class C_Enemigo_Volador extends Sprite
	{
		public function C_Enemigo_Volador()
		{
			super();
			f_CrearEnemigoVolador();
		}
		
		private function f_CrearEnemigoVolador():void
		{
			var enemigo_fly:malo2 = new malo2();
			this.addChild(enemigo_fly);
		}
	}
}