package victor.framework.utils
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class TextFiledUtil
	{
		
		public static function create(font:String, size:uint, color:uint, align:String = TextFormatAlign.LEFT, isBold:Boolean = false, wordWrap:Boolean = false):TextField
		{
			var tfm:TextFormat = new TextFormat();
			tfm.align = align;
			tfm.bold = isBold;
			tfm.color = color;
			tfm.kerning = true;
			tfm.leading = 8;
			tfm.letterSpacing = 2;
			tfm.size = size;
			if ( font )
				tfm.font = font;
			
			var txt:TextField = new TextField();
			txt.defaultTextFormat = tfm;
			txt.selectable = false;
			txt.mouseEnabled = false;
			txt.wordWrap = wordWrap;
			return txt;
		}
		
	}
}