package test.local_store
{
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	
	/**
	 * 说明：LocalStore
	 * @author Victor
	 * 2012-10-15
	 */
	
	public class LocalStore
	{
		
		
		public function LocalStore()
		{
		}
		
		public static function getData(dataName:String):Object
		{
			var byteArray:ByteArray = EncryptedLocalStore.getItem(dataName);
			if (byteArray)
			{
				return byteArray.readObject();
			}
			
			return null;
		}
		
		public static function setData(dataName:String, data:*, stronglyBound:Boolean=false):void
		{
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(data);
			
			EncryptedLocalStore.setItem(dataName, byteArray);
		}
		
	}
	
}