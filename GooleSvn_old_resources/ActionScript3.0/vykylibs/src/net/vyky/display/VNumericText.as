package net.vyky.display
{
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * 说明：NumericText
	 * @author杨胜金
	 * 2011-11-5 上午10:58:18
	 */
	
	public class VNumericText
	{
		public function VNumericText()
		{
		}
		/////////////////////////////////////////static /////////////////////////////////
		
		static public function getNumericText($text:String, $textFormat:TextFormat=null):TextField
		{
			var txtField:TextField = new TextField();
			var txtFormat:TextFormat;
//			txtField.antiAliasType = AntiAliasType.ADVANCED;
//			txtField.sharpness = 400;
			
			if ($textFormat)
			{
				txtFormat = $textFormat;
			}
			else
			{
				txtFormat = new TextFormat();
				txtFormat.color = 0xfff000;
				txtFormat.size = 18;
				txtFormat.bold = true;
				txtFormat.letterSpacing = 2;
			}
			
			txtField.defaultTextFormat = txtFormat;
			txtField.filters = [new GlowFilter(0x000000, 1, 2, 2, 5, 1)];
			
			txtField.text = $text;
			txtField.width = txtField.textWidth + 3;
			txtField.height = txtField.textHeight;
			
			txtField.selectable = false;
			txtField.mouseEnabled = false;
			
			return txtField;
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}