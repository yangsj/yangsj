package com.newbye.utils
{
	/**
	 * 把时长转换成字串 　时：分：秒
	 * @param time 时长　单位为 秒
	 * @param sep 分割符
	 */	
	public function timeToString(time:Number, sep:String=""):String
	{
		var str:String = "";
		
		var h:int = time / 3600;
		
		var m:int = (time % 3600) / 60;
		
		var s:int = (time % 3600) % 60;
		if(sep.length > 0)
		{
			str = h.toString() + sep + m.toString() + sep + s.toString();
		}
		else
		{
			str = h.toString() + "时" + m.toString() + "分" + s.toString() + "秒";
		}
		
		return str;
	}
}