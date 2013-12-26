package code
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	import events.EditEvent;

	/**
	 * ……
	 * @author yangsj
	 */
	public class ResolvingFileList
	{
		private var fileList:Array;
		private var storageUrl:String;
		private var total:int = 0;
		private var current:int = 0;

		public function ResolvingFileList( fileList:Array = null, storageUrl:String = null )
		{
			this.fileList = fileList;
			this.storageUrl = storageUrl;
			this.total = fileList.length;
		}

		public function startLoading():void
		{
			for each ( var file:FileReference in fileList )
			{
				loadItem( file );
			}
		}

		private function loadItem( file:FileReference ):void
		{
			file.addEventListener( Event.COMPLETE, fileReferenceLoadCompleteHandler );
			file.load();
		}

		private function allLoadComplete():void
		{
			EditEvent.dispatcher.dispatchEvent( new EditEvent( EditEvent.RESOLVING_ALL_COMPLETE ));
		}

		protected function fileReferenceLoadCompleteHandler( evt:Event ):void
		{
			var fileReference:FileReference = evt.target as FileReference;
			fileReference.removeEventListener( Event.COMPLETE, fileReferenceLoadCompleteHandler );
			resolving( fileReference );
		}

		public function resolving( fileReference:FileReference ):void
		{
			current++;
			EditEvent.dispatcher.dispatchEvent( new EditEvent( EditEvent.RESOLVING_ITEM_COMPLETE, "解析第" + current + "文件 【 " + fileReference.name + "】 开始……\n" ));

			/*
				第 1 行定义xml中字段名称（必须）
				第 2 行定义字段注释（建议填写）
				第 3 行定义数据类型（可留空）
				数据从第4行开始
			*/
			var xml:String = '<?xml version="1.0" encoding="UTF-8"?>\n<data>';
			var str:String = fileReference.data.toString();
			var items:Array = str.split( /\r\n/ );
			var keys:Array = split( items.shift()); // 字段名称
			var note:Array = split( items.shift()); // 字段注释
			var leng:int = keys.length;
			var i:int = 0;
			for ( i = 0; i < leng; i++ )
			{
				xml += "\n\t<!-- " + keys[ i ] + ":" + encodeUtf8( note[ i ]) + " -->";
			}
			leng = items.length;
			for ( i = 0; i < leng; i++ )
			{
				var itemArray:Array = split( items[ i ]);
				var itemLeng:int = itemArray.length;
				var itemString:String = "";

				// 过滤空节点
				if ( itemLeng <= 1 && ( itemArray[ 0 ] == null || itemArray[ 0 ] == "" ))
				{
					continue;
				}
				// 遍历所有属性
				for ( var j:int = 0; j < itemLeng; j++ )
				{
					itemString += keys[ j ] + "=\"" + encodeUtf8( itemArray[ j ]) + "\" ";
				}
				xml += "\n\t<item " + itemString + "/>";
			}
			xml += "\n</data>";

			try
			{
				var fileName:String = fileReference.name;
				var ws:FileStream = new FileStream();
				var dataByteArray:ByteArray = new ByteArray();
				fileName = fileName.substr( 0, fileName.indexOf( "."+fileReference.extension )) + ".xml";
				dataByteArray.writeUTFBytes( xml );
				ws.open( new File( storageUrl + "/" + fileName ), FileMode.WRITE );
				ws.writeBytes( dataByteArray );
				ws.close();
			}
			catch ( e:Error )
			{
			}

			EditEvent.dispatcher.dispatchEvent( new EditEvent( EditEvent.RESOLVING_ITEM_COMPLETE, xml )); //"解析第" + current + "文件 【 " + fileReference.name + "】 完成" ));

			if ( current >= total )
			{
				allLoadComplete();
			}
		}

		private function split( string:String ):Array
		{
			if ( string.search( ',"' ) != -1 )
			{
				var array:Array = [];
				var leng:int = string.length;
				var temp:String = "";
				var isMark:Boolean = false;
				for ( var i:int = 0; i < leng; i++ )
				{
					var chars:String = string.charAt( i );
					var isLastChars:Boolean = ( i == leng - 1 );
					var isPreMark:Boolean = (( i > 0 && string.charAt( i - 1 ) == "," ) && !isMark );
					var isTailMark:Boolean = (( i < leng - 1 && string.charAt( i + 1 ) == "," ) && isMark );
					if ( chars == '"' && ( isLastChars || isPreMark || isTailMark ))
					{
						isMark = !isMark;
					}
					else if ( chars != ',' || isMark )
					{
						temp += chars;
					}

					if ( !isMark && ( chars == "," || i == leng - 1 ))
					{
						array.push( temp );
						temp = "";
					}
				}
				//for each ( var val:String in array ) trace( val );
				return array;
			}
			return string.split( "," );
		}

		private function encodeUtf8( str:String ):String
		{
			return str;
			var oriByteArr:ByteArray = new ByteArray();
			var tempByteArr:ByteArray = new ByteArray();
			oriByteArr.writeUTFBytes( str );
			var leng:int = oriByteArr.length;
			for ( var i:int = 0; i < leng; i++ )
			{
				if ( oriByteArr[ i ] == 194 )
				{
					tempByteArr.writeByte( oriByteArr[ i + 1 ]);
					i++;
				}
				else if ( oriByteArr[ i ] == 195 )
				{
					tempByteArr.writeByte( oriByteArr[ i + 1 ] + 64 );
					i++;
				}
				else
				{
					tempByteArr.writeByte( oriByteArr[ i ]);
				}
			}
			tempByteArr.position = 0;
			return tempByteArr.readMultiByte( tempByteArr.bytesAvailable, "chinese" );
		}

	}
}
