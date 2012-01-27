package effects
{
	/**
	 * ...
	 * @author ...
	 */
	public class FadeOut extends Fade
	{
		public function FadeOut()
		{
			super();
			_fade.alpha = 1;
		}
		
		override public function render():void
		{
			//fade out			
			_fade.alpha -= 0.01;
			
			if (_fade.alpha <= 0)
			{
				_onComplete();
			}
			super.render();		
		}	
	}
}