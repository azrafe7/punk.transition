package  
{
	import flash.display.*;
	import flash.system.System;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import punk.transition.*;
	import punk.transition.effects.*;
	
	/**
	 * @author GIT:		cjke 
	 * @author Mail:	cjke.7777@gmail.com
	 */	
	public class WorldTwo extends World 
	{
		[Embed(source="assets/map2.png")]
		private var GFX_MAP:Class;
		
		private var _player:Player;
		
		public function WorldTwo() 
		{
			FP.log("World Two Started");			
			
			var img:Image = new Image(GFX_MAP);
			img.scale = 2;
			addGraphic(img);
			img.x = 50;
			
			_player = new Player(250, 130);
			add(_player);
		}
		
		override public function update():void 
		{
			FP.setCamera(_player.x - 250, 0);
			if(Input.pressed(Key.SPACE))
			{
				FP.world = new WorldOne;
			}
			else if (Input.pressed(Key.LEFT)) 
			{
				FP.camera.x += 10;
			}
			else if (Input.pressed(Key.RIGHT)) 
			{
				FP.camera.x -= 10;
			}
			else if (Input.pressed(Key.UP)) 
			{
				FP.camera.y += 10;
			}
			else if (Input.pressed(Key.DOWN)) 
			{
				FP.camera.y -= 10;
			}
			else if (Input.pressed(Key.ESCAPE)) System.exit(1);
						
			super.update();
		}
		
		public function get player():Player 
		{
			return _player;
		}
		
	}

}