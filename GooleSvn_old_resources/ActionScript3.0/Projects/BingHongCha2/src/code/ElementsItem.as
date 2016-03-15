package code
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.ApplicationDomain;
	
	
	/**
	 * 说明：ElementsItem
	 * @author victor
	 * 2012-5-28 下午11:06:47
	 */
	
	public class ElementsItem extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private const DISTANCE:int = 5;
		
		private const CONST_PREV:String = "MovieClipTime";
		private const CONST_CITY:String = "MovieClipCity";
		
		
		private var time:MovieClip;
		private var city:MovieClip;
		private var light:MovieClip;
		private var container:Sprite;
		
		private var _timeId:int = 1;
		private var _cityId:int = 2;
		private var _openType:String = "0";
		
		
		
		private const alphaValue:Number = 1;
		private const scaleXY:Number = 1.4;
		
		private var animationRes:MovieClip;
		private var isClicked:Boolean = false;
		
		/**
		 * 是否是当前被选中
		 */
		public var isSelected:Boolean = false;
		public var url:String = "http://tongyi-icetea.pps.tv/";
		public var startY:Number;
		public var startX:Number;
		public var order:int = 0;
		
		
		/**
		 *	6/9 	乌鲁木齐  	party.aspx?cityid=12
			7/1 	上海			party.aspx?cityid=3
			7/8 	武汉   		party.aspx?cityid=10
			7/15 	北京			party.aspx?cityid=2
			7/21 	苏州			party.aspx?cityid=7
			7/28 	厦门			party.aspx?cityid=9
			8/4 	南宁			party.aspx?cityid=8
			8/11 	合肥			party.aspx?cityid=6
			9/19 	郑州			party.aspx?cityid=5
			8/26 	成都			party.aspx?cityid=11
			9/2 	广州			party.aspx?cityid=4 
		 * 
		 */		
		/**
		 * 
		 * 
		 */		
		public function ElementsItem()
		{
			super();
			light = createResource("code.MovieClipLight");
			this.addChild(light);
			light.mouseChildren = light.mouseEnabled = false;
			this.mouseEnabled = false;
			//FFFF66
			light.filters = [new GlowFilter(0xFFFFCC, 0.8, 2, 2, 1, 1)];
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		public function initialization():void
		{
			time = createResource(CONST_PREV + cityId);
			time.y = -time.height * 0.5;
//			switch(cityId)
//			{
//				case 2:
//					city = new BeiJing();
//					break;
//				case 3:
//					city = new ShangHai();
//					break;
//				case 4:
//					city = new GuangZhou();
//					break;
//				case 5:
//					city = new ZhengZhou();
//					break;
//				case 6:
//					city = new HeFei();
//					break;
//				case 7:
//					city = new SuZhou();
//					break;
//				case 8:
//					city = new NanNing();
//					break;
//				case 9:
//					city = new XiaMen();
//					break;
//				case 10:
//					city = new WuHan();
//					break;
//				case 11:
//					city = new ChengDu();
//					break;
//				case 12:
//					city = new WuLuMuQi();
//					break;
//			}
			city = createResource(CONST_CITY + cityId);
			city.x = DISTANCE;
			city.y = - city.height * 0.5;
			container = new Sprite();
			container.addChild(time);
			container.addChild(city);
			animationRes = new AnimationItemRes();
			this.addChild(animationRes);
			
			animationRes.con.addChild(container);
			animationRes.con.mouseChildren = animationRes.con.mouseEnabled = false;
			animationRes.colorLump.buttonMode = true;
			animationRes.colorLump.alpha = 0;
//			animationRes.colorLump.scaleX = animationRes.colorLump.scaleY = 1.5;
			setScaleXY(isSelected);
			
			if (cityId == 12)
			{
				light.x = -10;
				animationRes.x = -10;
			}
			
			addAndRemoveEvents(true);
		}
		
		/**
		 * 是否显示原始比例
		 * @param $original 默认不显示， 为缩放
		 * 
		 */
		public function setScaleXY($original:Boolean = false, $init:Boolean = true):void
		{
			if ($original)
			{
				isClicked = true;
				animationRes.mouseChildren = animationRes.mouseEnabled = false;
				animationRes.gotoAndStop("overEnd");
				this.alpha = 1;
			}
			else
			{
				isClicked = false;
				animationRes.mouseChildren = animationRes.mouseEnabled = true;
				animationRes.gotoAndPlay($init ? "outEnd" : MouseEvent.MOUSE_OUT);
				this.alpha = alphaValue;
			}
		}
		
		/**
		 * 时间id(>=1)
		 */
		public function get timeId():int
		{
			return _timeId;
		}
		
		/**
		 * @private
		 */
		public function set timeId(value:int):void
		{
			_timeId = value;
		}
		
		/**
		 * 城市对应id
		 */
		public function get cityId():int
		{
			return _cityId;
		}
		
		/**
		 * @private
		 */
		public function set cityId(value:int):void
		{
			_cityId = value;
		}
		
		public function get openType():String
		{
			return _openType;
		}
		
		public function set openType(value:String):void
		{
			_openType = value;
			switch (_openType)
			{
				case "0":
					_openType = "_self";
					break;
				case "1":
					_openType = "_blank";
					break;
				case "2":
					_openType = "_parent";
					break;
				case "3":
					_openType = "_top";
					break;
			}
		}
		
		////////////////// private ////////////////////////////////
		
		private function createResource($name:String):MovieClip
		{
			var cls:Class = ApplicationDomain.currentDomain.getDefinition($name) as Class;
			var mc:MovieClip = new cls() as MovieClip;
			return mc;
		}
		
		////////////////// events//////////////////////////////////
		
		private function addAndRemoveEvents($isAdd:Boolean):void
		{
			if ($isAdd)
			{
				animationRes.colorLump.addEventListener(MouseEvent.CLICK, clickHandler);
				animationRes.colorLump.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
				animationRes.colorLump.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
				this.addEventListener(Event.ADDED_TO_STAGE, addedTOStageHandler);
			}
			else
			{
				animationRes.colorLump.removeEventListener(MouseEvent.CLICK, clickHandler);
				animationRes.colorLump.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
				animationRes.colorLump.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
				this.removeEventListener(Event.ADDED_TO_STAGE, addedTOStageHandler);
			}
		}
		
		private function addedTOStageHandler(e:Event):void
		{
			startX = this.x;
			startY = this.y;
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			setScaleXY(true);
			var evt:NaviEvent = new NaviEvent(NaviEvent.CLICK_ITEM);
			evt.naviItem = this;
			this.parent.dispatchEvent(evt);
			navigateToURL(new URLRequest(url), openType);
		}
		
		private function mouseOverHandler(e:MouseEvent):void
		{
			this.alpha = 1;
			animationRes.gotoAndPlay(MouseEvent.MOUSE_OVER);
			
			var evt:NaviEvent = new NaviEvent(NaviEvent.OVER_ITEM);
			evt.naviItem = this;
			this.parent.dispatchEvent(evt);
		}
		
		private function mouseOutHandler(e:MouseEvent):void
		{
			if (isClicked) return ;
			
			var evt:NaviEvent = new NaviEvent(NaviEvent.OUT_ITEM);
			evt.naviItem = this;
			this.parent.dispatchEvent(evt);
			
			animationRes.gotoAndPlay(MouseEvent.MOUSE_OUT);
			this.alpha = alphaValue;
		}
		
		


	}
}