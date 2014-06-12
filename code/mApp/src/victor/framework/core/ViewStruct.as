package victor.framework.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import victor.framework.interfaces.IPanel;
	import victor.framework.utils.Display;
	import victor.framework.utils.appstage;
	
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
		public static const MAIN:uint = numCount++;//主ui层
		public static const SCENE2:uint = numCount++;//场景层2
		public static const CHAT:uint = numCount++;//聊天层
		public static const PANEL:uint = numCount++;//面板弹出层
		public static const CHAT2:uint = numCount++;//聊天层
		public static const EFFECT:uint = numCount++;//特效播放层
		public static const DRAG:uint = numCount++;//对象拖拽层
		public static const LOADING:uint = numCount++;//loading层
		public static const ALERT:uint = numCount++;//警告提示层
		public static const TIPS:int = numCount++;//tips显示层

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
				getContainer( BACKGROUND ).mouseChildren = false;
				getContainer( LOADING ).mouseChildren = false;
				getContainer( EFFECT ).mouseChildren = false;
				getContainer( TIPS ).mouseChildren = false;
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
		public static function addPanel( panel:IPanel, isPenetrate:Boolean = false ):void
		{
			var con:Sprite = getContainer( PANEL ) as Sprite;
			con.mouseEnabled = !isPenetrate;
			if ( con != panel.parent )
				con.addChild( panel as DisplayObject );
			if ( con.numChildren == 1 )
			{
				con.graphics.clear();
				con.graphics.beginFill( 0, 0.01 );
				con.graphics.drawRect( 0, 0, appstage.stageWidth, appstage.stageHeight );
				con.graphics.endFill();
			}
		}
		
		/**
		 * 移除面板
		 * @param panel
		 */
		public static function removePanel( panel:IPanel ):void
		{
			if ( panel && panel.parent )
			{
				var con:Sprite = panelContainer as Sprite;
				con.removeChild( panel as DisplayObject );
				if ( con.numChildren == 0 )
					con.graphics.clear();
			}
		}
		
		/**
		 * 移除所有面板
		 */
		public static function removeAllPanel():void
		{
			while ( panelContainer.numChildren > 0 )
				removePanel( panelContainer.getChildAt( 0 ) as IPanel );
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
				if ( containerType == PANEL )
				{
					addPanel( child as IPanel );
				}
				else
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
						if ( child.parent != spr )
							spr.addChild( child );
					}
				}
			}
		}

		/**
		 * 从显示列表移除显示对象
		 * @param child
		 */
		public static function removeChild( child:DisplayObject ):void
		{
			if ( child )
			{
				if ( child.parent == getContainer( PANEL ) )
					removePanel( child as IPanel );
				else Display.removedFromParent( child );
			}
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
			if ( containerType == PANEL )
			{
				sprite.graphics.clear();
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
		
		public static function get backGroundContainer():DisplayObjectContainer
		{
			return getContainer( BACKGROUND );
		}
		public static function get sceneContainer():DisplayObjectContainer
		{
			return getContainer( SCENE );
		}
		public static function get uiContainer():DisplayObjectContainer
		{
			return getContainer( MAIN );
		}
		public static function get panelContainer():DisplayObjectContainer
		{
			return getContainer( PANEL );
		}
		public static function get effectContainer():DisplayObjectContainer
		{
			return getContainer( EFFECT );
		}
		public static function get loadingContainer():DisplayObjectContainer
		{
			return getContainer( LOADING );
		}
		public static function get alertContainer():DisplayObjectContainer
		{
			return getContainer( ALERT );
		}
		public static function get tipsContainer():DisplayObjectContainer
		{
			return getContainer( TIPS );
		}
		
	}
}
