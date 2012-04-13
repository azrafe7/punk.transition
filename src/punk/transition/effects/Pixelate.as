package punk.transition.effects 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.utils.getTimer;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Ease;
	
	/**
	 * Pixelate effect class.
	 * 
	 * @author azrafe7
	 */
	public class Pixelate extends Effect 
	{

		protected var _pixelInfo:Object = {size:1};	// pixel info used by the tween function
		protected var _pixelatedImg:Image;
		protected var _pixelatedBMD:BitmapData;
		protected const _MAX_SCALE:Number = 80;	// default maximum scale value
		
		protected var _pixelateIn:Boolean;	// "direction" of effect

		// options
		protected var _scale:Number = 14;
		protected var _ease:Function = null;	// null => linear
		protected var _duration:Number = 2;
		protected var _delay:Number = 0;
		protected var _smoothing:Boolean = false;
		

		/**
		 * Pixelate effect constructor.
		 * @param	pixelateIn	If true the image will pixelate in. Defaults to false.
		 * @param	options		An object containing key/value pairs of the following optional parameters:
		 * 						duration		Optional number indicating the time (in seconds) the effect will last (approximately). Defaults to 2.
		 * 						ease			Optional easer function. Defaults to linear.
		 * 						delay			Optional number indicating the time (in seconds) the effect must wait before starting (approximately). Defaults to 0.
		 * 						scale			Optional number indicating how much the original image must be scaled up. Defaults to 14.
		 * 						smoothing		Optional boolean indicating whether smoothing must be used. Defaults to false.
		 * 
		 * Example: new Pixelate(true, { ease:Ease.bounceIn, scale:32, smoothing:true });
		 */
		public function Pixelate(pixelateIn:Boolean=false, options:Object=null) 
		{
			super();
			_pixelateIn = pixelateIn;

			if (options) {
				if (options.hasOwnProperty("duration")) _duration = options.duration;
				if (options.hasOwnProperty("ease")) _ease = options.ease;
				if (options.hasOwnProperty("delay")) _delay = options.delay;
				if (options.hasOwnProperty("scale")) _scale = FP.clamp(options.scale, 1, _MAX_SCALE);
				if (options.hasOwnProperty("smoothing")) _smoothing = options.smoothing;
			}
			
			_pixelatedBMD = new BitmapData(FP.width, FP.height, false, FP.screen.color);
			_pixelatedImg = new Image(_pixelatedBMD);
			_pixelatedImg.scrollX = _pixelatedImg.scrollY = 0;
			_pixelInfo.size = pixelateIn ? _scale : 1;	// assign starting pixel size
			graphic = _pixelatedImg;
		}
		
		// called once the effect gets added to the world
		override public function added():void 
		{
			super.added();

			var tweenOptions:Object = { ease:_ease, complete:_onComplete };
			if (_delay > 0) tweenOptions.delay = _delay;
			
			FP.tween(_pixelInfo, { size: _pixelateIn ? 1 : _scale }, _duration, tweenOptions);
		}
		
		override public function render():void 
		{
			var _pixelSize:Number = _pixelInfo.size;
			var tempW:Number = (FP.width / _pixelSize);
			var tempH:Number = (FP.height / _pixelSize);
			var tempBMD:BitmapData = new BitmapData(tempW, tempH, false, FP.screen.color);
			var scaleMatrix:Matrix = new Matrix();
			
			// scale down
			scaleMatrix.scale(1/_pixelSize, 1/_pixelSize);
			tempBMD.draw(FP.buffer, scaleMatrix, null, null, FP.buffer.rect, _smoothing);
			
			// scale back
			scaleMatrix.identity();
			scaleMatrix.scale(_pixelSize, _pixelSize);
			_pixelatedBMD.draw(tempBMD, scaleMatrix, null, null, null, _smoothing);
			_pixelatedImg.updateBuffer();

			super.render();
		}
	}

}