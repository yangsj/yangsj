package net.victor.font
{
	import flash.text.Font;
	
	import net.victor.code.managers.interfaces.IUIResourceManager;
	
	/**
	 * 说明：CharacterStyle
	 * @author 杨胜金<br>
	 * 2012-2-1下午06:07:16
	 */
	
	public class CharacterStyle
	{
		
		/////////////////////////////////static ////////////////////////////
		
		private static var _typeName:String;
		
		///////////////////////////////// vars /////////////////////////////////
		
		
		
		public function CharacterStyle()
		{
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		/**
		 * 字体名称
		 */
		public static function get typeName():String
		{
			if (_typeName == null) _typeName = "宋体";
			return _typeName;
		}

		/**
		 * @private
		 */
		public static function set typeName(value:String):void
		{
			_typeName = value;
		}
		
		public static function setFont($appDomain:IUIResourceManager):void
		{
			if (_typeName) return ;
			//指定文本框显示字体 net.jt_tech.font.TextFieldFontEmbedding 
			var fontType:Class = $appDomain.getDefinition("net.jt_tech.font.TextFieldFontEmbedding") as Class;
			Font.registerFont(fontType);
			var ar:Array = Font.enumerateFonts();
			var ar2:Array = Font.enumerateFonts(true);
			typeName = ar[0].fontName;
			
			//数字 符号 指定字体 net.jt_tech.font.NumberAssignFontEmbedding
			if ($appDomain.hasDefinition("net.jt_tech.font.NumberAssignFontEmbedding"))
			{
				var ftype:Class = $appDomain.getDefinition("net.jt_tech.font.NumberAssignFontEmbedding") as Class;
				Font.registerFont(ftype);
			}
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		

	}
	
}