package network.interfaces
{
	import flash.net.Responder;

	/**
	 * 网络请求的基类接口。
	 * @author victor
	 * 
	 */
	public interface IWebResponder
	{
		
		
		/**
		 * 对服务器的调用成功并返回结果后数据处理
		 * @param result
		 * 
		 */
		function onComplete(result:Object):void;
		
		/**
		 * 服务器返回一个错误后数据处理
		 * @param result
		 * 
		 */
		function onError(result:Object):void;
		
		/**
		 * 一个 Responder 对象。可以将 Responder 对象传递给 NetConnection.call()，以处理来自服务器的返回值。
		 * @return 
		 * 
		 */
		function get responder():Responder;
		
		/**
		 * 在通信xml配置文件中一个子节点的属性id值，该属性将在子类中必须覆写指定。
		 * @return 
		 * 
		 */
		function get protocolID():String;
		
		/**
		 * 获取发到服务器的参数
		 */
		function getParams():String;
		/**
		 * 设置与服务器通讯需要的参数，按照定义好的顺序传入即可。也可以直接通过构造函数传入。参数只接受基本数据类型
		 * @param args 与服务器通讯需要的参数及顺序
		 * 
		 */
		function setParams(args : Array):void;
		
	}
}