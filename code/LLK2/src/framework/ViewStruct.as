package framework
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	import app.utils.DisplayUtil;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-1
	 */
	public class ViewStruct
	{
		private static var numCount:uint = 0;

		public static const BACKGROUND:uint = numCount++;
		public static const SCENE:uint = numCount++;
		public static const MAIN:uint = numCount++;
		public static const PANEL:uint = numCount++;
		public static const ALERT:uint = numCount++;
		public static const EFFECT:uint = numCount++;

		private static var container:Sprite;

		public function ViewStruct()
		{
		}

		public static function initialize( displayObjectContainer:DisplayObjectContainer ):void
		{
			if ( container == null )
			{
				var sprite:Sprite;
				displayObjectContainer.addChild( container = new Sprite());
				container.mouseEnabled = false;
				for ( var i:uint = 0; i < numCount; i++ )
				{
					sprite = new Sprite();
					sprite.mouseEnabled = false;
					container.addChild( sprite );
				}
			}
		}

		public static function addScene( scene:DisplayObject ):void
		{
			removeAll( SCENE );
			addChild( scene, SCENE );
		}

		public static function addPanel( panel:DisplayObject ):void
		{
			addChild( panel, PANEL );
		}

		public static function addChild( child:DisplayObject, containerType:uint ):void
		{
			if ( child )
			{
				try
				{
					var spr:Sprite = container.getChildAt( containerType ) as Sprite;
				}
				catch ( e:Error )
				{
					throw e;
				}
				if ( spr )
				{
					spr.addChild( child );
				}
			}
		}

		public static function removeChild( child:DisplayObject ):void
		{
			DisplayUtil.removedFromParent( child );
		}

		public static function removeAll( containerType:uint ):void
		{
			try
			{
				var sprite:Sprite = container.getChildAt( containerType ) as Sprite;
			}
			catch ( e:Error )
			{
			}
			if ( sprite )
			{
				sprite.removeChildren();
			}
		}


	}
}
