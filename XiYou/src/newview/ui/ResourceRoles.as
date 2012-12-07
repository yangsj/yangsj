package newview.ui
{

	import character.FrameLabels;
	import character.PawnAttr;
	
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;


	/**
	 * 说明：ResourceRoles
	 * @author Victor
	 * 2012-11-21
	 */

	public class ResourceRoles
	{
		private static var pool : Dictionary = new Dictionary();

		public function ResourceRoles()
		{
		}

		public static function create( charId : int ) : MovieClip
		{
			var mc : MovieClip = pool[ "pool_" + charId ] as MovieClip;
			if ( mc == null )
			{
				mc = ( new (( Attrs.instance.getAttrById( charId.toString()).uiClass ) as Class )()) as MovieClip;
				mc.addFrameScript( getFrames( mc, FrameLabels.STAND ), function() : void
				{
					mc.gotoAndPlay( FrameLabels.STAND );
				});
				pool[ "pool_" + charId ] = mc;
			}
			mc.scaleX = mc.scaleY = 1;
			mc.gotoAndPlay( FrameLabels.STAND );
			return mc;
		}

		private static function getFrames( mc : MovieClip, frameLabelName : String ) : int
		{
			var labels : Array = mc.currentLabels;
			var length : int = labels.length;
			var i : int = 0;
			for each ( var frameLabel : FrameLabel in labels )
			{
				if ( frameLabel )
				{
					if ( frameLabel.name == frameLabelName )
					{
						if ( i + i >= length ) 
							return mc.totalFrames; 
						else
						{
							frameLabel = labels[ i + 1 ] as FrameLabel;
							return frameLabel.frame - 1;
						}
					}
				}
				i++;
			}
			return 1;
		}


	}

}
