package punk.transition.effects 
{
	import net.flashpunk.FP;

	/**
	 * Sequence effect class. Useful for sequencing multiple effects.
	 * 
	 * @author azrafe7
	 */
	public class Sequence extends Combo 
	{
		
		/**
		 * Sequence effect constructor.
		 * @param	... effects		Effects you want to sequence. You can pass Effects, Numbers (indicating a Delay effect) or Arrays. See example below.
		 * 
		 * Example: new Sequence(4, FadeIn, new PixelateIn({ease:Ease.bounceIn}));	// this will create a new Delay effect of 4 secs followed by a FadeIn followed by a PixelateIn effect
		 * Example: new Sequence([StripeFadeIn, new BlurIn({duration:3})]);			// this will create a new StripeFadeIn effect followed by a BlurIn effect which will last 3 secs
		 */
		public function Sequence(... effects) 
		{
			super(effects);
		}
				
		protected function newSequenceCallback(oldCallback:Function, effect:Effect, nextEffect:Effect):Function 
		{
			return function():void {
				_effectsToPlay--;
				if (oldCallback != null && effect.active) oldCallback();
				effect.active = false;
				if (nextEffect) {
					nextEffect.active = true;
					FP.world.add(nextEffect);
				}
			}
		}
		
		// called once the effect gets added to the world
		override public function added():void 
		{
			//adjust callbacks
			for (var i:int = 0; i < _effects.length; i++) {
				var effect:Effect = _effects[i] as Effect;
				var nextEffect:Effect = (i+1) < _effects.length ? _effects[i+1] as Effect : null;
				effect.onComplete = newSequenceCallback(effect.onComplete, effect, nextEffect);
				if (i == 0) effect.active = true;
			}
			
			FP.world.add(_effects[0] as Effect);
			_effectsToPlay = _effects.length;
			
			//super.added();
		}
			
	}

}