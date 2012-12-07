package test
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import global.Global;
	
	import test.local_store.LocalStore;
	import test.local_store.LocalStoreNameType;


	/**
	 * 说明：TestView
	 * @author Victor
	 * 2012-10-15
	 */

	public class TestView extends Sprite
	{

		private var textResult:TextField;
		private var btnChange:Sprite;
		private var btnRefresh:Sprite;

		public function TestView()
		{
			createVars();
			if (stage)
				initialization();
			else
				addEventListener(Event.ADDED_TO_STAGE, initialization);
		}

		private function initialization(event : Event = null) : void
		{
			displayTheData();
		}
		
		private function createVars():void
		{
			this.x = (Global.standardWidth - Global.stageWidth) * 0.5 * Global.stageScale;
			this.y = (Global.standardHeight - Global.stageHeight) * 0.5 * Global.stageScale;
			
			textResult = new TextField();
			textResult.type = TextFieldType.INPUT;
			textResult.defaultTextFormat = getTextFormat();
			textResult.borderColor = 0xff0000;
			textResult.border = true;
			textResult.background = true;
			textResult.backgroundColor = 0xffffff;
			textResult.y = 50;
			textResult.x = 110;
			textResult.width = 600;
			textResult.height = 400;
			
			addChild(textResult);
			
			btnChange = getButton("更改", 0, 50);
			btnRefresh = getButton("刷新",0, 100); 
			
			btnChange.addEventListener(MouseEvent.CLICK, onChangeClick);
			btnRefresh.addEventListener(MouseEvent.CLICK, onBtnRefreshClick);
		}
		
		protected function onBtnRefreshClick(event:MouseEvent):void
		{
			displayTheData();
		}
		
		protected function onChangeClick(event:MouseEvent):void
		{
			var object:Object = {};
			object.id = Math.random();
			object.name = "test data" + Math.random();
			object.sex = 1;
			object.phone = 15221299216;
			
			
			LocalStore.setData(LocalStoreNameType.USER, object);
		}
		
		private function displayTheData():void
		{
			var object:Object = LocalStore.getData(LocalStoreNameType.USER);
			if (object)
			{
				var str:String = "";
//				if (object.propertyIsEnumerable())
//				{
					for (var key:* in object)
					{
						str += key + ":" + object[key] + "\n";
					}
					textResult.text = str;
//				}
//				else
//				{
//					textResult.text = object.toString();
//				}
			}
			else
			{
				textResult.text = "not exist value";
			}
		}
		
		private function getButton($name:String, $x:Number, $y:Number):Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0xff0000);
			sprite.graphics.drawRect(0,0,100,50);
			sprite.graphics.endFill();
			
			var txt:TextField = new TextField();
			txt.defaultTextFormat = getTextFormat();
			txt.text = $name;
			txt.width = txt.textWidth + 5;
			txt.height = txt.textHeight;
			txt.wordWrap = true;
			txt.x = (sprite.width - txt.width) * 0.5;
			txt.y = (sprite.height- txt.height) * 0.5;
			sprite.addChild(txt);
			
			sprite.mouseChildren = false;
			sprite.buttonMode = true;
			
			sprite.x = $x;
			sprite.y = $y;
			
			addChild(sprite);
			
			return sprite;
		}
		
		private function getTextFormat():TextFormat
		{
			var tf:TextFormat = new TextFormat();
			tf.size = 30;
			
			return tf;
		}


	}

}
