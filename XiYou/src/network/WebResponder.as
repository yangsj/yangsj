package network
{

	import flash.net.Responder;

	import network.interfaces.IWebResponder;


	/**
	 * 说明：网络请求基类。
	 * @author Victor
	 * 2012-10-23
	 */

	public class WebResponder implements IWebResponder
	{
		private const ERROR_00001 : String = "未指定protocolID的值，该值必须在子类中被指定";

		/** 参数分隔符号 */
		private const PARAMS_SEPARATOR : String = ",";

		private var _responder : Responder;
		private var _params : Array;
		private var _onResult : Function;

		/**
		 * 在子类中必须重写 "protocolID" 属性的值。网络请求中若需要发送参数，可通过构造
		 * 函数或 "setParams" 方法按顺序定义所需参数。这里参数值类型必须是基本数据类型。
		 * @param onResult 请求数据返回后调用的方法，必须接受一个参数
		 * @param args 发送请求所需的参数定义，数组顺序定义
		 */
		public function WebResponder(onResult : Function = null, args : Array = null)
		{
			_responder = new Responder(onCompleteListener, onErrorListener);
			_onResult = onResult;

			setParams(args);
		}

		//////////////// public funtions ////////////////////////////

		public function onComplete(result : Object) : void
		{
		}

		public function onError(result : Object) : void
		{
		}

		//////////////// private functions //////////////////////////

		/**
		 * 如果对服务器的调用成功并返回结果，则此函数被调用。该函数不可被子类override，子类通过override  onComplete函数实现具体逻辑
		 */
		private function onCompleteListener(result : Object) : void
		{
			if (isSuccessed(result))
			{
				if (_onResult != null)
				{
					_onResult.call(this, result);
					_onResult = null;
				}
				onComplete(result);
			}
			log(result);
		}

		/**
		 * 如果服务器返回一个错误，则此函数被调用。该函数不可被子类override，子类通过override  onError函数实现具体逻辑
		 */
		private function onErrorListener(result : Object) : void
		{
			onError(result);
			log(result);
		}

		private function chechParamsLawful(params : Array) : void
		{
			if (params)
			{
				for each (var item : * in params)
				{
					if ((item is int) || (item is Number) || (item is Boolean) || (item is String) || (item is uint))
					{

					}
					else
					{
						throw new Error("暂不支持复杂数据类型");
						return ;
					}
				}
			}
		}

		/////////////////// protected functions ////////////////////////////////

		/**
		 * 服务器返回的数据是否正确
		 * @param result 服务器返回的数据
		 * @return Boolean
		 *
		 */
		protected function isSuccessed(result : Object) : Boolean
		{
			return true;
		}

		///////////////////////// getters/setters ///////////////////////////////////////

		final public function get responder() : Responder
		{
			return _responder;
		}

		public function get protocolID() : String
		{
			throw new Error(ERROR_00001);
			return "";
		}

		public function getParams() : String
		{
			return _params.join(PARAMS_SEPARATOR);
		}

		public function setParams(args : Array) : void
		{
			chechParamsLawful(args);
			_params = args;
		}


	}

}
