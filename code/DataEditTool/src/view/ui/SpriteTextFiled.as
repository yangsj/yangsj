package view.ui
{
	import flash.display.Sprite;
	import flash.text.TextField;

	public class SpriteTextFiled extends Sprite
	{
		private var textArea:TextField;

		public function SpriteTextFiled()
		{
			textArea = new TextField();
			addChild( textArea );
			textArea.border = true;
			textArea.multiline = true;
			textArea.wordWrap = true;
			textArea.mouseWheelEnabled = true;
		}

		public function get text():String
		{
			return textArea.text;
		}

		public function set text( value:String ):void
		{
			textArea.text = value;
		}

		public function appendText( value:String ):void
		{
			trace( value );
			textArea.appendText( value );
		}

		public function set htmlText( value:String ):void
		{
			textArea.htmlText = value;
		}

		override public function set width( value:Number ):void
		{
			textArea.width = value;
			super.width = value;
		}

		override public function set height( value:Number ):void
		{
			textArea.height = value;
			super.height = value;
		}



	}
}
