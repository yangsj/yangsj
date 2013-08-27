package victor.framework.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import victor.framework.utils.DisplayUtil;

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
		public static const BACK_WORD:uint = numCount++;
		public static const UPDATE_PANEL:uint = numCount++;

		private static var container:Sprite;

		private static var backWordEffect:Sprite;

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

		/**
		 * 添加到场景图层显示列表
		 * @param scene
		 */
		public static function addScene( scene:DisplayObject ):void
		{
			removeAll( SCENE );
			addChild( scene, SCENE );
		}

		/**
		 * 添加到面板图层显示列表
		 * @param panel
		 */
		public static function addPanel( panel:DisplayObject ):void
		{
			addChild( panel, PANEL );
		}

		/**
		 * 添加到指定的图层显示列表
		 * @param child
		 * @param containerType
		 * 
		 */
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

		/**
		 * 从显示列表移除显示对象
		 * @param child
		 */
		public static function removeChild( child:DisplayObject ):void
		{
			DisplayUtil.removedFromParent( child );
		}

		/**
		 * 将指定图层子对象全部移除显示列表
		 * @param containerType
		 */
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
		
		/**
		 * 获取指定图层显示容器
		 * @param containerType
		 * @return 
		 */
		public static function getContainer( containerType:uint ):DisplayObjectContainer
		{
			return container.getChildAt( containerType ) as DisplayObjectContainer;
		}


	}
}
