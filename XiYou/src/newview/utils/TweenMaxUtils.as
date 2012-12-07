package newview.utils
{

	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;


	/**
	 * 说明：TweenMaxUtils
	 * @author Victor
	 * 2012-12-2
	 */

	public class TweenMaxUtils
	{


		public function TweenMaxUtils()
		{
		}

		public static function to( target : Object, duration : Number, vars : Object ) : void
		{
			if ( !vars.hasOwnProperty( "onCompleteListener" ))
				vars.onCompleteListener = onCompleteListener;
			TweenMax.to( target, duration, vars );
		}

		private static function onCompleteListener( event : TweenEvent ) : void
		{
			TweenMax.killTweensOf( event.target.target );
		}


	}

}
