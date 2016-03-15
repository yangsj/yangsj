package com.newbye.utils
{
	import flash.utils.describeType;

	/**
	 * 取得对象的所有字段key 
	 */	
	public function getObjectFields(obj:Object):Array
	{
		var ra:Array = [];
		var vlist:XMLList = describeType(obj).child("variable");
		for each(var vii:XML in vlist)
		{
			ra.push(vii.attribute("name").toString());
		}
		vlist = describeType(obj).child("accessor");
		
		for each(var vi:XML in vlist)
		{
			ra.push(vi.attribute("name").toString());
		}
		
		return ra;
	}
}