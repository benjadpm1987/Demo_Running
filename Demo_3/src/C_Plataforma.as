package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class C_Plataforma extends Sprite
	{
		private var velocidad_inf:int;
		private var contador:int=0;
		private var flag:Boolean;
		public function C_Plataforma()
			
		{
			super();
			f_CrearPlataforma();
		}
		
		private function f_CrearPlataforma():void
		{
			var plataform:plataforma = new plataforma();
			this.addChild(plataform);
			if(regresarRandom(1,2)==1){
				velocidad_inf=3;
			}else
			{
				velocidad_inf=-3;
			}
			
			plataform.addEventListener(Event.ENTER_FRAME,MoverFrame,false,0,true);
			
			
		}
		
		protected function regresarRandom(Low:int,High:int):int
		{
			return Math.floor(Math.random()*(1+High-Low))+Low;
		}
		
		protected function MoverFrame(event:Event):void
		{
			var t:plataforma = event.target as plataforma;
			t.y+=velocidad_inf;
			
			if(contador<50){
			contador++;	
			}else{
					if(flag==true){
						velocidad_inf=-3;
						flag=false;
					}else{
						velocidad_inf=3;
						flag=true;
					}
					contador=0;		
			}
			
		}
	}
}