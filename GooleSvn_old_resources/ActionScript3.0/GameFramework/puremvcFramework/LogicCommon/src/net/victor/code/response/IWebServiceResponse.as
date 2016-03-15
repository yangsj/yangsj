package net.victor.code.response
{
	public interface IWebServiceResponse
	{
		/**
		 * 请求成功 
		 * @param result
		 * 
		 */		
		function onCompleteListener(result:Object):void;
		
		/**
		 * 请求失败 
		 * @param result
		 * 
		 */		
		function onErrorListener(result:Object):void;
		
		
		/**
		 * 请求成功 (子类重写
		 * @param result
		 * 
		 */		
		function onComplete(result:Object):void;
		
		/**
		 * 请求失败  (子类重写
		 * @param result
		 * 
		 */		
		function onFailed(result:Object):void;
		
		/**
		 * 请求出错  (子类重写
		 * @param result
		 * 
		 */		
		function onError(result:Object):void;
	}
}