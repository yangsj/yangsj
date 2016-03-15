package com.vy.code.navigation
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.events.TweenEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	
	/**
	 * 说明：NaviMain
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-12
	 */
	
	public class NaviMain extends MovieClip
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		private const pointXYAry:Array = [[45,66.25],[120.85,45.5],[196.7,48.5],[275.55,43.5],[348.4,40.5],[424.25,38.5],[500.1,40.5],[575.95,38.5],[651.8,45.5],[727.65,60.5],[803.5,57.5],[879.35,68],[955.2,61.5]];
//		private const pointXYAry:Array = [[48.35,70.3],[119.2,49.35],[203.55,55.1],[279.65,41.85],[339.9,41.3],[403.95,36.1],[474.25,45.05],[540.85,35.8],[599.8,50.05],[663.3,67.1],[734.75,63.85],[802.4,70.25],[868.8,56.75],[940.3,63.1]];
		
		public var configUrl:String = "config.xml";
		public var currentId:int = 0;
		
		private var urlLoader:URLLoader;
		private var urlRequest:URLRequest;
		private var configXml:XML;
		private var bg:com.vy.code.navigation.BackGroundResource;
		private var itemContainer:Sprite;
		private var currentItem:NaviItem;
		private var itemVec:Vector.<NaviItem>;
		private var stageHeight:Number = 105;
		
		public function NaviMain($rootUrl:String, $id:int, $stageHeight:Number = 230)
		{
//			super();
			if ($rootUrl) configUrl = $rootUrl + "?v=" + (new Date().time);
			currentId = $id;
			
			stageHeight = $stageHeight;
//			
			initVars();
			addAndRemoveEvent(true);
			this.mouseEnabled = false;
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function initVars():void
		{
//			bg = new BackGroundResource();
//			this.addChild(bg);
			itemContainer = new Sprite();
			this.addChild(itemContainer);
			itemVec = new Vector.<NaviItem>();
			initLoader();
			
			if (stageHeight > 105)
			{
				itemContainer.y = 125;
			}
			
			itemContainer.mouseEnabled = false;
		}
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
			var xmlList:XMLList = ConfigXML.xml.child("item");
			var leng:uint = 0;
			for each (var xl:XML in xmlList)
			{
				var xml:XML = configXml.item[leng];
				var ary:Array = pointXYAry[leng];
				var item:NaviItem = new NaviItem();
				if ((leng + 2) == currentId)
				{
					item.isSelected = true;
					currentItem = item;
				}
				item.order = leng;
				item.url = xml.@addr.toString();
				item.openType = xml.@type.toString();
				item.initialization(new NaviItemVO(xl));
				item.x = ary[0];
				item.y = ary[1];
				itemContainer.addChild(item);
				itemVec.push(item);
				leng++;
			}
		}
		
//		/////////////////////////////////////////events//////////////////////////////////
		
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
			var item:NaviItem;
			while (tweenOutArr.length > 0)
			{
				item = tweenOutArr.pop() as NaviItem;
				TweenMax.killTweensOf(item);
				item.x = item.startX;
				item.y = item.startY;
			}
			while (tweenLeftArr.length > 0)
			{
				item = tweenLeftArr.pop() as NaviItem;
				TweenMax.killTweensOf(item);
			}
			while (tweenRightArr.length > 0)
			{
				item = tweenRightArr.pop() as NaviItem;
				TweenMax.killTweensOf(item);
			}
			
			timeLine1.removeEventListener(TweenEvent.COMPLETE, timeLineCompletedHandler);
			timeLine2.removeEventListener(TweenEvent.COMPLETE, timeLineCompletedHandler);
			
			timeLine1 = new TimelineMax();
			timeLine2 = new TimelineMax();
			
			var target:NaviItem	= e.naviItem;
			var order:int		= target.order;
			var num1:int = (Math.random() * 9 + 3);
			var num2:int = (Math.random() * 9 + 3);
			var minNum:int		= order - num1;
			var maxNum:int		= order + num2;
			minNum = minNum < 0 ? 0 : minNum;
			maxNum = maxNum >= itemVec.length ? itemVec.length - 1 : maxNum;
			var i:int;
			var endx:Number;
			var endy:Number;
			var unit1:int= 4 * (3 / num1);
			var unit2:int= 4 * (3 / num2);
			var time:Number = 0.8;
			var arr1:Array = [];
			var arr2:Array = [];
			// 左边
			for (i = order - 1; i >= minNum; i--)
			{
				item = itemVec[i] as NaviItem;
				endx = item.startX - unit1 * num1;
				endy = item.startY + (Math.random() * 10 - 5);
				tweenLeftArr.push(item);
				arr1.push(TweenMax.to(item, time, {x:endx, y:endy, ease:Elastic.easeOut, onCompleteListener: tweenOnCompletedHandler}));
				num1--;
			}
			// 右边
			for (i = order + 1; i <= maxNum; i++)
			{
				item = itemVec[i] as NaviItem;
				endx = item.startX + unit2 * num2;
				endy = item.startY + (Math.random() * 10 - 5);
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
		}
		
		private function timeLineCompletedHandler(e:TweenEvent):void
		{
			e.target.removeEventListener(TweenEvent.COMPLETE, timeLineCompletedHandler);
		}
		
		private function mouseOutHandler(e:NaviEvent):void
		{
			timeLine3 = new TimelineMax();
			timeLine4 = new TimelineMax();
			var arr1:Array = [];
			var arr2:Array = [];
			var endx:Number;
			var endy:Number;
			var item:NaviItem;
			var time:Number = 0.6;
			while (tweenLeftArr.length > 0)
			{
				item = tweenLeftArr.shift() as NaviItem;
				TweenMax.killTweensOf(item);
				endx = item.startX;
				endy = item.startY;
				tweenOutArr.push(item);
				arr1.push(TweenMax.to(item, time, {x:endx, y:endy, ease:Elastic.easeOut, onCompleteListener: tweenOnCompletedHandler}));
			}
			while (tweenRightArr.length > 0)
			{
				item = tweenRightArr.shift() as NaviItem;
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
		
		private function urlLoaderCompletedHandler(e:Event):void
		{
			configXml = XML(e.target.data);
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