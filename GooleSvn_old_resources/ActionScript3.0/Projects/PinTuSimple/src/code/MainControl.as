package code
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.system.ApplicationDomain;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	[SWF(width="420", height="300")]
	/**
	 * 说明：MainControl
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-4-16
	 */
	
	public class MainControl extends Sprite
	{
		
		/////////////////////////////////static ////////////////////////////
		
		private const resNameNum:String = "net.jt_tech.ui.number.NumericalSign";
		
		private const NUM_X:int = 4;
		private const NUM_Y:int = 3;
		
		private const NUM_W:int = 420;
		private const NUM_H:int = 300;
		
		private const DIST_X:Number = NUM_W / NUM_X;
		private const DIST_Y:Number = NUM_H / NUM_Y;
		
		///////////////////////////////// vars /////////////////////////////////
		
		private var vecSprite:Vector.<Sprite>;
		private var startRes:MovieClip;
		private var overRes:MovieClip;
		private var cardContainer:Sprite;
		private var timer:Timer;
		private var numRes:MovieClip;
		private var overNum:int = 0;
		private var cardGrid:Sprite;
		private var mainRes:MovieClip;
		private var skipBtn:InteractiveObject;
		
		private var countDownOver:Boolean = false;
		private var isSelected:Boolean = true;
		
		public function MainControl()
		{
			super();
			initVars();
			addAndRemoveEvent(true);
			initTimer();
		}
		
		private function initVars():void
		{
			vecSprite = new Vector.<Sprite>();
			startRes = getDefinition("com.victor.StartImage") as MovieClip;
			this.addChild(startRes);
			mainRes  = getDefinition("com.victor.TemplatePane") as MovieClip;
//			this.addChild(mainRes);
			mainRes.visible = false;
			cardContainer = new Sprite();
			this.addChild(cardContainer);
			cardGrid = new Sprite();
			this.addChild(cardGrid);
			cardGrid.visible = false;
			cardContainer.visible = false;
			skipBtn = getDefinition("com.victor.SkipButton") as InteractiveObject;
			skipBtn.x = 360;
			skipBtn.y = 254;
			this.addChild(skipBtn);
			overRes  = getDefinition("com.victor.OverPage") as MovieClip;
			overRes.visible = false;
//			overRes.buttonMode = true;
			this.addChild(overRes);
//			cutImage();
			createInit();
			
			this.graphics.beginFill(0xff0000, 0);
			this.graphics.drawRect(0,0,NUM_W, NUM_H);
			this.graphics.endFill();
		}
		
		private function createInit():void
		{
			for (var i:int = 0; i < 12; i++)
			{
				var tmc:MovieClip = getDefinition("com.victor.StartImage") as MovieClip;
				var dis:MovieClip = mainRes["m"+i] as MovieClip;
				var item:DragItem = new DragItem();
				item.endx = dis.x;
				item.endy = dis.y;
				tmc.x = -dis.x;
				tmc.y = -dis.y;
				dis.con.addChild(tmc);
				item.addChild(dis);
				dis.x = dis.y = 0;
				item.x = item.endx;
				item.y = item.endy;
				cardContainer.addChild(item);
				vecSprite.push(item);
			}
		}
		
		private function drawGrid():void
		{
			cardGrid.visible = true;
			cardGrid.alpha = 0.3;
			cardGrid.graphics.lineStyle(1);
			for (var i:int = 0; i <= NUM_X; i++)
			{
				cardGrid.graphics.moveTo(i*DIST_X, 0);
				cardGrid.graphics.lineTo(i*DIST_X, NUM_H);
			}
			for (var j:int = 0; j < NUM_Y; j++)
			{
				cardGrid.graphics.moveTo(0, j*DIST_Y);
				cardGrid.graphics.lineTo(NUM_W, j*DIST_Y);
			}
		}
		
		private function initTimer():void
		{
			createNumeric(2);
			timer = new Timer(1000, 2);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
			timer.start();
		}
		
		private function sixSecondsGameOver():void
		{
			timer = new Timer(6000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, sixSecondsOverTimerHandler);
			timer.start();
		}
		
		private function clearSixSecondsTimer():void
		{
			if (timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, sixSecondsOverTimerHandler);
				timer = null;
			}
		}
		
		private function sixSecondsOverTimerHandler(e:TimerEvent):void
		{
			gameOver();
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			createNumeric(timer.repeatCount - timer.currentCount);
		}
		
		private function timerCompleteHandler(e:TimerEvent):void
		{
			countDownOver = true;
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
			timer = null;
			if (numRes)
			{
				if (numRes.parent) numRes.parent.removeChild(numRes);
			}
			numRes = null;
			initContentCards();
			sixSecondsGameOver();
		}
		
		private function createNumeric($num:int):void
		{
			if (numRes)
			{
				if (numRes.parent) numRes.parent.removeChild(numRes);
			}
			numRes = getDefinition(resNameNum+$num) as MovieClip;
			numRes.x = NUM_W * 0.5;
			numRes.y = NUM_H * 0.5;
			numRes.scaleX = numRes.scaleY = 0;
			this.addChild(numRes);
			var scale_xy:Number = 15;
			TweenMax.to(numRes, 1, {scaleX:scale_xy, scaleY:scale_xy, alpha:0, onCompleteListener:tweenHandler});
		}
		
		private function initContentCards():void
		{
			cardContainer.visible = true;
			drawGrid();
			if (startRes)
			{
				if (startRes.parent) startRes.parent.removeChild(startRes);
				startRes = null;
			}
			for (var i:int = 0; i < vecSprite.length; i++)
			{
				var dis:DragItem = vecSprite[i] as DragItem;
				var tx:Number = Math.random() * (NUM_W - DIST_X);
				var ty:Number = Math.random() * (NUM_H - DIST_Y);
				dis.filters = getFilters;
				TweenMax.to(dis, 1, {x:tx, y:ty, scaleX:1, scaleY:1, onCompleteListener:tweenHandler});
			}
		}
		
		private function tweenHandler(e:TweenEvent):void
		{
			TweenMax.killTweensOf(e.target.target);
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		private function cutImage():void
		{
			//平均切割图片，计算图片高宽
			
			for (var j:uint=0; j < NUM_Y; j++)
			{
				for (var k:uint=0; k < NUM_X; k++)
				{
					var bitmapData:BitmapData=new BitmapData(DIST_X, DIST_Y);
					var matrix:Matrix=new Matrix(1, 0, 0, 1, -k * DIST_X, -j * DIST_Y);
					bitmapData.draw(startRes, matrix);
					var photoType:DragItem = new DragItem();
					photoType.graphics.beginBitmapFill(bitmapData);
					photoType.graphics.drawRect(0, 0, DIST_X, DIST_Y);
					vecSprite.push(photoType);
					photoType.endx = k * DIST_X;
					photoType.endy = j * DIST_Y;
					cardContainer.addChild(photoType);
					photoType.x = photoType.endx;
					photoType.y = photoType.endy;
				}
			}
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function getDefinition($name:String):Object
		{
			var cls:Class = ApplicationDomain.currentDomain.getDefinition($name) as Class;
			var obj:Object = new cls();
			return obj;
		}
		private var _glow:GlowFilter;
		private var _dropShadow:DropShadowFilter;
		private function get getFilters():Array
		{
			if (_glow == null)
			{
				_glow = new GlowFilter(0x999999,1,2,2,3,3,true);
			}
			if (_dropShadow == null)
			{
				_dropShadow = new DropShadowFilter(2,45,0x000000,1,2,2,1,3);
			}
			return [_dropShadow];
			return [_glow];
		}
		
		private function gameOver():void
		{
			trace("over complete");
			cardGrid.visible = false;
			overRes.visible = true;
			this.addChild(overRes);
			skipBtn.visible = false;
			if (startRes)
			{
				if (startRes.parent) startRes.parent.removeChild(startRes);
				startRes = null;
			}
			if (cardContainer)
			{
				if (cardContainer.parent) cardContainer.parent.removeChild(cardContainer);
				cardContainer = null;
			}
			if (vecSprite)
			{
				for each (var ve:DragItem in vecSprite)
				{
					if (ve)
					{
						ve.dispose();
						if (ve.parent) ve.parent.removeChild(ve);
						ve = null;
					}
				}
			}
			if (timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
				timer = null;
			}
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function addAndRemoveEvent($isAdd:Boolean):void
		{
			if ($isAdd)
			{
				cardContainer.addEventListener(DragItemEvent.ITEM_OVER, itemOverHandler);
				overRes.addEventListener(MouseEvent.CLICK, clickHandler);
				skipBtn.addEventListener(MouseEvent.CLICK, skipBtnHandler);
				this.addEventListener(MouseEvent.MOUSE_DOWN, thisClickHandler);
			}
			else
			{
				cardContainer.removeEventListener(DragItemEvent.ITEM_OVER, itemOverHandler);
				overRes.removeEventListener(MouseEvent.CLICK, clickHandler);
				skipBtn.removeEventListener(MouseEvent.CLICK, skipBtnHandler);
				this.removeEventListener(MouseEvent.MOUSE_DOWN, thisClickHandler);
			}
		}
		
		private function thisClickHandler(e:MouseEvent):void
		{
			if (countDownOver==false) return ;
			clearSixSecondsTimer();
			this.removeEventListener(MouseEvent.CLICK, thisClickHandler);
		}
		
		private function itemOverHandler(e:DragItemEvent):void
		{
			overNum++;
			trace("item",e.item);
			if (e.item)
			{
				var aniRes:MovieClip = new (ApplicationDomain.currentDomain.getDefinition("com.victor.AnimotionResource") as Class)() as MovieClip;
				aniRes.x = e.item.x;
				aniRes.y = e.item.y;
				cardContainer.addChildAt(aniRes, 0);
				aniRes.con.addChild(e.item);
				e.item.x = 0;
				e.item.y = 0;
				trace("11111111111111111111111");
			}
			trace("overNum======",overNum);
			if (overNum == NUM_X * NUM_Y)
			{
				for each (var dis:DisplayObject in vecSprite)
				{
					if (dis)
					{
						dis.filters = null;
					}
				}
				TweenMax.to(new Sprite(), 0.5, {alpha:0, onCompleteListener:overHandler});
				
			}
		}
		
		private function overHandler(e:TweenEvent):void
		{
			TweenMax.killTweensOf(e.target.target);
			overRes.visible = true;
			cardContainer.parent.removeChild(cardContainer);
			gameOver();
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			var targetName:String = e.target.name;
			if (targetName == "gouBtn")
			{
				isSelected = !isSelected;
				overRes.gouBtn.alpha = isSelected ? 1 : 0;
			}
			else if (targetName == "gotoBtn")
			{
				if (isSelected)
				{
//					var loader:URLLoader = new URLLoader();
//					var url:String = "http://adsupport.renren.com/ibtea/flashapi/share";
//					var request:URLRequest = new URLRequest(url);
//					request.method = URLRequestMethod.POST;
////					navigateToURL(request);
//					loader.addEventListener(Event.COMPLETE, completeHandler);
//					loader.load(request);
					if (ExternalInterface.available)
					{
						ExternalInterface.call("createRRnewsfeed");
					}
				}
				navigateToURL(new URLRequest("http://www.ty-icetea.com/game"), "_blank");
				if (ExternalInterface.available)
				{
					ExternalInterface.call("TY_ICETEAT_close");
				}
			}
		}
		
		private function completeHandler(e:Event):void
		{
//			MonsterDebugger.trace(this, e.target.data);
//			MonsterDebugger.trace(this+"over", e);
		}
		
		private function skipBtnHandler(e:MouseEvent):void
		{
			gameOver();
		}
		
		
	}
	
}