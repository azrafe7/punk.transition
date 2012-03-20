package punk.transition.effects 
{
	/**
	 * StripeFadeOut effect class. Shorthand for StripeFade(false, StripeFade.LEFT, options).
	 * 
	 * @author azrafe7
	 */
	public class StripeFadeOut extends StripeFade 
	{
		
		public function StripeFadeOut(fadeFrom:int=StripeFade.LEFT, options:Object=null) 
		{
			super(false, fadeFrom, options);
		}
		
	}

}