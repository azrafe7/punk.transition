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

		// options
		protected var _ease:Function = null;	// null => linear
		protected var _duration:Number = 2;
		protected var _delay:Number = 0;
		protected var _color:Number = FP.screen.color;
		
		
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
			
			if (options) {
				if (options.hasOwnProperty("duration")) _duration = options.duration;
				if (options.hasOwnProperty("ease")) _ease = options.ease;
				if (options.hasOwnProperty("delay")) _delay = options.delay;
				if (options.hasOwnProperty("color")) _color = options.color;
			}
			
			_fadeImg = Image.createRect(FP.width, FP.height, _color);
			_fadeImg.alpha = _fadeIn ? 1 : 0;
			_fadeImg.scrollX = _fadeImg.scrollY = 0;
			
			addGraphic(_fadeImg);
		}

		// called once the effect gets added to the world
		override public function added():void 
		{
			super.added();
			
			var finalAlpha:Number = _fadeIn ? 0 : 1;
			
			var tweenOptions:Object = { ease:_ease, complete:_onComplete };
			if (_delay > 0) tweenOptions.delay = _delay;
			
			FP.tween(_fadeImg, { alpha:finalAlpha }, _duration, tweenOptions);
		}
	}
}