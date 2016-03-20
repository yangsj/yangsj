package app.chapter_07
{
	import code.SpriteBase;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	/**
	 * 说明：Container3D
	 * @author victor
	 * 2012-8-20 上午1:14:13
	 */
	
	public class Container3D extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _sprite:Sprite;
		private var _n:Number = 0;
		
		public function Container3D()
		{
			super();
		}
		
		override protected function initialization():void
		{
			if (_sprite == null) 
			{
				_sprite = new Sprite();
			}
			while (_sprite.numChildren > 0) _sprite.removeChildAt(0);
			_sprite.y = stage.stageHeight * 0.5;
			for (var i:int = 0; i < 100; i++)
			{
				var tf:TextField = new TextField();
				tf.defaultTextFormat = new TextFormat("Arial", 40);
				tf.text = String.fromCharCode(65 + int(Math.random() * 25));
				tf.selectable = false;
				tf.x = Math.random() * 300 - 150;
				tf.y = Math.random() * 300 - 150;
				tf.z = Math.random() * 1000;
				_sprite.addChild(tf);
			}
			addChild(_sprite);
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_sprite.x = stage.stageWidth * 0.5 + Math.cos(_n) * 200;
			_n += 0.5;
//			_sprite.rotationX += 1;
//			_sprite.rotationY += 1;
//			_sprite.rotationZ += 1;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}