package victor.utils
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-1
	 */
	public class ToolUtil
	{
		public function ToolUtil()
		{
		}
		
		public static function getTextFiled(size:uint, color:uint, align:String = TextFormatAlign.LEFT, wordWrap:Boolean = false):TextField
		{
			var tfm:TextFormat = new TextFormat();
			tfm.align = align;
			tfm.bold = true;
			tfm.color = color;
			tfm.kerning = true;
			tfm.leading = 8;
			tfm.letterSpacing = 2;
			tfm.size = size;
			var txt:TextField = new TextField();
			txt.defaultTextFormat = tfm;
			txt.selectable = false;
			txt.mouseEnabled = false;
			txt.wordWrap = wordWrap;
			return txt;
		}
		
	}
}