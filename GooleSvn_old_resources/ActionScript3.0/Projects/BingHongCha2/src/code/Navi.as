package code
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.events.TweenEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	/**
	 * 说明：Navi
	 * @author victor
	 * 2012-5-28 下午11:06:26
	 */
	
	public class Navi extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private const ary:Array = [[183.45,27.6],[100.75,58.95],[185.65,100],[111.35,129],[174,169.9],[120,220],[193,260.3],[101.15,292.8],[153.65,328],[80.85,370.65],[195.5,411.75]];
		
		
		private var itemContainer:Sprite;
		private var urlLoader:URLLoader;
		private var urlRequest:URLRequest;
		private var configXml:XML;
		private var currentItem:ElementsItem;
		private var itemVec:Vector.<ElementsItem>;
		private var lineContainer:Sprite;
		
		
		public var configUrl:String = "config.xml";
		public var currentId:int = 0;
		
		public function Navi($rootUrl:String, $id:int)
		{
			super();
			
			if ($rootUrl) configUrl = $rootUrl;
			if ($id) currentId = $id;
			
			lineContainer =  new Sprite();
			this.addChild(lineContainer);
			lineContainer.filters = [new GlowFilter(0xFFFF66, 1, 4, 4, 1, 1)];
			
			itemContainer = new Sprite();
			this.addChild(itemContainer);
			
			initLoader();
			addAndRemoveEvent(true);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		//		
		private function initLoader():void
		{
			if (!configUrl)
			{
				throw new Error("没有 配置文件加载路径。。。。。。");
				return ;
			}
			urlLoader = new URLLoader();
			urlRequest = new URLRequest(configUrl);
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, urlLoaderCompletedHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlLoaderIOErrorHandler);
			urlLoader.load(urlRequest);
		}
		
		private function layout():void
		{
			if (itemVec == null) itemVec = new Vector.<ElementsItem>();
			var leng:int = ary.length;
			var i:int = 0;
			var xmlList:XMLList = configXml.child("item");
			
			for each(var xml:XML in xmlList)
			{
				if (i >= leng) break;
				var item:ElementsItem = new ElementsItem();
				if ((i + 2) == currentId)
				{
					item.isSelected = true;
					currentItem = item;
				}
				item.x 			= ary[i][0];
				item.y 			= ary[i][1];
				item.order  	= i;
				item.timeId 	= i + 1;
				item.cityId 	= int(xml.@id);
				item.url    	= xml.@addr.toString();
				item.openType 	= xml.@type.toString();
				item.initialization();
				itemContainer.addChild(item);
				
				itemVec.push(item);

				i++;
			}
			lineItem();
		}
		
		private function lineItem():void
		{
			lineContainer.graphics.clear();
			lineContainer.graphics.lineStyle(1, 0xffffff);
			lineContainer.graphics.moveTo(150, 0);
			for each (var item:ElementsItem in itemVec)
			{
				lineContainer.graphics.lineTo(item.x, item.y);
			}
			lineContainer.graphics.endFill();
		}
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		private function addAndRemoveEvent($isAdd:Boolean):void
		{
			if ($isAdd)
			{
				itemContainer.addEventListener(NaviEvent.CLICK_ITEM, clickItemHandler);
				itemContainer.addEventListener(NaviEvent.OVER_ITEM, mouseOverHandler);
				itemContainer.addEventListener(NaviEvent.OUT_ITEM, mouseOutHandler);
			}
			else
			{
				itemContainer.removeEventListener(NaviEvent.CLICK_ITEM, clickItemHandler);
				itemContainer.removeEventListener(NaviEvent.OVER_ITEM, mouseOverHandler);
				itemContainer.removeEventListener(NaviEvent.OUT_ITEM, mouseOutHandler);
			}
		}
		
		private function clickItemHandler(e:NaviEvent):void
		{
			if (currentItem)
			{
				currentItem.setScaleXY(false);
			}
			currentItem = e.naviItem;
		}
		
		private var timeLine1:TimelineMax = new TimelineMax();
		private var timeLine2:TimelineMax = new TimelineMax();
		private var timeLine3:TimelineMax = new TimelineMax();
		private var timeLine4:TimelineMax = new TimelineMax();
		private var tweenLeftArr:Array    = [];
		private var tweenRightArr:Array   = [];
		private var tweenOutArr:Array     = [];
		
		private function mouseOverHandler(e:NaviEvent):void
		{
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			var item:ElementsItem;
			while (tweenOutArr.length > 0)
			{
				item = tweenOutArr.pop() as ElementsItem;
				TweenMax.killTweensOf(item);
				item.x = item.startX;
				item.y = item.startY;
			}
			while (tweenLeftArr.length > 0)
			{
				item = tweenLeftArr.pop() as ElementsItem;
				TweenMax.killTweensOf(item);
			}
			while (tweenRightArr.length > 0)
			{
				item = tweenRightArr.pop() as ElementsItem;
				TweenMax.killTweensOf(item);
			}
			
			timeLine1.removeEventListener(TweenEvent.COMPLETE, timeLineCompletedHandler);
			timeLine2.removeEventListener(TweenEvent.COMPLETE, timeLineCompletedHandler);
			
			timeLine1 				= new TimelineMax();
			timeLine2 				= new TimelineMax();
			
			var leng:int			= itemVec.length;
			var target:ElementsItem	= e.naviItem;
			var order:int			= target.order;
			var num1:int 			= (Math.random() * (leng - 5) + 5);
			var num2:int 			= (Math.random() * (leng - 5) + 5);
			var minNum:int			= order - num1;
			var maxNum:int			= order + num2;
			minNum 					= minNum < 0 ? 0 : minNum;
			maxNum 					= maxNum >= leng ? leng - 1 : maxNum;
			var i:int;
			var endx:Number;
			var endy:Number;
			var unit1:int= 3 * (3 / num1);
			var unit2:int= 3 * (3 / num2);
			var time:Number = 0.8;
			var arr1:Array = [];
			var arr2:Array = [];
			// 上边
			for (i = order - 1; i >= minNum; i--)
			{
				item = itemVec[i] as ElementsItem;
				endx = item.startX + (Math.random() * 10 - 5);
				endy = item.startY - unit1 * num1;
				tweenLeftArr.push(item);
				arr1.push(TweenMax.to(item, time, {x:endx, y:endy, ease:Elastic.easeOut, onCompleteListener: tweenOnCompletedHandler}));
				num1--;
			}
			// 下边
			for (i = order + 1; i <= maxNum; i++)
			{
				item = itemVec[i] as ElementsItem;
				endx = item.startX + (Math.random() * 10 - 5);
				endy = item.startY + unit2 * num2;
				tweenRightArr.push(item);
				arr2.push(TweenMax.to(item, time, {x:endx, y:endy, ease:Elastic.easeOut, onCompleteListener: tweenOnCompletedHandler}));
				num2--;
			}
			
			timeLine1.addEventListener(TweenEvent.COMPLETE, timeLineCompletedHandler);
			timeLine2.addEventListener(TweenEvent.COMPLETE, timeLineCompletedHandler);
			timeLine1.appendMultiple(arr1, 0, TweenAlign.START, 0.05);
			timeLine2.appendMultiple(arr2, 0, TweenAlign.START, 0.05);
			arr1 = null;
			arr2 = null;
			
			lineItem();
		}
		
		private function timeLineCompletedHandler(e:TweenEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			e.target.removeEventListener(TweenEvent.COMPLETE, timeLineCompletedHandler);
		}
		
		private function mouseOutHandler(e:NaviEvent):void
		{
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			timeLine3 = new TimelineMax();
			timeLine4 = new TimelineMax();
			var arr1:Array = [];
			var arr2:Array = [];
			var endx:Number;
			var endy:Number;
			var item:ElementsItem;
			var time:Number = 0.6;
			while (tweenLeftArr.length > 0)
			{
				item = tweenLeftArr.shift() as ElementsItem;
				TweenMax.killTweensOf(item);
				endx = item.startX;
				endy = item.startY;
				tweenOutArr.push(item);
				arr1.push(TweenMax.to(item, time, {x:endx, y:endy, ease:Elastic.easeOut, onCompleteListener: tweenOnCompletedHandler}));
			}
			while (tweenRightArr.length > 0)
			{
				item = tweenRightArr.shift() as ElementsItem;
				TweenMax.killTweensOf(item);
				endx = item.startX;
				endy = item.startY;
				tweenOutArr.push(item);
				arr2.push(TweenMax.to(item, time, {x:endx, y:endy, ease:Elastic.easeOut, onCompleteListener: tweenOnCompletedHandler}));
			}
			
			timeLine3.addEventListener(TweenEvent.COMPLETE, timeLineCompletedHandler);
			timeLine4.addEventListener(TweenEvent.COMPLETE, timeLineCompletedHandler);
			timeLine3.appendMultiple(arr1, 0, TweenAlign.START, 0.05);
			timeLine4.appendMultiple(arr2, 0, TweenAlign.START, 0.05);
			arr1 = null;
			arr2 = null;
		}
		
		private function tweenOnCompletedHandler(e:TweenEvent):void
		{
			TweenMax.killTweensOf(e.target.target);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			lineItem();
		}
		
		private function urlLoaderCompletedHandler(e:Event):void
		{
			configXml = XML(e.target.data);
//			trace(configXml);
			urlLoader.removeEventListener(Event.COMPLETE, urlLoaderCompletedHandler);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, urlLoaderIOErrorHandler);
			urlLoader = null;
			
			layout();
		}
		
		private function urlLoaderIOErrorHandler(e:Event):void
		{
			throw new Error("加载配置文件出错。。。~_~");
		}
		
		
	}
}