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
		private var limite:Number;
		private var m_c:C_PlataformaPiso;
		//-----------------------------------
		
		private var speed:int=10;
		private var speed_:int=10;
		private var parallax:Number=1;
		private var dash_flag:Boolean=false;
		private var dash_flag_rocas:Boolean=false;
		private var retro_flag:Boolean=false;
		//tiempo que la camara esta temblando
		private var total:int=20;
		private var time_each:int=0;
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
			limite=stage.stageHeight -mc_piso.height;
			TweenMax.to(mc_player, 2, {delay:1,x:100,ease:Cubic.easeOut});
			
			this.addChild(mc_player);
			
			this.addEventListener(Event.ENTER_FRAME,InCrementarVelocidad,false,0,true);
		}
		
		protected function InCrementarVelocidad(event:Event):void
		{
			
			time_each++
			if(time_each%100==0){
			speed+=1;	
			speed_++;
			}
			trace(speed);
		}
		
		protected function LanzarEnemigo(event:Event):void
		{
			if(Math.random()>0.95){
				CrearEnemigo(stage.stageWidth,mc_piso.y);
			}
			
			if(Math.random()>0.97){
				if(Math.random()>0.5){
					CrearPLataforma(stage.stageWidth,regresarRandom(250,450));
				}
			}
			
			if(Math.random()>0.99){
				CrearEnemigoVolador(stage.stageWidth,regresarRandom(200,450));
			}
			
			if(Math.random()>0.97){
				if(Math.random()>0.80){
					//speed_
					CrearRoca(regresarRandom(800+(speed_*100),900),-200);						
					/*
					if(dash_flag_rocas==false){
					CrearRoca(regresarRandom(800,900),-200);
					}else{
					CrearRoca(regresarRandom(1000,1200),-200);	
					}*/
				}
			}
			
			//CrearGema
			if(Math.random()>0.97){
				if(regresarRandom(1,2)==1){
				CrearPLataformaVoladora(stage.stageWidth,150);
				}else{
				//Crear la plataforma junto con el trampolin	
				CrearPLataformaVoladora(stage.stageWidth,350);
				CrearTrampolin(stage.stageWidth-125,mc_piso.y);	
				}
				
				if(Math.random()>0.4){
					CrearGema(stage.stageWidth,mc_piso.y-(mc_player.height)*0.25);
				}
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
		
		private function CrearRoca(posX:Number,posY:Number):void
		{
			var roca:C_Roca = new C_Roca();
			roca.x=posX;
			roca.y=posY;
			roca.addEventListener(Event.ADDED_TO_STAGE,LanzarRoca,false,0,true);
			roca.addEventListener(Event.ENTER_FRAME,MoverRoca,false,0,true);
			addChild(roca);
		}
		
		protected function MoverRoca(event:Event):void
		{
			if(event.target.hitTestObject(mc_player)){
			
				//Hacer q el jugador retroceda
				mc_player.x-=Math.ceil(speed*parallax);	
				mc_player._Animacion_impac();
			}else{
				//mc_player.x=100;
				/*if(mc_player.x<90){
				mc_player.x+=Math.ceil(speed*parallax);	
				}*/
				//TweenMax.to(mc_player, 2, {delay:1,x:100,ease:Cubic.easeOut});
				
			}
			event.target.x-=Math.ceil(speed*parallax);	
			if(event.target.hitTestObject(m_c)){
				event.target.y=m_c.y-event.target.height;
				TweenMax.killTweensOf(event.target);
			}
		}
		
		protected function LanzarRoca(event:Event):void
		{
			TweenMax.to(event.target, 1.5, {y:stage.stageHeight-150,ease:Quart.easeIn});
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
		
		
		private function CrearTrampolin(posX:int, posY:int):void
		{
			var m_c:C_trampolin = new C_trampolin();
			m_c.x=posX;
			m_c.scaleX=3.5;
			m_c.scaleY=1;
			m_c.y=posY-m_c.height;
			m_c.addEventListener(Event.ENTER_FRAME,MoverPLataforma,false,0,true);
			addChild(m_c);
		}
		
		private function CrearPLataformaVoladora(posX:int, posY:int):void
		{
			m_c = new C_PlataformaPiso();
			m_c.x=posX;
			m_c.y=posY-m_c.height;
			m_c.scaleX=m_c.scaleY=0.75;
			m_c.addEventListener(Event.ENTER_FRAME,MoverPLataformaVoladora,false,0,true);
			m_c.addEventListener(Event.ENTER_FRAME,MovimientoPlataformaVoladora,false,0,true);
			addChild(m_c);
		}
		
		protected function MoverPLataformaVoladora(event:Event):void
		{
			if(event.target.hitTestObject(mc_player)){
				mainJumping = false;
				mc_player._Animacion_nave();
				mc_player.y=event.target.y-mc_player.height;
				//limite=event.target.y-mc_player.height;	
				
			}else{
				//mainJumping = true;
				limite=stage.stageHeight -mc_piso.height;	
			
			}
			
				
		}
		
		
		
		protected function MovimientoPlataformaVoladora(event:Event):void
		{
			event.target.x-=Math.ceil(speed*parallax);	
		}
		
		private function CrearGema(posX:int, posY:int):void
		{
			var mcgema:C_Gema = new C_Gema();
			mcgema.x=posX;
			mcgema.y=posY-mcgema.height;
			mcgema.scaleX=mcgema.scaleY=1.25;
			mcgema.addEventListener(Event.ENTER_FRAME,MoverGema,false,0,true);
			addChild(mcgema);
		}
		
		protected function MoverGema(event:Event):void
		{
			if(event.target.hitTestObject(mc_player)){
				TweenMax.to(event.target, 0.5, {x:0,y:0,alpha:0,ease:Quart.easeIn});
				if(mc_player.x<100){
				mc_player.x+=10;	
				}
				event.target.removeEventListener(Event.ENTER_FRAME,MoverGema);
				
			}else{
				event.target.x-=Math.ceil(speed*parallax);	
			}
			
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
				//te quita posicion en el eje x
				mc_player.x-=20;	
				mc_player._Animacion_impac();	
				TweenMax.to(event.target, 0.5, {x:mc_player.x,rotation:90,ease:Cubic.easeOut});
				TweenMax.to(event.target, 1, {y:stage.stageHeight+50,ease:Cubic.easeOut});
				stage.addEventListener(Event.ENTER_FRAME,MoverCamara,false,0,true);
				//TweenMax.to(mc_player, 0.5, {y:mc_piso.y-mc_player.height,ease:Cubic.easeOut});
				//limite=stage.stageHeight -mc_piso.height;	
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
				total=20;
				stage.removeEventListener(Event.ENTER_FRAME,MoverCamara)
				speed=speed_;
				mc_player._Animacion_();	
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
			//	mc_player._Animacion_();
			}
			
			if(event.keyCode == 40 || event.keyCode == 83){
				mc_player._Animacion_();
				dash_flag=false;
			}
		}
		
		protected function checkKeysDown(event:KeyboardEvent):void
		{
			if(event.keyCode == 38 || event.keyCode == 87 || event.keyCode == 32 ){
				upKeyDown = true;
			}
			
			if(event.keyCode == 39 || event.keyCode == 68){
				rightKeyDown = true;
			//	mc_player._Animacion_dash()
			}
			if(event.keyCode == 40 || event.keyCode == 83){
				mc_player._Animacion_dash();
				dash_flag=true;
			}
		}
		
		protected function moveChar(event:Event):void
		{
			if(upKeyDown || mainJumping ){
				mainJump();
				
			}
			
		/*	if(rightKeyDown){
				speed=20;
				dash_flag_rocas=true;
				
			}else{
				speed=10;
				dash_flag_rocas=false;
		
			}*/
			
			//Lugar provision
			
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

				if(mc_player.y >= (limite) - mc_player.height){
					mainJumping = false;
					mc_player.y = (limite) - mc_player.height;
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