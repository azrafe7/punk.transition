package punk.transition.effects
{
	
	/**
	 * FadeIn effect class. Shorthand for Fade(true, options).
	 * 
	 * @author azrafe7
	 */
	public class FadeIn extends Fade
	{
		
		public function FadeIn(options:Object=null)
		{
			super(true, options);
		}
	}
}