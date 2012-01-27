package 
{
	import effects.*;
	import flash.display.*;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	
	public class Transition
	{
		private var _imageOut:Image;
		private var _imageOutEntity:Entity;
		private var _imageIn:Image;
		private var _imageInEntity:Entity;
		
		private var _out:Effect;
		private var _in:Effect;
		private var _outWorld:World;
		private var _inWorldClass:*;
		private var _inWorld:World;

	
		public function Transition(outWorld:World, inWorld:*, outEffect:Effect, inEffect:Effect):void
		{
			//_imageOut = new Image(FP.buffer);
			//_imageOutEntity = new Entity(0, 0, _imageOut);
			
			//FP.world = goto;
			
			//_imageIn = new Image(FP.buffer);
			//_imageInEntity = new Entity(0, 0, _imageIn);
			//
			_outWorld = outWorld;
			_inWorldClass = inWorld;
			
			_out = outEffect;			
			_out.onComplete = onOut;
			_out.active = true;
			
			_in = inEffect;
			_in.onComplete = onIn;
			
			outWorld.add(_out);			
		}
		
		private function onOut():void 
		{
			_outWorld.remove(_out);
			_out.active = false;
			
			if(_inWorldClass is Class)
			{
				_inWorld = new _inWorldClass() as World;
				FP.world = _inWorld;
			}
			else if(_inWorldClass is World)
			{
				FP.world = _inWorld = _inWorldClass;
			}
			
			_in.active = true;
			_inWorld.add(_in);
		}
		
		private function onIn():void
		{
			_inWorld.remove(_in);
			_in.active = false;
		}
		
		
		
	}

}