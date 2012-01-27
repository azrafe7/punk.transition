package effects
{
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Fade extends Effect
	{
		protected var _fade:Image;
		
		public function Fade()
		{
			super();
			
			var bm:BitmapData = new BitmapData(FP.width, FP.height, false, 0xFF000000);
			_fade = new Image(bm);
			graphic = _fade;
		}
	}
}