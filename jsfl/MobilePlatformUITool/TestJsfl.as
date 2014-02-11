package  
{
	import flash.text.TextFormat;
	import flash.text.TextField;
	import ui.buttons.UIButtonSkin;
	import ui.panel.UIBackground;
	import flash.display.Sprite;


	/**
	 * 资源信息：<br>
	 *			资源文件【F:\yangsj\svnresource\jsfl\MobilePlatformUITool\TestApp.fla】<br>
	 *			元 件 名【元件 3】<br>
	 *			连 接 名【undefined】<br>
	 *
	 * 文档说明： 
	 * @author  
	 */
	public class TestJsfl extends Sprite
	{
		private var _txtTitle:TextField;
		private var _btn1:ui.buttons.UIButtonSkin;
		private var _btn2:ui.buttons.UIButtonSkin;
		private var _panelBg:ui.panel.UIBackground;

		public function TestJsfl()
		{
			super();
			initVars();
		}

		private function initVars():void
		{
			if (_panelBg == null)
			{
				_panelBg	= new ui.panel.UIBackground();
				_panelBg.name	= "_panelBg";
				_panelBg.x	= 0;
				_panelBg.y	= 0;
				_panelBg.width	= 275;
				_panelBg.height	= 200;
				_panelBg.scaleX	= 0.859375;
				_panelBg.scaleY	= 0.8333282470703125;
				_panelBg.alpha	= 1;
				_panelBg.rotation	= 0;
			}
			addChild(_panelBg);

			if (_btn2 == null)
			{
				_btn2	= new ui.buttons.UIButtonSkin();
				_btn2.name	= "_btn2";
				_btn2.x	= 156.5;
				_btn2.y	= 144.15;
				_btn2.width	= 100;
				_btn2.height	= 25;
				_btn2.scaleX	= 1;
				_btn2.scaleY	= 1;
				_btn2.alpha	= 1;
				_btn2.rotation	= 0;
			}
			addChild(_btn2);

			if (_btn1 == null)
			{
				_btn1	= new ui.buttons.UIButtonSkin();
				_btn1.name	= "_btn1";
				_btn1.x	= 18.5;
				_btn1.y	= 144.15;
				_btn1.width	= 100;
				_btn1.height	= 25;
				_btn1.scaleX	= 1;
				_btn1.scaleY	= 1;
				_btn1.alpha	= 1;
				_btn1.rotation	= 0;
			}
			addChild(_btn1);

			if (_txtTitle == null)
			{
				_txtTitle			= new TextField();
				var textFormat0:TextFormat	= new TextFormat();
				textFormat0.bold		= false;
				textFormat0.color	= 0xff0000;
				textFormat0.font	= "微软雅黑";
				textFormat0.size	= "16";
				textFormat0.italic	= false;
				textFormat0.align	= "center";
				textFormat0.leftMargin	= 0;
				textFormat0.rightMargin	= 0;
				textFormat0.leading	= 2;
				textFormat0.indent	= 0;
				_txtTitle.multiline	= false;
				_txtTitle.wordWrap	= false;
				_txtTitle.selectable = false;
				_txtTitle.mouseEnabled = false;
				_txtTitle.defaultTextFormat	= textFormat0;

				_txtTitle.name	= "_txtTitle";
				_txtTitle.x	= 14;
				_txtTitle.y	= 17.4;
				_txtTitle.width	= 247;
				_txtTitle.height	= 25.15;
				_txtTitle.scaleX	= 1;
				_txtTitle.scaleY	= 1;
				_txtTitle.alpha	= 1;
				_txtTitle.rotation	= 0;
			}
			addChild(_txtTitle);

		}

		/**
		* 
		*/
		public function get panelBg():ui.panel.UIBackground
		{
			return _panelBg;
		}

		/**
		* 
		*/
		public function get btn2():ui.buttons.UIButtonSkin
		{
			return _btn2;
		}

		/**
		* 
		*/
		public function get btn1():ui.buttons.UIButtonSkin
		{
			return _btn1;
		}

		/**
		* 
		*/
		public function get txtTitle():TextField
		{
			return _txtTitle;
		}

	}
}