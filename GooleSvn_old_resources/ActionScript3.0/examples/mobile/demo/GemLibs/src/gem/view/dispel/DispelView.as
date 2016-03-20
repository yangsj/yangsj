package gem.view.dispel
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	import com.greensock.events.TweenEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	
	import gem.view.ViewBase;
	import gem.view.dispel.vo.AddNewItemVO;
	import gem.view.dispel.vo.MoveItemVO;
	import gem.view.home.HomeView;
	
	import manager.ui.UIMainManager;
	
	import scene.ResourceSceneBackGround0002;
	
	import sounds.SoundType;
	import sounds.SounderManager;
	
	import ui.dispelscene.ResourceGemBgAndContainer;
	import ui.dispelscene.ResourceMenuElements;
	
	
	/**
	 * 说明：DispelView
	 * @author Victor
	 * 2012-10-7
	 */
	
	public class DispelView extends ViewBase
	{
		private var sceneBack:Sprite;
		private var gemFrame:ResourceGemBgAndContainer;
		private var menuElements:ResourceMenuElements;
		private var gemContainer:Sprite;
		private var effectContainer:Sprite;
		
		private var gemsArray:Array;
		/** 记录开始布局时的缓动 */
		private var tweenTotalArr:Array;
		
		/////////// Timer 定时器  ////////////////////
		private var diamondsGameTimer:DispelGameTimer;
		private var canClickAgain:Boolean = true;
		private var moveGemsTimeLine:TimelineMax;
		private var addNewGemsTimeLine:TimelineMax;
		private var gemTarget:Gem;
		
		private var lianXuXiaoChu:int = 0;
		
		
		public function DispelView()
		{
			super();
			
			createResource();
		}
		
		private function createResource():void
		{
			sceneBack 	= new ResourceSceneBackGround0002();
			addChild(sceneBack);
			
			gemFrame 	= new ResourceGemBgAndContainer();
			gemFrame.x 	= 10;
			gemFrame.y 	= 300;
			addChild(gemFrame);
			
			menuElements = new ResourceMenuElements();
			this.addChild(menuElements);
			
			gemContainer 	= gemFrame.gemContainer as Sprite;
			effectContainer = gemFrame.effectContainer as Sprite;
			
			effectContainer.mouseChildren = effectContainer.mouseEnabled = false;
			while (effectContainer.numChildren > 0) effectContainer.removeChildAt(0);
		}
		
		public function initialization():void
		{
			initLayoutGem();
			initTimers();
		}
		
		private function initLayoutGem():void
		{
			gemsArray = [];
			tweenTotalArr = [];
			
			while (gemContainer.numChildren > 0) gemContainer.removeChildAt(0);
			
			const diamondsLength:int = DispelType.GEM_NUMBER;
			const rows:int = DispelType.ROWS;
			const cols:int = DispelType.COLS;
			for (var j:int=0; j < cols; j++)
			{
				var tempArrTimeLine:Array=[];
				var tempTimeLineMax:TimelineMax = new TimelineMax();
				for (var i:int=rows - 1; i >= 0; i--)
				{
					if (gemsArray[i] == null) gemsArray[i]=[];
					var id:int = int(Math.random() * diamondsLength + 1);
					var gems:Gem = Gem.create(id);
					var endX:Number = j * Gem.WIDTH;
					var endY:Number = i * Gem.HEIGHT;
					gems.x = endX;
					gems.y = -200 - (rows - i) * Gem.HEIGHT;
					gems.endY = endY;
					gems.setRowsCols(i, j);
					gems.setFormerPointValue(endX, endY);
					gemContainer.addChild(gems);
					gemsArray[i].push(gems);
					tempArrTimeLine.push(TweenMax.to(gems, 0.3, {y: endY, onCompleteListener: initCardsObjectSingleHandler}));
				}
				tempTimeLineMax.pause();
				tempTimeLineMax.addEventListener(TweenEvent.COMPLETE, initObjectsCompletedHandler);
				tempTimeLineMax.appendMultiple(tempArrTimeLine, 0, TweenAlign.START, 0.01);
				tweenTotalArr.push(tempTimeLineMax);
			}
			
			DispelGemsSeek.gemsArray = gemsArray;
		}
		
		/**
		 * 初始化 计时器
		 */
		private function initTimers():void
		{
			var tempTimerMax:Timer = new Timer(10);
			tempTimerMax.addEventListener(TimerEvent.TIMER, tempTimerMaxHandler);
			playLayoutTimeLine();
			tempTimerMax.start();
			tempTimerMax = null;
			
			clearTimerMain();
			
			diamondsGameTimer = new DispelGameTimer();
			diamondsGameTimer.callBackFunction = diamondsGameTimerCallFunction;
		}
		
		private function clearTimerMain():void
		{
			if (diamondsGameTimer)
			{
				diamondsGameTimer.stopAndClear();
				diamondsGameTimer = null;
			}
		}
		
		private function initCardsObjectSingleHandler(e:TweenEvent):void
		{
			TweenMax.killTweensOf(e.target.target);
			// 宝石掉落的声音
		}
		
		private function initObjectsCompletedHandler(e:TweenEvent):void
		{
			e.target.removeEventListener(TweenEvent.COMPLETE, initObjectsCompletedHandler);
		}
		
		private function tempTimerMaxHandler(e:TimerEvent):void
		{
			var timerInit:Timer = e.target as Timer;
			if (tweenTotalArr.length == 0)
			{
				TweenMax.delayedCall(0.5, autoSeekProgram);
				
				timerInit.removeEventListener(TimerEvent.TIMER, tempTimerMaxHandler);
				timerInit.stop();
				
				diamondsGameTimer.start();
			}
			else
			{
				playLayoutTimeLine();
			}
			timerInit=null;
		}
		
		/**
		* 播放起始布局的缓动
		*/
		private function playLayoutTimeLine():void
		{
			var timeLineM:TimelineMax = tweenTotalArr.pop();
			timeLineM.play();
			timeLineM=null;
		}
		
		private function diamondsGameTimerCallFunction():void
		{
			// 计时
			// 自动程序 【测试】
//			autoDispelGemProgram();
		}
		
		private function autoDispelGemProgram():void
		{
			if (canClickAgain)
			{
				lianXuXiaoChu = 0;
				var array:Array = DispelGemsSeek.testAutoDispelProgram();
				if (array.length == 2)
				{
					changeGemPointOfTwo(array[0] as Gem, array[1] as Gem);
				}
			}
		}
		
		//////////////////////////////////
		
		override protected function actionClose():void
		{
			super.actionClose();
			
			UIMainManager.addChild(new HomeView());
		}
		
		override protected function clear():void
		{
			super.clear();
			
			//  在这里销毁数据及对象
			clearTimerMain();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override protected function addEvents():void
		{	
			gemContainer.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			gemContainer.addEventListener(MouseEvent.MOUSE_UP,   mouseHandler);
			
			menuElements.addEventListener(MouseEvent.CLICK, menuElementsClickHandler);
		}
		
		override protected function removeEvents():void
		{
			gemContainer.removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			gemContainer.removeEventListener(MouseEvent.MOUSE_UP,   mouseHandler);
			
			menuElements.removeEventListener(MouseEvent.CLICK, menuElementsClickHandler);
		}
		
		protected function menuElementsClickHandler(event:MouseEvent):void
		{
			var targetNames:String = event.target.name;
			if (targetNames == menuElements.menuBtn.name)
			{
				var gamePausePanel:DispelGamePauseView = new DispelGamePauseView();
				gamePausePanel.open();
				gamePausePanel.exitFunction = exitCallBack;
			}
			else if (targetNames == menuElements.btn1.name)
			{
				DispelGemsSeek.promptSeek();
			}
		}
		
		private function continueCallBack():void
		{
			jtrace("continue game");
		}
		
		private function exitCallBack():void
		{
			jtrace("exit game to home");
			exit();
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			if (canClickAgain == false) return ;
			var target:DisplayObject = event.target as DisplayObject;
			var e_type:String = event.type;
			var gems:Gem;
			if (target is Gem)
			{
				if (e_type == MouseEvent.MOUSE_DOWN)
				{
					jtrace("gemContainer.numChildren:" + gemContainer.numChildren);
					if (gemTarget)
					{
						gems = target as Gem;
						if ((Math.abs(gems.rows - gemTarget.rows) == 1 && gems.cols == gemTarget.cols) || (Math.abs(gems.cols - gemTarget.cols) == 1 && gems.rows == gemTarget.rows))
						{
							changeGemPointOfTwo(gemTarget, gems);
						}
						else
						{
							gemTarget.unSelected();
						}
						gemTarget = null;
						gems = null;
					}
					else
					{
						gemTarget = target as Gem;
						gemTarget.selected();
						gemContainer.addEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
					}
				}
				else if (e_type == MouseEvent.MOUSE_MOVE)
				{
					if (gemTarget  && target != gemTarget)
					{
						gems = target as Gem;
						if ((Math.abs(gems.rows - gemTarget.rows) == 1 && gems.cols == gemTarget.cols) || (Math.abs(gems.cols - gemTarget.cols) == 1 && gems.rows == gemTarget.rows))
						{
							jtrace(gems.rows, gems.cols, gemTarget.rows, gemTarget.cols);
							changeGemPointOfTwo(gemTarget, gems);
							gemTarget = null;
							gems = null;
						}
					}
				}
				else if (e_type == MouseEvent.MOUSE_UP)
				{
					gemContainer.removeEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
				}
			}
		}
		
		private function changeGemPointOfTwo(gems1:Gem, gems2:Gem):void
		{
			canClickAgain = false;
			
			gems1.unSelected();
			gems2.unSelected();
			
			var rows1:int = gems1.rows;
			var cols1:int = gems1.cols;
			var rows2:int = gems2.rows;
			var cols2:int = gems2.cols;
			var formerx1:Number = gems1.former_x;
			var formery1:Number = gems1.former_y;
			var formerx2:Number = gems2.former_x;
			var formery2:Number = gems2.former_y;
			
			gems1.setRowsCols(rows2, cols2);
			gems2.setRowsCols(rows1, cols1);
			
			gemsArray[rows1][cols1] = gems2;
			gemsArray[rows2][cols2] = gems1;
			
			var array1:Array = DispelGemsSeek.seek(gems1);
			var array2:Array = DispelGemsSeek.seek(gems2);
			
			if (array1.length > 2 && array2.length > 2)
			{
				for each (var o:Object in array2)
				{
					if (array1.indexOf(o) == -1)
					{
						array1.push(o);
					}
				}
			}
			else if (array1.length < 3 && array2.length > 2)
			{
				array1 = array2;
			}
			
			if (array1.length > 2)
			{
				gems1.moveTo(formerx2, formery2);
				gems2.moveTo(formerx1, formery1);
				
				gems1.setRowsCols(rows2, cols2);
				gems2.setRowsCols(rows1, cols1);
				
				gems1.setFormerPointValue(formerx2, formery2);
				gems2.setFormerPointValue(formerx1, formery1);
				
				TweenMax.delayedCall(0.35, changeDataArray, [array1]);
			}
			else 
			{
				gems1.moveBack(formerx2, formery2, gems2.parent.getChildIndex(gems2));
				gems2.moveBack(formerx1, formery1, gems1.parent.getChildIndex(gems1));
				
				gems1.setRowsCols(rows1, cols1);
				gems2.setRowsCols(rows2, cols2);
				
				gemsArray[rows1][cols1] = gems1;
				gemsArray[rows2][cols2] = gems2;
				
				canClickAgain = true;
			}
			
			gems1 = null;
			gems2 = null;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 整理数据
		 */
		private function changeDataArray(array:Array):void
		{
			if (array && array.length > 2)
			{
				initTimeLineObject();
				var moveArray:Array = [];
				var addNewArray:Array = [];
				var tempArray1:Array = [];
				var tempArray2:Array = [];
				var endY:Number, endX:Number;
				var cols:int, i:int;
				for each (var gems:Gem in array)
				{
					for (var rows:int = gems.rows - 1; rows > -1; rows--)
					{
						var tempGem:Gem = gemsArray[rows][gems.cols] as Gem;
						if (tempGem && array.indexOf(tempGem) == -1)
						{
							tempGem.rows += 1;
							if (tempGem.isPushToMove == false)
							{
								moveArray.push(tempGem);
								tempGem.isPushToMove = true;
							}
						}
					}
					
					if (addNewArray[gems.cols]) 
						addNewArray[gems.cols] += 1; 
					else 
						addNewArray[gems.cols] = 1; 
					
					gems.removeFromParent();
					gems = null;
				}
				// 向下移动部分缓动记录
				for each (gems in moveArray)
				{
					gems.isPushToMove = false;
					endY = gems.rows * Gem.HEIGHT;
					gems.endY = endY;
					gems.setFormerPointValue(gems.former_x, endY);
					gemsArray[gems.rows][gems.cols] = gems;
					tempArray1.push(TweenMax.to(gems, 0.1, {y:endY, ease:Linear.easeOut, onCompleteListener:tweenItemCompleteHandler}));
//					tempArray1.push(TweenMax.to(gems, 0.2, {y:endY, ease:Elastic.easeOut, onCompleteListener:tweenItemCompleteHandler}));
				}
				// 新添加部分滑动记录
				for (var key:* in addNewArray)
				{
					cols = int(key);
					i = int(addNewArray[key]);
					for (rows = i - 1; rows > -1; rows--)
					{
						var id:int = int(Math.random() * DispelType.GEM_NUMBER + 1);
						var gemsAdd:Gem = Gem.create(id);
						endX = cols * Gem.WIDTH;
						endY = rows * Gem.HEIGHT;
						gemsAdd.x = endX;
						gemsAdd.y = -400 - (i - rows) * Gem.HEIGHT;
						gemsAdd.endY = endY;
						gemsAdd.setRowsCols(rows, cols);
						gemsAdd.setFormerPointValue(endX, endY);
						gemContainer.addChild(gemsAdd);
						gemsArray[rows][cols] = gemsAdd;
						
						tempArray2.push(TweenMax.to(gemsAdd, 0.2, {y:endY, onCompleteListener:tweenItemCompleteHandler}));
					}
				}
				moveGemsTimeLine.appendMultiple(tempArray1, 0, TweenAlign.START, 0.01);
				addNewGemsTimeLine.appendMultiple(tempArray2, 0, TweenAlign.START, 0.01);
				
				TweenMax.delayedCall(0.4, moveUpGemsDown);// 0.3 >= Gem对象移除舞台的动画时间
				TweenMax.delayedCall(0.6, addNewGemsIn); // 在Gem向下移动部分对象移动后延迟
				
				// 音效
				lianXuXiaoChu ++;
				playLianXuSounds();
			}
		}
		
		private function playLianXuSounds():void
		{
			switch (lianXuXiaoChu)
			{
				case 1:
					SounderManager.playSound(SoundType.Sounds445);
					break;
				case 2:
					SounderManager.playSound(SoundType.Sounds446);
					break;
				case 3:
					SounderManager.playSound(SoundType.Sounds447);
					break;
				case 4:
					SounderManager.playSound(SoundType.Sounds448);
					break;
				case 5:
					SounderManager.playSound(SoundType.Sounds449);
					break;
				case 6:
					SounderManager.playSound(SoundType.Sounds450);
					break;
				case 7:
					SounderManager.playSound(SoundType.Sounds451);
					break;
				case 8:
					SounderManager.playSound(SoundType.Sounds452);
					break;
				case 9:
					SounderManager.playSound(SoundType.Sounds366);
					break;
				case 10:
					SounderManager.playSound(SoundType.Sounds367);
					break;
				case 11:
					SounderManager.playSound(SoundType.Sounds8);
					break;
				case 12:
					SounderManager.playSound(SoundType.Sounds41);
					break;
			}
		}
		
		private function tweenItemCompleteHandler(e:TweenEvent):void
		{
			TweenMax.killTweensOf(e.target.target);
		}
		
		private function initTimeLineObject():void
		{
			moveGemsTimeLine = new TimelineMax();
			addNewGemsTimeLine = new TimelineMax();
			moveGemsTimeLine.addEventListener(TweenEvent.COMPLETE, moveGemsTimeLineHandler);
			addNewGemsTimeLine.addEventListener(TweenEvent.COMPLETE, addNewGemsTimeLineHandler);
			moveGemsTimeLine.pause();
			addNewGemsTimeLine.pause();
		}
		
		private function clearTimeLineObject():void
		{
			if (moveGemsTimeLine)
			{
				moveGemsTimeLine.removeEventListener(TweenEvent.COMPLETE, moveGemsTimeLineHandler);
				moveGemsTimeLine = null;
			}
			if (addNewGemsTimeLine)
			{
				addNewGemsTimeLine.removeEventListener(TweenEvent.COMPLETE, addNewGemsTimeLineHandler);
				addNewGemsTimeLine = null;
			}
		}
		
		protected function moveGemsTimeLineHandler(event:Event):void
		{
			event.target.removeEventListener(TweenEvent.COMPLETE, moveGemsTimeLineHandler);
		}
		
		protected function addNewGemsTimeLineHandler(event:Event):void
		{
			event.target.removeEventListener(TweenEvent.COMPLETE, addNewGemsTimeLineHandler);
			
			autoSeekProgram();
		}
		
		private function autoSeekProgram():void
		{
			// 校正
			var length:int = gemContainer.numChildren;
			if (length > DispelType.ROWS * DispelType.COLS)
			{
				for (var i:int = 0; i < length; i++)
				{
					var gems:Gem = gemContainer.getChildAt(i) as Gem;
					if (gems)
					{
						if (gems != gemsArray[gems.rows][gems.cols])
						{
							gems.parent.removeChild(gems);
							length -= 1;
						}
						else
						{
							gems.x = gems.former_x;
							gems.y = gems.former_y;
						}
					}
				}
			}
			
			canClickAgain = false;
			
			var array:Array = DispelGemsSeek.autoSeek();
			if (array.length > 2)
			{
				changeDataArray(array);
			}
			else
			{
				canClickAgain = true;
				lianXuXiaoChu = 0;
			}
		}
		
		/**
		 * 将符合移除部分的钻石上边部分向下移动
		 */
		private function moveUpGemsDown():void
		{
			if (moveGemsTimeLine) moveGemsTimeLine.play();
		}
		
		/**
		 * 开始添加新的钻石到场景中 
		 */		
		private function addNewGemsIn():void
		{
			if (addNewGemsTimeLine) addNewGemsTimeLine.play();
		}
		
		
	}
	
}