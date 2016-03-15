package com.newbye.utils
{
	public class Time
	{
		public function Time()
		{
		}
		/////////////////////////////////////////static /////////////////////////////////
		/**
		* 把时长转换成字串 　时：分：秒
		* @param time 时长　单位为 秒
		* @param sep 分割符
		*/	
		static public function SecondsToString(time:Number, sep:String=""):String
		{
			var str:String = "";
			
			var h:int = time / 3600;
			
			var m:int = (time % 3600) / 60;
			
			var s:int = (time % 3600) % 60;
			
			var h_str:String = (h < 10)?("0" + h.toString()) : h.toString()
			var m_str:String = (m < 10)?("0" + m.toString()) : m.toString()
			var s_str:String = (s < 10)?("0" + s.toString()) : s.toString()
				
			if(sep.length > 0)
			{
				str = h_str + sep + m_str + sep + s_str;
			}
			else
			{
				str = h.toString() + "时" + m.toString() + "分" + s.toString() + "秒";
			}
			
			return str;
		}
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}