package net.victor.project.models.user
{
	import flash.utils.describeType;
	
	import net.victor.project.models.ModelProxyNames;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-11-16 下午05:08:09
	 */
	public class UserModelProxy extends Proxy
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var _user:User;
		
		public function UserModelProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		override public function setData(data:Object):void
		{
			super.setData(data);
			if (data.user)
			{
				createUserData(data.user);
			}
		}
		
		public function get user():User
		{
			return _user;
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function createUserData(data:*):void
		{
			var tempData:* = data;//globalData.getData("");
			
			if(!_user)
			{
				_user = new User();
			}
			
			if(tempData)
			{
				for each(var key:* in User.fields)
				{
					if(tempData[key] != undefined)
					{
						trace("@@@@@@@" + key + ":" + tempData[key]);
						_user[key] = tempData[key];
					}
				}
			}
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}