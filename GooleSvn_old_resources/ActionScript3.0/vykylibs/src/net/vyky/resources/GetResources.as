package net.vyky.resources
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/** 
	 * 说明：若取用的资源不在ApplicationDomain.currentDomain域中，则必须从新通过GetResources.instance.appDomain指定
	 * @author 杨胜金
	 * 2011-9-16 上午09:51:08
	 */
	public class GetResources
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private static var _instance:GetResources;
		
		private var _appDomain:ApplicationDomain;
		
		private const STRING_ALERT_1:String = ": Does not exist.";
		
		
		public function GetResources()
		{
			
		}
		
		/////////////////////////////////////////static /////////////////////////////////

		public static function get instance():GetResources
		{
			if (_instance == null)
			{
				_instance = new GetResources();
			}
			return _instance;
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		/**
		 * 指定资源域
		 */
		public function get appDomain():ApplicationDomain
		{
			if (_appDomain == null)
			{
				_appDomain = ApplicationDomain.currentDomain;
			}
			return _appDomain;
		}
		/**
		 * @private 
		 */
		public function set appDomain(value:ApplicationDomain):void
		{
			_appDomain = value;
		}
		
		public function createObject($name:String):Object
		{
			var obj:Object;
			try
			{
				var clsName:Class = appDomain.getDefinition($name) as Class;
				obj = new clsName();
			}
			catch(e:ReferenceError)
			{
				obj = new MovieClip();
				obj.addChild(birthNewTextfield($name + STRING_ALERT_1));
			}
			return obj;
		}
		
		public function createMovieClip($name:String):MovieClip
		{
			var clip:MovieClip;
			try
			{
				var clsName:Class = appDomain.getDefinition($name) as Class;
				clip = new clsName();
			}
			catch(e:ReferenceError)
			{
				clip = new MovieClip();
				clip.addChild(birthNewTextfield($name + STRING_ALERT_1));
			}
			return clip;
		}
		
		public function createSimpleButton($name:String):SimpleButton
		{
			var simBtn:SimpleButton;
			try
			{
				var clsName:Class = appDomain.getDefinition($name) as Class;
				simBtn = new clsName();
			}
			catch(e:ReferenceError)
			{
				simBtn = new SimpleButton(birthNewTextfield($name + STRING_ALERT_1));
			}
			return simBtn;
		}
		
		public function createSprite($name:String):Sprite
		{
			var spr:Sprite
			try
			{
				var clsName:Class = appDomain.getDefinition($name) as Class;
				spr = new clsName();
			}
			catch(e:ReferenceError)
			{
				spr = new Sprite();
				spr.addChild(birthNewTextfield($name + STRING_ALERT_1));
			}
			return spr;
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function birthNewTextfield($value:String) : TextField
		{
			var textf:* = new TextField();
			textf.defaultTextFormat = new TextFormat("Verdana", 11, 16777215, true);
			textf.text = $value;
			textf.border = true;
			var colors:int = 16777215;
			textf.borderColor = 16777215;
			textf.textColor = colors;
			textf.background = true;
			textf.backgroundColor = 0;
			textf.autoSize = TextFieldAutoSize.LEFT;
			return textf;
		}
	}
}