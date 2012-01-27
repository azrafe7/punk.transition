package effects
{
	/**
	 * ...
	 * @author ...
	 */
	public class StarOut extends Star
	{
		public function StarOut(x:Number, y:Number, speed:Number = 10)
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