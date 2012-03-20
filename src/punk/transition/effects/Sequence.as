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