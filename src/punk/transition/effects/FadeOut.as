package punk.transition.effects
{
	
	/**
	 * FadeOut effect class. Shorthand for Fade(false, options).
	 * 
	 * @author azrafe7
	 */
	public class FadeOut extends Fade
	{
		
		public function FadeOut(options:Object=null)
		{
			super(false, options);
		}
	}
}