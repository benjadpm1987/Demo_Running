package
{
	import flash.display.Sprite;
	
	public class C_Cielo extends Sprite
	{
		public function C_Cielo()
		{
			super();
			f_CrearCielo();
		}
		
		private function f_CrearCielo():void
		{
		var cielo:mc_cielo_full = new mc_cielo_full();
		this.addChild(cielo);	
		}
	}
}