package punk.transition.effects 
{
	/**
	 * FlipOut effect class. Shorthand for Flip(false, Flip.RIGHT, options).
	 * 
	 * @author azrafe7
	 */
	public class FlipOut extends Flip 
	{
		
		public function FlipOut(flipDir:int=Flip.RIGHT, options:Object=null) 
		{
			super(false, flipDir, options);
		}
		
	}

}