package punk.transition.effects
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * Fade effect class.
	 * 
	 * @author azrafe7
	 */
	public class Fade extends Effect
	{
		protected var _fadeImg:Image;
		
		protected var _fadeIn:Boolean;	// "direction" of effect

		
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
			super();
			_fadeIn = fadeIn;
			
			extendProps(this.options, options);
			if (options) {
				if (!options.hasOwnProperty("color")) this.options.color = FP.screen.color;
			}
			
			_fadeImg = Image.createRect(target.width, target.height, this.options.color);
			_fadeImg.alpha = _fadeIn ? 1 : 0;
			_fadeImg.scrollX = _fadeImg.scrollY = 0;
			
			addGraphic(_fadeImg);

			// add effect tween
			var finalAlpha:Number = _fadeIn ? 0 : 1;
			var tweenOptions:Object = { ease:ease, complete:onComplete, type:PERSIST };
			addTween(FP.tween(_fadeImg, { alpha:finalAlpha }, duration, tweenOptions));
		}

		override public function to(percent:Number, forceRun:Boolean=false):Effect 
		{
			super.to(percent, forceRun);
			_fadeImg.alpha = _fadeIn ? 1 - percent : percent;
			return this;
		}
	}
}