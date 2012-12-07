package utils
{

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;



	public class DebugConsole extends Sprite
	{
		public static const textField : TextField = new TextField();

		public static function show(message : String) : void
		{
			textField.appendText(message + '\n');
		}

		public static function debug(stage : Stage) : void
		{
			textField.cacheAsBitmap = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			stage.addChild(textField);
		}
	}
}
