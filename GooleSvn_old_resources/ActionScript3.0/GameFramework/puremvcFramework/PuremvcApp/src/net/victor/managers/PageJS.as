package net.victor.managers
{
	import flash.external.ExternalInterface;

	public class PageJS
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		public function PageJS()
		{
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public static function call(funcName:String,...parames):*
		{
			var obj:*;
			if(ExternalInterface.available)
			{
				if(parames.length > 0)
				{
					if ( parames.length == 1 ) obj=ExternalInterface.call(funcName, parames[0]);
					else if ( parames.length == 2 ) obj=ExternalInterface.call(funcName, parames[0], parames[1]);
					else if ( parames.length == 3 ) obj=ExternalInterface.call(funcName, parames[0], parames[1], parames[2]);
					else if ( parames.length == 4 ) obj=ExternalInterface.call(funcName, parames[0], parames[1], parames[2], parames[3]);
				}
				else
					obj=ExternalInterface.call(funcName);
			}
			return obj;
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}