package punk.transition.effects 
{
	/**
	 * StripeFadeIn effect class. Shorthand for StripeFade(true, StripeFade.RIGHT, options).
	 * 
	 * @author azrafe7
	 */
	public class StripeFadeIn extends StripeFade 
	{
		
		public function StripeFadeIn(fadeFrom:int=StripeFade.RIGHT, options:Object=null) 
		{
			super(true, fadeFrom, options);
		}
		
	}

}