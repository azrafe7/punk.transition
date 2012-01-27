package effects
{
	/**
	 * ...
	 * @author ...
	 */
	public class FadeIn extends Fade
	{
		public function FadeIn()
		{
			super();
			_fade.alpha = 0;
		}
		
		override public function render():void
		{
			//fade out			
			_fade.alpha += 0.01;
			
			if (_fade.alpha >= 1)
			{
				_onComplete();
			}
			super.render();		
		}	
	}
}