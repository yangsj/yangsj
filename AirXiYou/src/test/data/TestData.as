package test.data
{
	import flash.data.EncryptedLocalStore;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/**
	 * 说明：TestData
	 * @author Victor
	 * 2012-10-15
	 */
	
	public class TestData extends Sprite
	{
		
		private var DATA_NAME:String = "data_name";
		
		private var object:Object;
		
		public function TestData()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			initialization();
		}		
		
		private function initialization():void
		{
			if (EncryptedLocalStore.isSupported)
			{
				var byteArray:ByteArray;
				if (EncryptedLocalStore.getItem(DATA_NAME))
				{
					byteArray = EncryptedLocalStore.getItem(DATA_NAME);
					trace(object = byteArray.readUTF());
				}
				else
				{
					byteArray = new ByteArray();
					byteArray.writeUTF("yangshengjin");
					EncryptedLocalStore.setItem(DATA_NAME, byteArray);
				}
			}
			else
			{
				
			}
		}		
		
	}
	
}