package core.main.systemIcon
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.ScreenMouseEvent;
	import flash.net.URLRequest;

	import core.Global;
	import core.Setting;

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
			createSystemIcon();
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
			var item:NativeMenuItem;
			if ( subAry )
			{
				var ary:Array = [];
				item = menu.addSubmenu( new NativeMenu(), mainName );
				for each ( var val:String in subAry )
				{
					var it:NativeMenuItem = new NativeMenuItem( val );
					it.checked = Setting.getValueBtType( val );
					if ( it.checked )
					{
						if ( mainName == SystemIconMenuType.SETTING )
						{
							if ( val == SystemIconMenuType.SETTING_SUB_ALWAYS_IN_BACK || val == SystemIconMenuType.SETTING_SUB_ALWAYS_IN_FRONT )
								settingSubItem = it;
						}
						else if ( mainName == SystemIconMenuType.PLAY_MODE )
						{
							playModeSubItem = it;
						}
					}
					ary.push( it );
				}
				item.submenu.items = ary;
				return item;
			}
			item = new NativeMenuItem( mainName );
			item.checked = Setting.getValueBtType( mainName );
			return item;
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
						Setting.playLoop = true;
						Setting.playRandom = false;
						Setting.playSingle = false;
					}
					else if ( label == SystemIconMenuType.PLAY_MODE_SUB_RANDOM )
					{
						Setting.playLoop = false;
						Setting.playRandom = true;
						Setting.playSingle = false;
					}
					else if ( label == SystemIconMenuType.PLAY_MODE_SUB_SINGLE )
					{
						Setting.playLoop = false;
						Setting.playRandom = false;
						Setting.playSingle = true;
					}
				}
				else if ( SystemIconMenuType.SETTING_SUB.indexOf( label ) != -1 )
				{
					if ( settingSubItem )
						settingSubItem.checked = false;
					var boo:Boolean = !item.checked;
					if ( label == SystemIconMenuType.SETTING_SUB_AUTO_LOGIN )
					{
						if ( NativeApplication.supportsStartAtLogin )
						{
							try
							{
								Setting.autoLogin = boo;
								item.checked = boo;
								NativeApplication.nativeApplication.startAtLogin = boo;
								return;
							}
							catch ( e:* )
							{
							}
						}
						Setting.autoLogin = false;
						item.checked = false;
					}
					else if ( label == SystemIconMenuType.SETTING_SUB_ALWAYS_IN_BACK )
					{
						item.checked = true;
						settingSubItem = item;
						Global.nativeWindow.alwaysInFront = false;
						Global.nativeWindow.orderToBack();
						Setting.alwaysInBack = true;
						Setting.alwaysInFront = false;
					}
					else if ( label == SystemIconMenuType.SETTING_SUB_ALWAYS_IN_FRONT )
					{
						item.checked = true;
						settingSubItem = item;
						Global.nativeWindow.alwaysInFront = true;
						Global.nativeWindow.orderToFront();
						Setting.alwaysInBack = false;
						Setting.alwaysInFront = true;
					}
					else if ( label == SystemIconMenuType.SETTING_SUB_AUTO_PLAY )
					{
						Setting.autoPlay = boo;
						item.checked = boo;
					}
				}
			}
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
