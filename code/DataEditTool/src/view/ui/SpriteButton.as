package view.ui
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class SpriteButton extends Sprite
	{
		private var txtLabel:TextField;
		private var shape1:Shape;
		private var shape2:Shape;

		public function SpriteButton()
		{
			shape1 = getBtn( 0xff0000 );
			shape2 = getBtn( 0x666666 );

			addChild( shape1 );
			addChild( shape2 );

			var tfm:TextFormat = new TextFormat();
			tfm.align = TextFormatAlign.CENTER;
			txtLabel = new TextField();
			txtLabel.defaultTextFormat = tfm;
			txtLabel.height = 20;
			txtLabel.width = 100;
			txtLabel.y = 1;
			addChild( txtLabel );

			this.mouseChildren = false;
			this.buttonMode = true;

			enabled = false;
		}

		public function set enabled( value:Boolean ):void
		{
			shape1.visible = value;
			shape2.visible = !value;
			this.mouseEnabled = value;
		}

		public function set label( value:String ):void
		{
			txtLabel.text = value;
		}

		private function getBtn( color:uint ):Shape
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill( color );
			shape.graphics.drawRect( 0, 0, 100, 22 );
			shape.graphics.endFill();
			return shape;
		}

	}
}
