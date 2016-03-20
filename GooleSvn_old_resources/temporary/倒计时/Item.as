package 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	import flash.text.TextFormatAlign;

	public class Item extends Sprite
	{
		var num:int;
		var WH:int = 22;
		var container:Sprite = new Sprite();
		var con:Sprite = new Sprite();
		var conMask:Sprite = createSprite("0");
		var leng:int = 9;

		public function Item($leng:int)
		{
			leng = $leng;
			init();
		}

		private function init():void
		{
			container.addChild(con);
			container.addChild(conMask);
			con.mask = conMask;
			container.x = container.y = 100;
			addChild(container);
			con.addChild(createSprite(""+leng, -WH));


			for (var i:int = 0; i < leng + 1; i++)
			{
				var s:Sprite = createSprite(""+i, WH * i);
				con.addChild(s);
			}
		}

		private function createSprite($str:String, $y:Number = 0):Sprite
		{
			var spr:Sprite = new Sprite();
			spr.graphics.beginFill(0x000000);
			spr.graphics.drawRect(0,0,22,22);
			spr.graphics.endFill();

			var txt:TextField = new TextField();
			var tf:TextFormat = new TextFormat();
			tf.color = 0xff0000;
			tf.align = TextFormatAlign.CENTER;
			tf.size = 17;
			txt.defaultTextFormat = tf;
			txt.text = $str;
			txt.width = 22;
			txt.height = 22;

			spr.addChild(txt);
			spr.y = $y;

			return spr;
		}
		
		public function setNum($num:int):void
		{
			num = $num;
			var endY:int =  -  WH * num;
			TweenMax.to(con, 1, { y: endY, onCompleteListener:tweenHandler } );
		}

		private function tweenHandler(e:TweenEvent):void
		{
			var len:int = leng == 5 ? 4 : leng;
			if (num==leng)
			{
				con.y = WH;
			}
		}













	}

}