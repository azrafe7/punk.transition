package punk.transition.effects 
{
	import flash.utils.getTimer;
	import net.flashpunk.Entity;
	
	/**
	 * @author GIT:		cjke 
	 * @author Mail:	cjke.7777@gmail.com
	 */
	public class Effect extends Entity 
	{
		protected var _startTime:int;

		protected var _onComplete:Function;
				
		public function Effect() 
		{			
			super();
			layer = -1;
			
			// Pause until transition manager tells it to get moving
			active = false;
		}
		
		override public function added():void 
		{
			_startTime = getTimer();
			super.added();
		}
		
		override public function removed():void 
		{
			var elapsed:Number = (getTimer() - _startTime) / 1000;
			//var expected:String = this.hasOwnProperty("_duration") ? this["_duration"].toFixed(2) : "UNKNOWN";
			trace(this, "removed in", elapsed.toFixed(2));
			super.removed();
		}
		
		public function get onComplete():Function 
		{
			return _onComplete;
		}
		
		public function set onComplete(value:Function):void 
		{
			_onComplete = value;
		}
	}
}