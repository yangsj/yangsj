package victor.framework.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import app.utils.appStage;
	
	import victor.framework.utils.DisplayUtil;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-1
	 */
	public class ViewStruct
	{
		private static var numCount:uint = 0;

		public static const BACKGROUND:uint = numCount++;//背景层
		public static const SCENE:uint = numCount++;//场景层
		public static const MAIN:uint = numCount++;//主uiceng
		public static const CHAT:uint = numCount++;//聊天层
		public static const PANEL:uint = numCount++;//面板弹出层
		public static const ALERT:uint = numCount++;//警告提示层
		public static const EFFECT:uint = numCount++;//特效播放层
		public static const DRAG:uint = numCount++;//对象拖拽层
		public static const LOADING:uint = numCount++;//loading层

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
			
			var con:Sprite = getContainer( PANEL ) as Sprite;
			if ( con.numChildren == 1 )
			{
				con.graphics.clear();
				con.graphics.beginFill( 0, 0.01 );
				con.graphics.drawRect( 0, 0, appStage.stageWidth, appStage.stageHeight );
				con.graphics.endFill();
			}
		}
		
		public static function removePanel( panel:DisplayObject ):void
		{
			removeChild( panel );
			
			var con:Sprite = getContainer( PANEL ) as Sprite;
			if ( con.numChildren == 0 )
			{
				con.graphics.clear();
			}
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
