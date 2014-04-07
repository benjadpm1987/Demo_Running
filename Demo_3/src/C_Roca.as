package
{
	import flash.display.Sprite;
	
	public class C_Roca extends Sprite
	{
		public function C_Roca()
		{
			super();
			f_CrearRoca();
		}
		
		private function f_CrearRoca():void
		{
			//
			//var roca_:mc_roca = new mc_roca();
			//this.addChild(roca_);
			var piedra:mc_roca = new mc_roca();
			this.addChild(piedra);
		}
	}
}