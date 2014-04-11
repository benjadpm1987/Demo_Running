package
{
	import flash.display.Sprite;
	
	public class C_trampolin extends Sprite
	{
		public function C_trampolin()
		{
			super();
			f_CreARTRAMPOLIN();
		}
		
		private function f_CreARTRAMPOLIN():void
		{
			var trampolin_:plataforma = new plataforma();
			this.addChild(trampolin_);
			
		}
	}
}