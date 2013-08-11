package app.manager
{
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;

	/**
	 * 说明：LocalStoreManager
	 * @author Victor
	 * 2012-10-19
	 */

	public class LocalStoreManager
	{
		private static var isSupported:Boolean = EncryptedLocalStore.isSupported;
		private static var PREFIX:String = "prefix_";

		public static var uid:String = "";



		public function LocalStoreManager()
		{
		}

		public static function initialization():void
		{
			PREFIX = PREFIX + uid + "_";
		}

		public static function getData( dataName:String ):Object
		{
			if ( isSupported )
			{
				dataName = PREFIX + dataName;
				var byteArray:ByteArray = EncryptedLocalStore.getItem( dataName );
				if ( byteArray )
				{
					return byteArray.readObject();
				}
			}

			return null;
		}

		/**
		 *
		 * @param dataName
		 * @param data
		 * @param stronglyBound 该参数暂不使用(使用默认值)
		 *
		 */
		public static function setData( dataName:String, data:*, stronglyBound:Boolean = false ):void
		{
			if ( isSupported )
			{
				dataName = PREFIX + dataName;

				var byteArray:ByteArray = new ByteArray();
				byteArray.writeObject( data );

				EncryptedLocalStore.setItem( dataName, byteArray );
			}
		}

		/**
		 * 删除一条指定的数据
		 * @param dataName
		 *
		 */
		public static function removeData( dataName:String ):void
		{
			if ( isSupported )
			{
				dataName = PREFIX + dataName;

				EncryptedLocalStore.removeItem( dataName );
			}
		}

		public static function clearAll():void
		{
			if ( isSupported )
			{
				try
				{
					EncryptedLocalStore.reset();
				}
				catch ( e:* )
				{
				}

			}
		}


	}

}
