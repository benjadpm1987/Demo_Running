package
{
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;


	[SWF(frameRate="24",width="800",height="600",backgroundColor="#0099FF")]
	public class Main extends Sprite
	{
		//private var mc_piso:mc_front_full;
		private var mc_piso:C_Piso;
		private var mc_ciudad:C_Ciudad;
		private var mc_cielo:C_Cielo;
		private var mc_player:C_Player;
		//-----------------------------------
		
		private var speed:int=10;
		private var parallax:Number=1;
		private var dash_flag:Boolean=false;
		//tiempo que la camara esta temblando
		private var total:int=30;
		//-----------------------------------
		
		private var upKeyDown:Boolean = false;	
		private var rightKeyDown:Boolean = false;
		//----------------------------------
		private var mainJumping:Boolean = false;
		private var jumpSpeedLimit:int=18;
		private var jumpSpeed:Number = jumpSpeedLimit;
		//----------------------------------
		
		public function Main()
		{
			CrearCiudad();
		}
		
		private function CrearCiudad():void
		{
			this.addEventListener(Event.ENTER_FRAME,MoverTodo,false,0,true);
			
			this.addEventListener(Event.ENTER_FRAME,moveChar,false,0,true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown,false,0,true);
			stage.addEventListener(KeyboardEvent.KEY_UP, checkKeysUp,false,0,true);
			
			this.addEventListener(Event.ENTER_FRAME,LanzarEnemigo,false,0,true);
			
			mc_cielo = new C_Cielo();
			this.addChild(mc_cielo);
			
			mc_piso = new C_Piso();
			mc_piso.y= stage.stageHeight-mc_piso.height;
			this.addChild(mc_piso);
			
			mc_ciudad = new C_Ciudad();
			mc_ciudad.y=mc_piso.height;
			this.addChild(mc_ciudad);
			
			mc_player = new C_Player();
			mc_player.x=0-mc_player.width;
			mc_player.y=mc_piso.y-mc_player.height;
			
			//tweenmax
			TweenMax.to(mc_player, 2, {delay:1,x:100,ease:Cubic.easeOut});
			
			this.addChild(mc_player);
		}
		
		protected function LanzarEnemigo(event:Event):void
		{
			if(Math.random()>0.95){
				CrearEnemigo(stage.stageWidth,mc_piso.y);
			}
			
			if(Math.random()>0.97){
				if(Math.random()>0.5){
					CrearPLataforma(stage.stageWidth,regresarRandom(250,450))	
				}
			}
			
			if(Math.random()>0.99){
				CrearEnemigoVolador(stage.stageWidth,regresarRandom(200,450))	
			}
			
		}
		
		private function CrearEnemigo(posX:int, posY:Number):void
		{
			var mc:C_Enemigo = new C_Enemigo();
			
			mc.x=posX;
			mc.scaleX=mc.scaleY=2;
			mc.y=posY-mc.height;
			
			mc.addEventListener(Event.ENTER_FRAME,MoverEnemigo,false,0,true);
			addChild(mc);
			
		}
		
		private function CrearPLataforma(posX:int, posY:int):void
		{
			var m_c:C_Plataforma = new C_Plataforma();
			m_c.x=posX;
			m_c.scaleX=4.5;
			m_c.scaleY=0.95;
			m_c.y=posY-m_c.height;
			m_c.addEventListener(Event.ENTER_FRAME,MoverPLataforma,false,0,true);
			addChild(m_c);
		}
		
		private function CrearEnemigoVolador(posX:int, posY:int):void
		{
						
			var mc_:C_Enemigo_Volador = new C_Enemigo_Volador();
			mc_.x=posX;
			mc_.scaleX=mc_.scaleY=2.5;
			mc_.y=posY-mc_.height;
			mc_.addEventListener(Event.ENTER_FRAME,MoverEnemigo);
			addChild(mc_);
			//----------
		
		}
		
		protected function MoverPLataforma(event:Event):void
		{
			if(event.target.hitTestObject(mc_player)){
				
				event.target.removeEventListener(Event.ENTER_FRAME,MoverPLataforma)
				//hacer que salte el jugador	
				mainJumping=false;
				mainJump();
				TweenMax.to(event.target, 1, {x:event.target.x-100,alpha:0,y:stage.stageHeight,ease:Cubic.easeOut});
				
			}
			
			if(event.target.x<-stage.stageWidth){
				event.target.removeEventListener(Event.ENTER_FRAME,MoverPLataforma)
			}else{
				event.target.x-=Math.ceil(speed*parallax);	
			}
			
		}
		
		protected function MoverEnemigo(event:Event):void
		{
			if(event.target.hitTestObject(mc_player)){
				
				event.target.removeEventListener(Event.ENTER_FRAME,MoverEnemigo)
				if(dash_flag==true){
				TweenMax.to(event.target, 1, {x:stage.stageWidth+100,y:regresarRandom(0,300),rotation:360,ease:Cubic.easeOut});
				}else{
				TweenMax.to(event.target, 1, {x:event.target.x+25,y:stage.stageHeight*1.25,rotation:90,ease:Cubic.easeOut});
				stage.addEventListener(Event.ENTER_FRAME,MoverCamara,false,0,true);
				}
				//removeChild(event.target as enemigo);
				
			}
			
			if(event.target.x<-stage.stageWidth){
				event.target.removeEventListener(Event.ENTER_FRAME,MoverEnemigo)
			}else{
				event.target.x-=Math.ceil(speed*parallax);	
			}
			
			
		}
		
		
		
		protected function MoverCamara(event:Event):void
		{
			if(total>0){
				total--
				CameraShake();
				speed*=0.5;
			}else{
				this.x=0;
				total=30;
				stage.removeEventListener(Event.ENTER_FRAME,MoverCamara)
				speed=10
			}
		}
		
		protected function CameraShake():void
		{
			this.x=Math.random()*total;
			this.y=Math.random()*total;
		}		
		
		protected function regresarRandom(Low:int,High:int):int
		{
			return Math.floor(Math.random()*(1+High-Low))+Low;
		}
		
		protected function checkKeysUp(event:KeyboardEvent):void
		{
			if(event.keyCode == 38 || event.keyCode == 87 || event.keyCode == 32){
				upKeyDown = false;
			}
			
			if(event.keyCode == 39 || event.keyCode == 68){
				rightKeyDown = false;
			}
		}
		
		protected function checkKeysDown(event:KeyboardEvent):void
		{
			if(event.keyCode == 38 || event.keyCode == 87 || event.keyCode == 32 ){
				upKeyDown = true;
			}
			
			if(event.keyCode == 39 || event.keyCode == 68){
				rightKeyDown = true;
			}
		}
		
		protected function moveChar(event:Event):void
		{
			if(upKeyDown || mainJumping ){
				mainJump();
				trace("Salto");
			}
			
			if(rightKeyDown){
				speed=20;
				dash_flag=true;
			}else{
				speed=10;
				dash_flag=false;
			}
			
		}
		
		private function mainJump():void
		{
			
			if(!mainJumping){	
				
				//---------------------------
				mc_player.Animacion_();
				//---------------------------
				
				mainJumping = true;
				jumpSpeed = jumpSpeedLimit*-1;
				mc_player.y += jumpSpeed;		
			} else {

				if(jumpSpeed < 0){
					jumpSpeed *= 1 - jumpSpeedLimit/250;
					if(jumpSpeed > -jumpSpeedLimit/5){
						jumpSpeed *= -1;
					}
				}
				if(jumpSpeed > 0 && jumpSpeed <= jumpSpeedLimit){
					jumpSpeed *= 1 + jumpSpeedLimit/20;
				}
				mc_player.y += jumpSpeed;

				if(mc_player.y >= (stage.stageHeight -mc_piso.height) - mc_player.height){
					mainJumping = false;
					mc_player.y = (stage.stageHeight -mc_piso.height) - mc_player.height;
					mc_player._Animacion_();								   			
					
				}
			}
			
		}
		
		protected function MoverTodo(event:Event):void
		{
			
			mc_piso.x-=Math.ceil(speed*parallax);
			if(mc_piso.x<-stage.stageWidth)mc_piso.x=0;
			
			mc_ciudad.x-=Math.ceil(speed*(parallax*0.5));
			if(mc_ciudad.x<-stage.stageWidth)mc_ciudad.x=0;
			
			mc_cielo.x-=Math.ceil(speed*((parallax*0.5)*0.5));
			if(mc_cielo.x<-stage.stageWidth)mc_cielo.x=0;
			
		}
	}
}