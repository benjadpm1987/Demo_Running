package
{
	import flash.display.Sprite;
	
	public class C_Ciudad extends Sprite
	{
		public function C_Ciudad()
		{
			super();
			f_CrearCiudad();
		}
		
		private function f_CrearCiudad():void
		{
			var ciudad:mc_cityful = new mc_cityful();
			this.addChild(ciudad);
			
		}
	}
}