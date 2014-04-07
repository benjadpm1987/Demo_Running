package
{
	import flash.display.Sprite;
	
	public class C_Gema extends Sprite
	{
		public function C_Gema()
		{
			super();
			f_CrearGema();
		}
		
		private function f_CrearGema():void
		{
			var gema:mc_gema = new mc_gema();
			this.addChild(gema);
			
		}
	}
}