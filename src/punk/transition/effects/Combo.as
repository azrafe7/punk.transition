package punk.transition.effects 
{
	import net.flashpunk.FP;

	/**
	 * Combo effect class. Useful for combining multiple effects.
	 * 
	 * @author azrafe7
	 */
	public class Combo extends Effect 
	{
		protected var _effects:Vector.<Effect> = new Vector.<Effect>;
		protected var _effectsToPlay:int;
		
		public function Combo(... effects) 
		{
			if (effects.length > 0) addEffects.apply(null, effects);
		}
		
		protected function addEffectsToVec(targetVec:Vector.<Effect>, ... effects):void 
		{
			var effect:Effect;
			if (effects.length == 0) return;
			
			for (var e:int = 0; e < effects.length; e++) {
				var obj:Object = effects[e];
				if (obj is Vector.<Object> || obj is Array) {
					addEffectsToVec.apply(null, [targetVec].concat(obj));
				} else if (obj) {
					if (obj is Number) {
						effect = new Delay(Number(obj));
					} else if (obj is Class) {
						effect = new obj();
					} else if (obj is Effect) {
						effect = Effect(obj);
					}
					effect.active = false;
					targetVec.push(effect);
				}
			}
		}

		public function addEffects(... effects):Combo 
		{
			addEffectsToVec.apply(null, [_effects].concat(effects));
			return this;
		}
		
		protected function newComboCallback(oldCallback:Function, effect:Effect):Function 
		{
			return function():void {
				//trace(effect);
				_effectsToPlay--;
				if (oldCallback != null && effect.active) oldCallback();
				effect.active = false;
			}
		}
				
		override public function added():void 
		{
			//adjust callbacks
			for (var i:int = 0; i < _effects.length; i++) {
				var effect:Effect = _effects[i] as Effect;
				effect.onComplete = newComboCallback(effect.onComplete, effect);
				effect.active = true;
				FP.world.add(effect);
			}
			
			_effectsToPlay = _effects.length;
			
			super.added();
		}
		
		override public function render():void 
		{
			if (active && _effectsToPlay == 0) {
				for (var i:int = 0; i < _effects.length; i++) FP.world.remove(_effects[i] as Effect);
				_onComplete();
				active = false;
			}
			super.render();
		}
		
	}

}