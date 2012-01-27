package effects
{
	/**
	 * ...
	 * @author ...
	 */
	public class CircleIn extends Circle
	{
		public function CircleIn(x:Number, y:Number, speed:Number = 10)
		{
			super(x, y, speed);
			_scale = _distance;	
		}
		
		override public function render():void
		{
			super.render();	
			_scale -= _speed;			
			if(_scale < _speed)
			{
				_onComplete();
			}	
		}	
	}
}