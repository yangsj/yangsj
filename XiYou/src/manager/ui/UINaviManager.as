package manager.ui
{

	import flash.display.DisplayObject;
	import flash.display.Sprite;


	/**
	 * 说明：UINaviManager
	 * @author Victor
	 * 2012-11-12
	 */

	public class UINaviManager
	{
		public static var container : Sprite;

		public function UINaviManager()
		{
		}

		public static function addChild( child : DisplayObject ) : void
		{
			if ( container == null )
				return;
			if ( child )
				container.addChild( child );
			child = null;
		}

		public static function removeChild( child : DisplayObject ) : void
		{
			if ( container == null )
				return;
			if ( child )
			{
				if ( child.parent )
				{
					if ( container == child.parent )
						container.removeChild( child );
					else
						child.parent.removeChild( child );
				}
				child = null;
			}
		}

		public static function removeAll() : void
		{
			if ( container == null )
				return;
			while ( container.numChildren > 0 )
			{
				container.removeChildAt( 0 );
			}
		}


	}

}
