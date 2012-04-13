package punk.transition.effects 
{
	import net.flashpunk.FP;
	/**
	 * Simple Delay effect.
	 * 
	 * @author azrafe7
	 */
	public class Delay extends Effect 
	{
		protected var _time:Number;
		
		/**
		 * Delay effect constructor.
		 * 
		 * @param	time	Amount of time (in secs) to wait.
		 */
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