package punk.transition.effects 
{
	import flash.utils.getTimer;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.World;
	
	public class Effect extends Entity 
	{
		protected static var _autoStart:Boolean = false;

		protected var _startTime:int;

		// callback functions
		protected var _onStart:Function;
		protected var _onComplete:Function;
		
		protected var _elapsed:Number = 0;
		protected var _paused:Boolean;
		protected var _running:Boolean;
		
		protected var _tweens:Vector.<Tween> = new Vector.<Tween>;
		protected var _tweensToComplete:Number;
		
		// default options
		public var options:Object = {
			ease:null,					// ease function (null => linear)
			delay:0,					// delay before starting the effect
			duration:2,					// duration of the effect
			target:FP.buffer,			// object on which the effect will be applied
			position:null				// object holding x and y properties indicating where the effect will be drawn at
		};
		
		
		/**
		 * Set properties of obj assigning defaultObj properties first
		 * 
		 * @param	obj					Object on which properties will be set
		 * @param	defaultObj			Object containing the default properties to assign first
		 * 
		 * @return	the modified object
		 */
		public static function extendProps(obj:Object, defaultObj:Object):Object {
			var prop:*;
			for (prop in defaultObj) {
				//if (!obj.hasOwnProperty(prop)) {
					obj[prop] = defaultObj[prop];
				//}
			}
			return obj;
		}
		
		
		public static function createDelegate(handler:Function, ...args):Function
        {
            return function(...innerArgs):*
            {
                return handler.apply( this, innerArgs.concat(args));
            }
        }
		
		/**
		 * Constructor.
		 */
		public function Effect() 
		{			
			super();
			layer = -1;
			
			// pause until transition manager tells it to get moving
			paused = _autoStart;
			FP.world.add(this);
		}
		
		/**
		 * Use this to add at least one tween to the new effect (preferably in the ctor) before any call to start() is made.
		 * 
		 * Remember to set the type of the tween to PERSIST if you want to use to() and reset() later.
		 * 
		 * @param	t			The tween to add (the first added tween will be considered as the main one).
		 * @param	start		Whether the tween should start right away (overridden by the value of autoStart).
		 * 
		 * @return the added tween.
		 */
		override public function addTween(t:Tween, start:Boolean=false):Tween 
		{
			if (t.active) {
				t.active = _autoStart; // already added via FP.tween()
			} else {
				t = super.addTween(t, _autoStart);	// add the tween
			}
			_tweens.push(t);	// store it in the _tweens vector
			return t;
		}
		
		/**
		 * Start the effect. Or restart it if it's already running.
		 * 
		 * @return this effect for chaining.
		 */
		public function start():Effect 
		{
			if (_tweens.length < 1 && !(this is Combo)) throw new Error("You must add at least one tween to the effect using addTween()!");
			for each (var t:Tween in _tweens) t.start();
			paused = false; 
			_running = true;
			_elapsed = 0;
			_startTime = getTimer();
			trace(this, "started");
			if (_onStart != null) _onStart();
			return this;
		}
		
		/** Reset the effect's tweens. 
		 *
		 * @return this effect for chaining.
		 */
		public function reset():Effect 
		{
			return to(0);
		}
		
		/** Update logic. */
		override public function update():void 
		{
			super.update();
			if (!_running || _tweens.length < 1) return;
			
			if (_running) {
				_elapsed += FP.elapsed;
				_tweensToComplete = _tweens.length;
				for each (var t:Tween in _tweens) 
				{
					if (t.percent == 1) _tweensToComplete--;
				}
				if (_tweensToComplete == 0) finish();
			}
			trace("  ", this, "Running:" + _running, "Elapsed:" + _elapsed.toFixed(2), "Paused:" + paused, "Percent:" + percent.toFixed(2), "RemainingTweens:" + _tweensToComplete);
		}
		
		/** Update effect position if applied to a moving object. */
		override public function render():void 
		{
			if (!options.position && options.target.hasOwnProperty("x") && options.target.hasOwnProperty("y")) options.position = options.target;
			if (options.position && options.position.hasOwnProperty("x") && options.position.hasOwnProperty("y")) {
				x = options.position.x-FP.camera.x;
				y = options.position.y-FP.camera.y;
			}
			super.render();
		}
		
		/** 
		 * Instantly bring the effect percentage completion to the value of percent (the range is [0, 1]). 
		 * 
		 * It simply sets the percentage of all the tweens to percent. Override this function if you want it to behave differently.
		 * 
		 * @param	forceRun		Wheter the effect should be forced to run after it gets brought to percent (defaults to true).
		 * 
		 * @return this effect for chaining.
		 */
		public function to(percent:Number, runAfterwards:Boolean=false):Effect
		{
			_elapsed = 0;
			for each (var t:Tween in _tweens) 
			{
				t.percent = percent;
			}
			trace("To(" + percent.toFixed(2) + ")");
			var tmpRunning:Boolean = _running;
			_running = true;
			update();
			paused = !tmpRunning;
			// activate effect even if not running?
			return (runAfterwards ? forceRun() : this);
		}
		
		/**
		 * Force update even if the effect is not running or is paused (effect must have been already started).
		 * 
		 * @return this effect for chaining.
		 */
		public function forceRun():Effect 
		{
			trace("force");
			paused = false;
			_running = true;
			return this;
		}
		
		/** Paused state of the effect. */
		public function get paused():Boolean { return _paused; }
		
		public function set paused(value:Boolean):void 
		{
			_paused = value;
			for each (var t:Tween in _tweens) 
			{
				t.active = !_paused;
			}
			if (_tweensToComplete > 0) _running = !paused;
			trace("paused:", paused);
		}

		/** 
		 * Pause/unpause the effect. 
		 * 
		 * @param	mustPause		Whether the effect must be paused.
		 * 
		 * @return this effect for chaining.
		 */
		public function pause(mustPause:Boolean=true):Effect 
		{
			paused = mustPause;
			return this;
		}
		
		/** Called when the effect completes. */
		protected function finish():void {
			var sinceStart:Number = (getTimer() - _startTime) / 1000;
			trace(this, "completed in", this.elapsed.toFixed(2), "/", duration.toFixed(2), "(" + sinceStart.toFixed(2) + " since last start() call)");
			_running = false;
			if (_onComplete != null) _onComplete();
		}
		
		
		/** Returns the time (in getTimer() format) when start() was last called. */
		public function get startTime():Number { return _startTime; }
		
		/** Effect's elapsed time (in secs). */
		public function get elapsed():Number { return _elapsed; }
		
		/** Return true if the effect is currently running. */
		public function get isRunning():Boolean { return _running; }
		
		/** Percentage of completion of the effect (based on the main tween completion). Is in the range [0, 1]. */
		public function get percent():Number { return _tweens[0].percent; }
		
		/** Callback function called when the effect is started. */
		public function get onStart():Function { return _onStart; }
		public function set onStart(value:Function):void { _onStart = value; }
		
		/** Callback function called when the effect has completed. */
		public function get onComplete():Function {	return _onComplete; }
		public function set onComplete(value:Function):void { _onComplete = value; }
		
		/** Effect's ease function. */
		public function get ease():Function { return options.ease; }
		public function set ease(func:Function):void { options.ease = func; }
		
		/** Effect's delay time (in secs). */
		public function get delay():Number { return options.delay; }
		public function set delay(time:Number):void { options.delay = time; }
		
		/** Effect's duration (in secs). */
		public function get duration():Number { return options.duration; }
		public function set duration(time:Number):void { options.duration = time; }
		
		/** Target object on which the effect will be applied (defaults to FP.buffer). */
		public function get target():Object { return options.target; }
		public function set target(object:Object):void { options.target = object; }

		/** Position object holding x and y properties indicating where the effect will be drawn at */
		public function get position():Object { return options.position; }
		public function set position(object:Object):void { options.position = object; }

		/** True if the effect should start as soon as it's created. */
		public static function get autoStart():Boolean { return _autoStart; }
		public static function set autoStart(value:Boolean):void { _autoStart = value; }
		
	}
}