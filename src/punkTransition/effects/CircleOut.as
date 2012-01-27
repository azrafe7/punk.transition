package effects
{
	/**
	 * ...
	 * @author ...
	 */
	public class CircleOut extends Circle
	{
		public function CircleOut(x:Number, y:Number, speed:Number = 10)
		{
			super(x, y, speed);			
			_scale = 10;
		}
		
		override public function render():void
		{
			super.render();
			_scale += _speed;			
			if(_scale > _distance)
			{
				_onComplete();
			}
		}
	}
}