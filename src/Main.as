package 
{
	import net.flashpunk.*;
	
	/**
	 * @author GIT:		cjke 
	 * @author Mail:	cjke.7777@gmail.com
	 */	
	[SWF(width = "500", height = "500")]
	public class Main extends Engine 
	{		
		public function Main() 
		{
			super(500, 500, 60, false);
			FP.world = new WorldOne;
			FP.console.enable();
		}	
	}	
}