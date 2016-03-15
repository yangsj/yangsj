package net.victor.project.models.conf
{
	import flash.display.Stage;
	
	import net.victor.managers.PageJS;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ConfigureModelProxy extends Proxy
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		private const ROOT_PATH_PATTERN:String = "%rootpath%";
		private const LANGUAGE_PATTERN:String = "%language%";
		
		/**
		 * 设置默认资源的语言版本标识
		 */
		private const LANGUAGE_DEFAULT:String = "default";
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var _stage:Stage = appStage;
		
		private var _mainConfXML:XML;
		private var _commonResXML:XML;
		private var _resouresListXML:XML;
		private var _loadingPathXML:XML; // loding 界面资源配置
		private var _serverConfigXML:XML;
		
		private var _configParams:Object = {};
		
		private var _replacePathArr:Array = [];// = [ConfigurePathType.TYPE_DEPLOYRESPATH, ConfigurePathType.TYPE_COMMONRESPATH, ConfigurePathType.TYPE_MODULESPATH];
		
		public function ConfigureModelProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		public function setMainCofnigData($data:*):void
		{
			_mainConfXML = XML($data);
			resolvingMainConfigPath();
			if (_mainConfXML.hasOwnProperty("option"))
			{
				_loadingPathXML = _mainConfXML.child("option")[0] as XML;
				resolvingXMLPath(_loadingPathXML);
			}
		}
		
		public function setCommonResXMLData($data:*):void
		{
			_commonResXML = XML($data);
			resolvingXMLPath(_commonResXML);
		}
		
		public function setResouresListData($data:*):void
		{
			_resouresListXML = XML($data);
			resolvingXMLPath(_resouresListXML);
		}
		
		public function setServerConfigXML(data:*):void
		{
			_serverConfigXML = XML(data);
			resolvingMainConfigPath();
		}
		
		public function get getMainCofnigData():XML
		{
			return _mainConfXML;
		}
		
		/**
		 * 返回公共资源配置的xml文件
		 */
		public function get getCommonResXMLData():XML
		{
			return _commonResXML;
		}
		
		/**
		 * 返回语言版本资源配置的xml文件
		 */
		public function get getResouresListData():XML
		{
			return _resouresListXML;
		}
		
		/**
		* 获得一个包含 $xml 中所有资源文件的路径的数组Array
		* @param $xml:XML
		* @return Array
		*/
		public function getAllPathArray($xml:XML):Array
		{
			if ($xml == null) return null;
			var _resIdArr:Array	 = [];
			var _resPathArr:Array= [];
			var version:String	= "";
			var resId:String	= "";
			var resPath:String	= "";
			var arrString:String= "";
			var xmllist:XMLList	= $xml.children();
			var leng:int 		= xmllist.children().length();
			
			for each (var xml:XML in xmllist)
			{
				resId		= String(xml.@id);
				arrString	= _resIdArr.toString();
				if (arrString.search(resId) == -1)
				{
					_resIdArr.push(resId);
					version = String(xml.@version);
					resPath	= String(xml.@src);
					for each(var name:String in _replacePathArr)
					{
						if (resPath.search(name) != -1)
						{
							var str:String = "{@" + name + "}";
							var pathS:String = getPathParameter(name);
							if (pathS)
							{
								version = version ? version : (Math.random() * 100000000).toString();
								resPath = resPath.replace(str, pathS);
								resPath = resPath + "?version=" + version;
								_resPathArr.push(resPath);
								trace("resPath:::",resPath);
								break;
							}
						}
					}
				}
			}
			return _resPathArr;
		}
		
		/**
		 * 按指定参数获取路径
		 * @param $key
		 * @return 
		 */
		public function getPathParameter($key:String):String
		{
			var str:String = "";
			switch ($key)
			{
				case ConfigurePathType.TYPE_LANGUAGE:
					str = language;
					break;
				case ConfigurePathType.TYPE_COMMONRESPATH:
					str = commonResPath;
					break;
				case ConfigurePathType.TYPE_COMMONXMLPATH:
					str = commonXmlPath;
					break;
				case ConfigurePathType.TYPE_DEPLOYRESPATH:
					str = deployResPath;
					break;
				case ConfigurePathType.TYPE_DEPLOYXMLPATH:
					str = deployXmlPath;
					break;
				case ConfigurePathType.TYPE_MODULESPATH:
					str = modulesPath;
					break;
				case ConfigurePathType.TYPE_ROOTPATH:
					str = rootPath;
					break;
				case ConfigurePathType.TYPE_TEMPCONTXMLPATH:
					str = tempContXmlPath;
					break;
				default:
					str = getParameter($key);
					str = this.checkSpecialSign(str, false);
			}
			return str;
		}
		
		/** 主配置文件XML */
		public function get mainConfXML():XML
		{
			return _mainConfXML;
		}
		/** 公共资源配置文件XML */
		public function get commonResXML():XML
		{
			return _commonResXML;
		}
		/** 语言版本资源配置文件XML */
		public function get resouresListXML():XML
		{
			return _resouresListXML;
		}

		public function get amfGateway():String
		{
//			var gateway:String = this.getParameter("gateway");
//			var protocol:String = this.getParameter("protocol");
//			var host:String = this.getParameter("host");
//			var port:String = this.getParameter("port");
//			var folder:String = this.getParameter("folder");
//			var uid:String = this.getParameter("userid") as String;
//			
//			gateway = gateway ? gateway : _mainConfXML.child("network").child("item").(@type == "amf").attribute("gateway");
//			protocol = protocol ? protocol : _mainConfXML.child("network").child("item").(@type == "amf").attribute("protocol");
//			host = host ? host : _mainConfXML.child("network").child("item").(@type == "amf").attribute("host");
//			port = port ? port : _mainConfXML.child("network").child("item").(@type == "amf").attribute("port");
//			folder = folder ? folder : _mainConfXML.child("network").child("item").(@type == "amf").attribute("folder");
//		    uid = uid ? uid : PageJS.call("getHashValue","jt_uid") as String;
//			
			return "&t="+(new Date()).time;
		}
		
		/**
		 * 获取语言版本部分资源文件所在的文件夹的路径
		 * @return 
		 */
		public function get deployResPath():String
		{
			var rpath:String = "";
			rpath = getParameter(ConfigurePathType.TYPE_DEPLOYRESPATH);
			rpath = rpath ? (rpath + "") : "";
			rpath = checkSpecialSign(rpath);
			
			return rpath;
		}
		
		/**
		 * 获取模块资源文件所在的文件夹的路径
		 * @return 
		 */
		public function get modulesPath():String
		{
			var rpath:String = "";
			rpath = getParameter(ConfigurePathType.TYPE_MODULESPATH);
			rpath = rpath ? (rpath + "") : "";
			rpath = checkSpecialSign(rpath);
			
			return rpath;
		}
		
		/**
		 * 获取公共资源部分的文件资源路径
		 * @return 
		 */
		public function get commonResPath():String
		{
			var rpath:String = "";
			rpath = getParameter(ConfigurePathType.TYPE_COMMONRESPATH);
			rpath = rpath ? (rpath + "") : "";
			rpath = checkSpecialSign(rpath);
			
			return rpath;
		}
		
		/**
		 * 获取语言版本资源配置文件路径
		 * @return 
		 */
		public function get deployXmlPath():String
		{
			var rpath:String = "";
			rpath = getParameter(ConfigurePathType.TYPE_DEPLOYXMLPATH);
			rpath = rpath ? (rpath + "") : "";
			rpath = checkSpecialSign(rpath, false);
			
			return rpath;
		}
		public function get tempContXmlPath():String
		{
			var rpath:String = "";
			rpath = getParameter(ConfigurePathType.TYPE_TEMPCONTXMLPATH);
			rpath = rpath ? (rpath + "") : "";
			rpath = checkSpecialSign(rpath, false);
			
			return rpath;
		}
		
		/**
		 * 获取公共资源配置文件路径
		 * @return 
		 */
		public function get commonXmlPath():String
		{
			var rpath:String = "";
			rpath = getParameter(ConfigurePathType.TYPE_COMMONXMLPATH);
			rpath = rpath ? (rpath + "") : "";
			rpath = checkSpecialSign(rpath, false);
			
			return rpath;
		}
		
		/**
		 * 语言版本标识
		 * @return 
		 */
		public function get language():String
		{
			var _language:String = "";
			_language = getParameter(ConfigurePathType.TYPE_LANGUAGE);
			_language = _language ? _language : LANGUAGE_DEFAULT;
			return _language;
		}
		
		public function get rootPath():String
		{
			var _rootPath:String = "";
			_rootPath = getParameter(ConfigurePathType.TYPE_ROOTPATH);
			return _rootPath ? _rootPath : "";
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function resolvingXMLPath(xml:XML):void
		{
			if (_configParams == null) _configParams = {};
			var xlist:XMLList = xml.child("asset");
			for each (var xll:XML in xlist)
			{
				var idStr:String = xll.attribute("id").toString();
				var srcStr:String = xll.attribute("src").toString();
				var visiStr:String= xll.attribute("version").toString();
				for each(var name:String in _replacePathArr)
				{
					if (srcStr.search(name) != -1)
					{
						var str:String = "{@" + name + "}";
						var pathS:String = getPathParameter(name);
						if (pathS)
						{
							visiStr = visiStr ? visiStr : (Math.random() * 100000000).toString();
							srcStr = srcStr.replace(str, pathS);
							srcStr = srcStr + "?version=" + visiStr;
							_configParams[idStr] = srcStr;
							break;
						}
					}
				}
			}
		}
		
		/** 解析主配置文件中的 basic 部分参数 */
		private function resolvingMainConfigPath():void
		{
			if (_configParams == null) _configParams = {};
			var xlist:XMLList = _mainConfXML.child("basic").children();
			var tempStr:*;
			for each(var xi:XML in xlist)
			{
				var strName:String = xi.attribute("name").toString();
				tempStr = this.replaceRootPath(xi.@value);
				tempStr = this.replacePathLanguage(tempStr);
				_replacePathArr.push(strName);
				_configParams[strName] = tempStr;
			}
			var funlist:XMLList = _serverConfigXML ? _serverConfigXML.child("item") : new XMLList();
			for each(var xii:XML in funlist)
			{
				var fenable:Boolean = (int(xii.attribute("value")) > 0);
				_configParams[xii.attribute("name")] = fenable;
			}
		}
		
		private function replaceRootPath(path:String):String
		{
			return path.replace(ROOT_PATH_PATTERN, rootPath);
		}
		
		private function replacePathLanguage(path:String):String
		{
			return path.replace(LANGUAGE_PATTERN, language);
		}
		
		private function checkSpecialSign(rpath:String, last:Boolean = true):String
		{
			if (!rpath) return "";
			if(last && rpath.lastIndexOf("/") != rpath.length - 1)
			{
				rpath = rpath + "/";
			}
			if (rpath.search("/") == 0) 
			{
				rpath = rpath.substr(1);
			}
			return rpath;
		}
		
		public function getParameter($key:String):String
		{
			var rvalue:*;
			rvalue = _configParams[$key];
			if(rvalue)
			{
				return rvalue;
			}
			else
			{
				return _stage ? (_stage.loaderInfo.parameters[$key]) : (null);
			}
		}

		public function get stage():Stage
		{
			return _stage;
		}

		public function set stage(value:Stage):void
		{
			_stage = value;
		}

		
		/////////////////////////////////////////events//////////////////////////////////
	}
}