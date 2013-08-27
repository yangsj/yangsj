package victor.framework.utils
{
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class MovieClipUtil
	{
		public function MovieClipUtil()
		{
		}

		public static function playMovieClip( mc:MovieClip, completeCall:Function = null, completeCallParams:* = null ):void
		{
			if ( mc )
			{
				mc.addEventListener( Event.ENTER_FRAME, frameCompleteHandler );
				mc.gotoAndPlay( 1 );
			}
			function frameCompleteHandler( event:Event ):void
			{
				if ( mc.currentFrame == mc.totalFrames )
				{
					mc.stop();
					mc.removeEventListener( Event.ENTER_FRAME, frameCompleteHandler );
					safetyCall( completeCall, completeCallParams );
				}
			}
		}

	}
}
