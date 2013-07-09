package core.main.systemIcon
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ScreenMouseEvent;
	import flash.net.URLRequest;

	import core.Global;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-9
	 */
	public class SystemIconControl
	{
		private var isMaxWindows:Boolean = true;
		private var playModeSubItem:NativeMenuItem;
		private var settingSubItem:NativeMenuItem;

		public function SystemIconControl()
		{
			init();
		}

		private function init():void
		{
			createSystemIcon();
			Global.stage.addEventListener( MouseEvent.MOUSE_DOWN, stageMouseHandler );
		}

		private function createSystemIcon():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, loadCompleteHandler );
			loader.load( new URLRequest( "icons/image16x16.png" ));
			function loadCompleteHandler( event:Event ):void
			{
				var icon:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;
				var menu:NativeMenu = setSystemMenu()
				icon.bitmaps = new Array( Bitmap( loader.content ).bitmapData );
				icon.menu = menu;
				icon.tooltip = "victor music player";
				icon.addEventListener( ScreenMouseEvent.CLICK, systemIconLeftClickHandler );
				menu.addEventListener( Event.SELECT, menuClickSelectHandler );
			}
		}

		private function setSystemMenu():NativeMenu
		{
			var menu:NativeMenu = new NativeMenu();
			var ary:Array = [];
			// 退出
			ary.unshift( createNativeMenuItem( menu, SystemIconMenuType.EXIT_APPLICATION ));
			// 检查更新
			ary.unshift( createNativeMenuItem( menu, SystemIconMenuType.CHECK_UPDATE ));
			// 设置
			ary.unshift( createNativeMenuItem( menu, SystemIconMenuType.SETTING, SystemIconMenuType.SETTING_SUB ));
			// 播放模式
			ary.unshift( createNativeMenuItem( menu, SystemIconMenuType.PLAY_MODE, SystemIconMenuType.PLAY_MODE_SUB ));

			menu.items = ary;

			return menu;
		}

		private function createNativeMenuItem( menu:NativeMenu, mainName:String, subAry:Array = null ):NativeMenuItem
		{
			if ( subAry )
			{
				var ary:Array = [];
				var item:NativeMenuItem = menu.addSubmenu( new NativeMenu(), mainName );
				for each ( var val:String in subAry )
					ary.push( new NativeMenuItem( val ));
				item.submenu.items = ary;
				return item;
			}
			return new NativeMenuItem( mainName );
		}

		protected function menuClickSelectHandler( event:Event ):void
		{
			var item:NativeMenuItem = event.target as NativeMenuItem;
			if ( item )
			{
				var label:String = item.label;
				if ( label == SystemIconMenuType.EXIT_APPLICATION )
				{
					NativeApplication.nativeApplication.exit();
				}
				else if ( label == SystemIconMenuType.CHECK_UPDATE )
				{
				}
				else if ( SystemIconMenuType.PLAY_MODE_SUB.indexOf( label ) != -1 )
				{
					if ( playModeSubItem )
						playModeSubItem.checked = false;
					playModeSubItem = item;
					playModeSubItem.checked = true;
					if ( label == SystemIconMenuType.PLAY_MODE_SUB_LOOP )
					{
					}
					else if ( label == SystemIconMenuType.PLAY_MODE_SUB_RANDOM )
					{
					}
					else if ( label == SystemIconMenuType.PLAY_MODE_SUB_SINGLE )
					{
					}
				}
				else if ( SystemIconMenuType.SETTING_SUB.indexOf( label ) != -1 )
				{
					if ( settingSubItem )
						settingSubItem.checked = false;
					settingSubItem = item;
					settingSubItem.checked = true;
					if ( label == SystemIconMenuType.SETTING_SUB_AUTO_LOGIN )
					{
						Global.nativeWindow.active;
					}
					else if ( label == SystemIconMenuType.SETTING_SUB_ALWAYS_IN_BACK )
					{
						Global.nativeWindow.alwaysInFront = false;
						Global.nativeWindow.orderToBack();
					}
					else if ( label == SystemIconMenuType.SETTING_SUB_ALWAYS_IN_FRONT )
					{
						Global.nativeWindow.alwaysInFront = true;
						Global.nativeWindow.orderToFront();
					}
				}
			}
		}

		protected function stageMouseHandler( event:MouseEvent ):void
		{
			Global.nativeWindow.startMove();
		}

		protected function systemIconLeftClickHandler( event:ScreenMouseEvent ):void
		{
			if ( isMaxWindows )
				Global.nativeWindow.minimize();
			else
				Global.nativeWindow.restore();
			isMaxWindows = !isMaxWindows;
		}

	}
}
