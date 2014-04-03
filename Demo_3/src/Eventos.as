package
{
	import flash.events.Event;
	
	public class Eventos extends Event
	{
		public static const MOSTRAR_A:String = "mostrar_a";
		public static const MOSTRAR_B:String = "mostrar_b";
		
		public function Eventos(type:String=null)
		{
			super(type);
		}
	}
}