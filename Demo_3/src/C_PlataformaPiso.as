package
{
	import flash.display.Sprite;
	
	public class C_PlataformaPiso extends Sprite
	{
		public function C_PlataformaPiso()
		{
			super();
			f_CrearPlataformaPiso();
		}
		
		private function f_CrearPlataformaPiso():void
		{
			var piso_plataforma:mc_Plataforma_Aire = new mc_Plataforma_Aire();
			this.addChild(piso_plataforma);
			
		}
	}
}