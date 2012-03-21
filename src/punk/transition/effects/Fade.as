package punk.transition.effects
{
	
	/**
	 * Fade effect class.
	 * 
	 * @author azrafe7
	 */
	public class Fade extends StripeFade
	{
		
		/**
		 * Fade effect constructor.
		 * @param	fadeIn		If true the stripes will fade in. Defaults to false.
		 * @param	options		An object containing key/value pairs of the following optional parameters:
		 * 						duration		Optional number indicating the time (in seconds) the effect will last (approximately). Defaults to 2.
		 * 						ease			Optional easer function. Defaults to linear.
		 * 						color			Optional color of stripes. Defaults to FP.screen.color.
		 * 
		 * Example: new Fade(true, { ease:Ease.bounceIn, duration:1.5, color:0xFF3366});
		 */
		public function Fade(fadeIn:Boolean=false, options:Object=null)
		{
			if (!options) options = { };
			options.numStripes = 1;
			options.stripeEase = options.ease || null;
			options.stripeDuration = options.duration || 2;
			options.ease = null;
			super(fadeIn, StripeFade.LEFT, options);
		}
	}
}