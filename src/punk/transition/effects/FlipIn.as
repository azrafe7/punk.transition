package punk.transition.effects 
{
	/**
	 * FlipIn effect class. Shorthand for Flip(true, Flip.RIGHT, options).
	 * 
	 * @author azrafe7
	 */
	public class FlipIn extends Flip 
	{
		
		public function FlipIn(flipDir:int=Flip.RIGHT, options:Object=null) 
		{
			super(true, flipDir, options);
		}
		
	}

}