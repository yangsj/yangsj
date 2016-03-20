package net.vyky.page
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.greensock.events.TweenEvent;

	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * 说明：实例化本类后，必须指定<b>data</b>、<b>pageContainer</b>、<b>prevButton</b>、<b>nextButton</b>、<b>pageWidth</b>和<b>pageHeight</b>的值，
	 * 若是显示的页面的大小和指定的<b>pageContainer</b>的大小相同，则可以不用对<b>pageWidth</b>和<b>pageHeight</b>两个进行赋值。
	 * 以<b>initialization()</b>方法开始程序
	 * <br><br>至少需要重写<b>layoutDisplay()</b>和<b>cteatePageData()</b>
	 * @author 杨胜金
	 * 2011-10-25 下午01:55:49
	 */
	public class VFlipPage
	{
		/////////////////////////////////////////vars /////////////////////////////////

		/** 页面显示容器 */
		public var pageContainer:DisplayObjectContainer;
		/** 上一页 按钮 */
		public var prevButton:InteractiveObject;
		/** 下一页 按钮 */
		public var nextButton:InteractiveObject;

		/** 当前页码 */
		protected var pageNo:uint=1;
		/** 总页码 */
		protected var totalPage:uint=1;
		/** 旧页面 */
		protected var oldPage:Sprite;
		/** 新页面 */
		protected var newPage:Sprite;
		/** 往前翻页 */
		protected var isPrevTo:Boolean;
		/** 往后翻页 */
		protected var isNextTo:Boolean


		private var _data:Object;
		private var _pageWidth:Number=0;
		private var _pageHeight:Number=0;
		private var _direction:String="normal";

		private var maskContainer:Sprite;

		///*****Test vars **************///////
		private var dataArr:Array=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 57, 58, 59];
		private var pagesDataArr:Array=new Array();

		private const rowX:int=4;
		private const rowY:int=3;
		private const rowXY:int=12;
		private const distanceXY:int=110;
		private const WH:int=100;
		private const conW:int=430;
		private const conH:int=320;

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 * 实例化本类后，必须指定<b>data</b>、<b>pageContainer</b>、<b>prevButton</b>、<b>nextButton</b>、<b>pageWidth</b>和<b>pageHeight</b>的值，
		 * 若是显示的页面的大小和指定的<b>pageContainer</b>的大小相同，则可以不用对<b>pageWidth</b>和<b>pageHeight</b>两个进行赋值。
		 * 以<b>initialization()</b>方法开始程序
		 * <br><br>至少需要重写<b>layoutDisplay()</b>和<b>cteatePageData()</b>
		 */
		public function VFlipPage($pageContainer:DisplayObjectContainer=null, $prevButton:InteractiveObject=null, $nextButton:InteractiveObject=null, $pageWidth:Number=0, $pageHeight:Number=0, $direction:String="normal")
		{
			pageContainer=$pageContainer;
			prevButton=$prevButton;
			nextButton=$nextButton;
			pageWidth=$pageWidth;
			pageHeight=$pageHeight;
			direction=$direction;
		}

		/////////////////////////////////////////static /////////////////////////////////



		/////////////////////////////////////////public /////////////////////////////////

		public function initialization($data:Object=null):void
		{
			if (pageContainer)
			{
				if (pageWidth == 0)
					pageWidth=pageContainer.width;
				if (pageHeight == 0)
					pageHeight=pageContainer.height;

				if (pageContainer.parent)
					createContainerMask();
				else
					pageContainer.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

				addAndRemoveEvents(true);

				///////// 构建显示页面 ////////
				cteatePageData();
				gotoPage();
			}
		}

		public function dispose():void
		{
			addAndRemoveEvents(false);
			if (maskContainer && pageContainer)
			{
				if (maskContainer.parent)
				{
					maskContainer.parent.removeChild(maskContainer);
					maskContainer=null;
				}
			}
		}


		/**
		 * 是否是最有一页
		 * @return
		 */
		public function get isLastPage():Boolean
		{
			return pageNo == totalPage;
		}

		/**
		 * 是否是第一页
		 * @return
		 */
		public function get isFristPage():Boolean
		{
			return pageNo == 1;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data=value;
		}

		/**
		 * 页面显示宽度
		 * @return
		 */
		public function get pageWidth():Number
		{
			return _pageWidth;
		}

		public function set pageWidth(value:Number):void
		{
			_pageWidth=value;
		}

		/**
		 * 页面显示高度
		 * @return
		 */
		public function get pageHeight():Number
		{
			return _pageHeight;
		}

		public function set pageHeight(value:Number):void
		{
			_pageHeight=value;
		}

		/**
		 * 页面出入方式
		 */
		public function get direction():String
		{
			return _direction;
		}

		/**
		 * @private
		 */
		public function set direction(value:String):void
		{
			_direction=value;
		}


		/////////////////////////////////////////override ///////////////////////////////



		/////////////////////////////////////////protected ///////////////////////////////

		/**
		 * 创建分页数据(所有页的数据都有时，可以在这里将数据分业
		 */
		protected function cteatePageData():void
		{
			for (var i:int=0; i < dataArr.length; i++)
			{
				if (pagesDataArr[int(i / rowXY)] == null)
				{
					pagesDataArr[int(i / rowXY)]=[];
				}
				pagesDataArr[int((i / rowXY))].push(dataArr[i]);
			}
			totalPage=pagesDataArr.length;
		}

		/**
		 * 布局页面显示对象 将页面布局的显示内容添加到 <b>newPage</b>容器中
		 */
		protected function layoutDisplay():void
		{
			var index:int=pageNo < 1 ? 0 : (pageNo > totalPage ? totalPage - 1 : pageNo - 1);
			var tempArr:Array=pagesDataArr[index];
			var leng:int=tempArr.length;

			for (var i:int=0; i < leng; i++)
			{
				var mc:Sprite=createTestDisplay(String(tempArr[i]));
				mc.x=(i % rowX) * distanceXY;
				mc.y=int(i / rowX) * distanceXY;
				newPage.addChild(mc);
			}
		}

		/**
		 * 设置翻页按钮的属性状态
		 * @param canClick 是否可以接受鼠标事件
		 * @param $visible 是否可见 默认true
		 */
		protected function setPrevNextButtonEnabled(canClick:Boolean, $visible:Boolean=true):void
		{
			prevButton.mouseEnabled=canClick;
			prevButton.visible=$visible;

			nextButton.mouseEnabled=canClick;
			nextButton.visible=$visible;
		}

		protected function pageTween():void
		{
			var oldEndX:Number=0;
			var oldEndY:Number=0;
			
			if (newPage) 
				pageContainer.addChild(newPage);
			
			if (direction == VFlipPageType.LEFT_RIGHT)
			{
				newPage.x=isPrevTo ? -pageWidth : pageWidth;
				oldEndX=isPrevTo ? pageWidth : -pageWidth;

				if (oldPage)
					TweenMax.to(oldPage, 0.3, {x: oldEndX, onCompleteListener: oldCompleteHandler});

				if (newPage)
					TweenMax.to(newPage, 0.3, {x: 0, ease: Bounce.easeOut, onCompleteListener: newCompleteHandler});
			}
			else if (direction == VFlipPageType.UP_DOWN)
			{
				newPage.y=isPrevTo ? -pageHeight : pageHeight;
				oldEndY=isPrevTo ? pageHeight : -pageHeight;

				if (oldPage)
					TweenMax.to(oldPage, 0.3, {y: oldEndY, onCompleteListener: oldCompleteHandler});

				if (newPage)
					TweenMax.to(newPage, 0.3, {y: 0, ease: Bounce.easeOut, onCompleteListener: newCompleteHandler});
			}
			else
			{
				if (oldPage)
					TweenMax.to(oldPage, 0.3, {alpha: 0, onCompleteListener: oldCompleteHandler});

				if (newPage)
				{
					newPage.alpha=0;
					TweenMax.to(newPage, 0.3, {alpha: 1, onCompleteListener: newCompleteHandler});
				}
			}

		}

		/**
		 * 设置 oldPage 和  newPage 的值
		 */
		protected function SetOldAndNewPage():void
		{
			oldPage=newPage;
			newPage=new Sprite();
		}

		/**
		 * 构建需要显示的 页面 信息内容
		 */
		protected function gotoPage():void
		{
			SetOldAndNewPage();
			layoutDisplay();
			pageTween();
		}

		/////////////////////////////////////////private ////////////////////////////////

		/**
		 * 创建页面显示容器的遮罩
		 */
		private function createContainerMask():void
		{
			maskContainer=new Sprite();
			maskContainer.graphics.beginFill(0xffff00);
			maskContainer.graphics.drawRect(-5, -5, pageWidth + 10, pageHeight + 10);
			maskContainer.graphics.endFill();

			maskContainer.x=pageContainer.x - 5;
			maskContainer.y=pageContainer.y - 5;

			pageContainer.mask=maskContainer;

			pageContainer.parent.addChild(maskContainer);
		}

		/**
		 * 测试使用
		 * @return
		 */
		private function createTestDisplay(str:String):Sprite
		{
			var sprite:Sprite=new Sprite();
			sprite.graphics.beginFill(Math.random() * 0xffffff);
			sprite.graphics.drawRect(0, 0, 100, 100);
			sprite.graphics.endFill();

			var order:TextField=new TextField();
			order.width=84;
			order.height=54;
			order.x=8;
			order.y=23;

			var textfor:TextFormat=new TextFormat();
			textfor.align="center";
			textfor.size=50;

			order.defaultTextFormat=textfor;

			order.text=str;
			sprite.addChild(order);

			return sprite;
		}

		/////////////////////////////////////////events//////////////////////////////////

		/**
		 * 添加或者移除事件
		 * @param isAdd 是添加事件true, 或者移除时间false
		 */
		private function addAndRemoveEvents(isAdd:Boolean):void
		{
			if (prevButton && nextButton)
			{
				if (isAdd)
				{
					prevButton.addEventListener(MouseEvent.CLICK, prevButtonClick);
					nextButton.addEventListener(MouseEvent.CLICK, nextButtonClick);

					pageContainer.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
				}
				else
				{
					prevButton.removeEventListener(MouseEvent.CLICK, prevButtonClick);
					nextButton.removeEventListener(MouseEvent.CLICK, nextButtonClick);

					pageContainer.removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);

					prevButton=null;
					nextButton=null;
					pageContainer=null;
				}
			}
		}

		/**
		 * 点击前一页翻页按钮 监视函数
		 * @param e
		 */
		protected function prevButtonClick(e:MouseEvent):void
		{
			isPrevTo=true;
			isNextTo=false;
			if (isFristPage)
				return;
			setPrevNextButtonEnabled(false);
			pageNo--;
			gotoPage();
		}

		/**
		 * 点击 后翻页 按钮 监视函数
		 * @param e
		 */
		protected function nextButtonClick(e:MouseEvent):void
		{
			isPrevTo=false;
			isNextTo=true;
			if (isLastPage)
				return;
			setPrevNextButtonEnabled(false);
			pageNo++;
			gotoPage();
		}

		/**
		 * 页 显示容器 添加到舞台 监视函数
		 * @param e
		 */
		private function addedToStageHandler(e:Event):void
		{
			pageContainer.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			createContainerMask();
		}

		/**
		 * 页 显示容器 移除舞台 监视函数
		 * @param e
		 */
		private function removeFromStageHandler(e:Event):void
		{
			dispose();
		}

		private function oldCompleteHandler(e:TweenEvent):void
		{
			TweenMax.killTweensOf(oldPage);
			if (oldPage.parent)
			{
				oldPage.parent.removeChild(oldPage);
			}
		}

		private function newCompleteHandler(e:TweenEvent):void
		{
			TweenMax.killTweensOf(newPage);
			setPrevNextButtonEnabled(true);
		}


	}

}
