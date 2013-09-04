package victor.framework.utils {
	import flash.text.TextField;

    /**
     * 字符串处理 
     * @author caozhichao
     * 
     */
    public class StringUitl {
        public function StringUitl() {
        }

        /**
         * 获取14个字节字符串
         * @param str
         * @return 
         * 
         */
        public static function getChar(str : String, bytesNum : int = 14) : String {
            // [ \u4e00-\u9fa5]
            var tempStr : String = str;
            var len : int = str.length;
            var num : int;
            for (var i : int = 0; i < len; i++) {
                var code : int = str.charCodeAt(i);
                if (code > 0x4e00 && code < 0x9fa5) {
                    // 中文2个字节
                    num += 2;
                } else {
                    num++;
                }
                if (num == bytesNum) {
                    tempStr = str.substring(0, i + 1);
                    break;
                } else if (num > bytesNum) {
                    tempStr = str.substring(0, i);
                    break;
                }
            }
            return tempStr;
        }

        public static function isEmpty(guid : String) : Boolean {
            return guid == null || guid == "" || guid == "0" || guid=="null";
        }
		
		/**
		 * 格式化数据 
		 * @param isPercentage
		 * @param value
		 * @return 
		 * 
		 */		
		public static function formatPercentageValue(isPercentage:Boolean,value:int):String
		{
			var str:String = "";
			if(isPercentage)
			{
				str = value / 10 + "%";	
			} else 
			{
				str = value + "";
			}
			return str;
		}
		
		/**
		 * 转换成Text
		 */		
		public static function getText(value:String):String
		{
			var tf:TextField = new TextField();
			tf.htmlText = value;
			return tf.text;
		}
		
		/**
		 * 转换成Html
		 */
		public static function getHtml(value:String):String
		{
			var xml:XML = <xml/>;
			xml.appendChild(value);
			var str:String = xml.toXMLString();
			return str.substring(5,str.indexOf("</xml>"));
		}
		
		/**
		 * 格式化输入文本
		 */		
		public static function formatInput(str:String):String
		{
			return str.replace(/</g,"《").replace(/>/g,"》");
		}
    }
}