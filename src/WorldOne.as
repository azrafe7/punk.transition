package  
{
	import flash.display.*;
	import flash.system.System;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import punk.transition.*;
	import punk.transition.effects.*;
	
	/**
	 * @author GIT:		cjke 
	 * @author Mail:	cjke.7777@gmail.com
	 */	
	public class WorldOne extends World 
	{
		[Embed(source="assets/map1.png")]
		private var GFX_MAP:Class;
		
		private var _img:Image;		
		private var _player:Player;		
		private var _effect:Effect;
		
		private var _infoStr:String = "effect: [effect]\n\n" +
									  "duration: [duration]\n" +
									  "running: [running]\n" +
									  "paused: [paused]\n" +
									  "percent: [percent]\n" +
									  "elapsed: [elapsed]\n" +
									  "";
									  
		private var _info:Text = new Text("", 320, 30, {color: 0xff3366});
		
		public function WorldOne() 
		{
			FP.log("World One Started");
			
			_img = new Image(GFX_MAP);
			_img.scale = 2;
			addGraphic(_img);	
			_img.x = 50;
			
			_player = new Player(250, 390);
			add(_player);
			
			var textEntity:Entity = new Entity(0, 0, _info);
			textEntity.layer = -2;
			_info.scrollX = _info.scrollY = 0;
			add(textEntity);
			
			FP.console.log("S - start | P - pause | T - to(0.5) | R - reset | TAB - info");
		}
		
		override public function update():void 
		{
			FP.setCamera(_player.x - 250, 0);
			// Check which Key has been pressed
			if(Input.pressed(Key.DIGIT_1))
			{
				Transition.track("player");
				Transition.to(WorldTwo, new StarIn(), new StarOut());			
			}
			else if(Input.pressed(Key.DIGIT_2))
			{
				Transition.untrack();
				Transition.to(WorldTwo, new StarIn(FP.halfWidth, FP.halfHeight, 10), new StarOut(FP.halfWidth, FP.halfHeight, 10));			
			}
			else if(Input.pressed(Key.DIGIT_3))
			{
				Transition.track("player");
				Transition.to(WorldTwo, new CircleIn(), new CircleOut());			
			}
			else if(Input.pressed(Key.DIGIT_4))
			{
				Transition.untrack();
				Transition.to(WorldTwo, new CircleIn(FP.halfWidth, FP.halfHeight, 10), new CircleOut(FP.halfWidth, FP.halfHeight, 10));							
			}
			else if(Input.pressed(Key.DIGIT_5))
			{	
				//FP.screen.color = 0x00ff00;
				if (_effect) remove(_effect);
				_effect = new FadeOut( { color: 0x660011, target:FP.buffer } );
				_effect.start();
			}
			else if(Input.pressed(Key.DIGIT_6))
			{				
				// generate random options
				var easeName:String = randEase();
				var easeFunc:Function = Ease[easeName];
				var from:int = FP.rand(StripeFade.BOTTOM + 1);
				var duration:Number = 1 + FP.random * 2.5;
				var stripeDuration:Number = .8 + FP.random * .8;
				var nStripes:int = FP.rand(36) + 1;
				
				var options:Object = { ease:easeFunc, duration:duration, stripeDuration:stripeDuration, numStripes:nStripes };
				FP.log(" StripeFade ", "{ease: "+easeName+", numStripes: "+nStripes+", duration: "+duration.toFixed(2)+"}");
				
				//Transition.to(WorldTwo, new Combo(new PixelateOut(options), new StripeFade(false, from, options)), new Combo(new PixelateIn(options), new StripeFade(true, (from + 2) % 4, options)));
				Transition.to(WorldTwo, new StripeFadeOut, new StripeFadeIn);
			}
			else if(Input.pressed(Key.DIGIT_7))
			{				
				Transition.to(WorldTwo, new PixelateOut, new PixelateIn);
			}
			else if(Input.pressed(Key.DIGIT_8))
			{	
				//Transition.to(WorldTwo, new BlurOut({ease:Ease.cubeIn, blurY:3, blurX:250}), new BlurIn({ease:Ease.cubeIn, blurX:250,blurY:3}));
				Transition.to(WorldTwo, new BlurOut(), new BlurIn ());
			}
			else if(Input.pressed(Key.DIGIT_9))
			{				
				Transition.to(WorldTwo, new FlipOut(), new FlipIn);
			}
			else if(Input.pressed(Key.DIGIT_0))
			{	
				var fadeOut:StripeFadeOut = new StripeFadeOut(StripeFade.LEFT, { duration:4 } );
				fadeOut.onComplete = function ():void 
				{
					trace("faded out");
				}
				//Transition.to(WorldTwo, new Combo(new BlurOut( { blur: 12 } ), PixelateOut, new Sequence(2, FlipOut)), 
				//						new Sequence(new Combo(new BlurOut({duration:0.01}), new PixelateOut({duration:0.01}), new FlipIn), new Combo(new BlurIn({ blur:12 }), PixelateIn)));
				Transition.to(WorldTwo, new Combo(BlurOut, new FadeOut({color:0x3366ff}), new StripeFadeOut(StripeFade.BOTTOM, {ease:Ease.cubeOut}), PixelateOut), new Combo(BlurIn, new FadeIn({color:0xff6633}), new StripeFadeIn(StripeFade.BOTTOM, {ease:Ease.cubeIn}), PixelateIn));
				//Transition.to(WorldTwo, new Combo(BlurOut, new StripeFadeOut(StripeFade.BOTTOM, {color:0x3366ff}), new StripeFadeOut(StripeFade.BOTTOM, {ease:Ease.cubeOut}), PixelateOut), new Combo(BlurIn, new StripeFadeIn(StripeFade.BOTTOM, {color:0xff6633}), new StripeFadeIn(StripeFade.BOTTOM, {ease:Ease.cubeIn}), PixelateIn));
				//Transition.to(WorldTwo, new Sequence(PixelateOut, FlipOut), new Sequence(new Combo(new PixelateOut({duration:0.01}), FlipIn), PixelateIn));
			}
			else if(Input.pressed(Key.Z))
			{	
				//FP.screen.color = 0;
				//Transition.to(WorldTwo, new RotoZoom(false, {ease:Ease.cubeIn, rotoEase:Ease.sineIn, rotations:5, zoomOut:100000}), new RotoZoom(true, {ease:Ease.cubeOut, zoomOut:100000, rotoEase:Ease.sineOut}));
				Transition.to(WorldTwo, new Combo(new FadeOut({delay:1}), PixelateOut, new RotoZoomOut({delay:1, ease:Ease.expoIn, rotations:3, rotoEase:Ease.cubeIn})), new Combo(new PixelateIn({delay:1}), new RotoZoomIn({ease:Ease.expoOut, rotations:3, rotoEase:Ease.cubeOut}), new FadeIn()));
			}
			
			// effect commands
			if (_effect) {
				if (Input.pressed(Key.P)) 
				{
					_effect.paused = !_effect.paused;
				}
				else if (Input.pressed(Key.S)) 
				{
					_effect.start();
				}
				else if (Input.pressed(Key.T)) 
				{
					_effect.to(.5);
				}
				else if (Input.pressed(Key.R)) 
				{
					_effect.reset();
				}
			}
			
			if (Input.check(Key.ESCAPE)) System.exit(1);
			
			if (Input.pressed(Key.TAB)) _info.visible = !_info.visible;
			
			if (_info.visible) {
				if (_effect) {
				_info.text =  _infoStr.replace("[effect]", _effect)
									  .replace("[duration]", _effect.duration.toFixed(2))
									  .replace("[running]", _effect.isRunning)
									  .replace("[paused]", _effect.paused)
									  .replace("[percent]", _effect.percent.toFixed(2))
									  .replace("[elapsed]", _effect.elapsed.toFixed(2));
				} else {
					_info.text = "Effect: none";
				}
			}
			
			super.update();
		}
		
		// randomly choose an Ease function and return its name
		public static function randEase():String {
			var easeFunctions:Array = describeType(Ease).method.@name.toXMLString().split("\n");
			
			var idx:int = FP.rand(easeFunctions.length+1);
			if (idx < easeFunctions.length) return easeFunctions[idx];
			else return null;
		}
		
		public function get player():Player 
		{
			return _player;
		}		
		
	}
}