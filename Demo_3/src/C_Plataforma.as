package
{
	import flash.display.Sprite;
	
	public class C_Plataforma extends Sprite
	{
		public function C_Plataforma()
		{
			super();
			f_CrearPlataforma();
		}
		
		private function f_CrearPlataforma():void
		{
			var plataform:plataforma = new plataforma();
			this.addChild(plataform);
			
		}
	}
}