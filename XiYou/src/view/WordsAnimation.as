package view
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	/**
	 * 说明：WordsAnimation
	 * @author Victor
	 * 2012-11-6
	 */
	
	public class WordsAnimation extends Sprite
	{
		
		private var array:Array = [];
		private var content:String = "";
		
		public function WordsAnimation(content:*)
		{
			super();
			this.content = String(content);
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
		}
		
		private function start():void
		{
			var leng:int = content.length;
			for (var i:int = 0; i < leng; i++)
			{
				var str:String = content.substr(i, 1);
				var txt:TextField = getTxt(str);
				array.push(txt);
				txt.x = width + txt.width;
				addChild(txt);
			}
			TweenMax.allTo(array, 3, {y:-100, ease:Linear.easeNone, alpha:0}, 0.1, onCompleted);
		}
		
		private function onCompleted():void
		{
			TweenMax.killTweensOf(array);
			if (this.parent)
				this.parent.removeChild(this);
			array = null;
		}
		
		private function getTxt(str:String):TextField
		{
			var tfd:TextFormat = new TextFormat();
			tfd.size = 35;
			tfd.color = 0xff0000;
			tfd.bold = true;
			var txt:TextField = new TextField();
			txt.defaultTextFormat = tfd;
			txt.text = str;
			txt.width = txt.textWidth + 3;
			txt.height = txt.textHeight + 3;
			txt.border = true;
			return txt;
		}
		
		
	}
	
}