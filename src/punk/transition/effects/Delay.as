package punk.transition.effects 
{
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author azrafe7
	 */
	public class Delay extends Effect 
	{
		protected var _time:Number;
		
		public function Delay(time:Number=1) 
		{
			_time = time;
		}
		
		override public function added():void 
		{
			super.added();
			FP.alarm(_time, _onComplete);
		}
	}

}