package net.yang.code
{
	import flash.display.DisplayObjectContainer;
	import net.yang.resource.BaseMc;
	import net.yang.resource.RedMC;
	import net.yang.resource.BlueMc;
	import net.yang.resource.GreenMc;
	import net.yang.resource.YellowMc;
	import net.yang.resource.BlackMc;
	import flash.events.MouseEvent;
	import com.greensock.events.TweenEvent;
	import com.greensock.TweenMax;
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import flash.utils.getTimer;

	public class Test
	{
		private const DISTANCE_WIDTH:int = 30;
		private const DISTANCE_HEIGHT:int = 30;
		private const ROW_HORIZONTAL:int = 10;
		private const ROW_VERTICAL:int = 10;
		private const UNITS_TIME:Number = 0.1;

		/** 开放的种类数目*/
		public var openKind:int = 5;
		public var container:DisplayObjectContainer;
		/** 记录每个位置的对象*/
		private var allObjectsArr:Array;
		/** 记录点击后查找到符合移除条件的对象*/
		private var removeObjectsArr:Vector.<BaseMc > ;
		/** 记录需要向下移动的对象*/
		private var moveObjectsArr:Vector.<BaseMc > ;
		/** 记录新增加的显示对象*/
		private var addObjectsArr:Vector.<BaseMc>;
		/** 记录每列移除的对象数目*/
		private var rowLineNumArr:Array;
		/** 记录当前点击的对象的markID*/
		private var markID:int;

		private const classObjectArr:Array = [RedMC,BlueMc,GreenMc,YellowMc,BlackMc];

		public function Test()
		{
			// constructor code
		}
		
		public function initializion():void
		{
			if (container)
			{
				initVars();
				addAndRemoveEvents(true);
				initDisplayObjects();
			}
		}
		
		private function createBaseMc():BaseMc
		{
			var _tempNum:int = int(Math.random() * openKind);
			var _disObj:BaseMc = new (classObjectArr[_tempNum] as Class)();
			return _disObj;
		}
		
		private function initVars():void
		{
			allObjectsArr=new Array();
			removeObjectsArr=new Vector.<BaseMc>();
			moveObjectsArr=new Vector.<BaseMc>();
			addObjectsArr=new Vector.<BaseMc>();
			rowLineNumArr=new Array(ROW_HORIZONTAL);
		}
		
		private function initDisplayObjects():void
		{
			/*
			var leng:int = ROW_HORIZONTAL * ROW_VERTICAL;
			for (var i:int = 0; i < leng; i++)
			{
				var rowV:int = int(i / ROW_HORIZONTAL);
				var rowH:int = i % ROW_HORIZONTAL;
				var baseMc:BaseMc = createBaseMc();
				baseMc.setRow(rowV, rowH);
				baseMc.x = DISTANCE_WIDTH  * rowH;
				baseMc.y = -DISTANCE_HEIGHT * (ROW_VERTICAL - rowV);
				baseMc.name = "name:"+i;
				container.addChild(baseMc);
				if (! allObjectsArr[rowV]) allObjectsArr[rowV] = [];
				allObjectsArr[rowV][rowH] = baseMc;
			}
			*/
			
			
			var timeLineMax:TimelineMax = new TimelineMax();
			var arrTimeLine:Array = new Array();
			var leng:int = ROW_HORIZONTAL * ROW_VERTICAL;
			
			for (var i:int = ROW_VERTICAL - 1; i >= 0; i--)
			{
				var j:int;
				var rowV:int;
				var rowH:int;
				var baseMc:BaseMc;
				if (i %2 == 0)
				{
					trace("-----------------------------------", i);
					for (j = ROW_HORIZONTAL - 1; j >= 0; j--)
					{
						rowV = i;
						rowH = j;
						baseMc = createBaseMc();
						baseMc.setRow(rowV, rowH);
						baseMc.x = DISTANCE_WIDTH  * rowH;
						baseMc.y = -100//DISTANCE_HEIGHT * (ROW_VERTICAL - rowV);
						baseMc.name = "name:"+i;
						container.addChild(baseMc);
						if (! allObjectsArr[rowV]) allObjectsArr[rowV] = [];
						allObjectsArr[rowV][rowH] = baseMc;
						//timeLineMax.append(TweenMax.to(baseMc, UNITS_TIME, {y:DISTANCE_HEIGHT * rowV, onCompleteListener:onCompletedInitHandler}));
						arrTimeLine.push(TweenMax.to(baseMc, UNITS_TIME, {y:DISTANCE_HEIGHT * rowV, onCompleteListener:onCompletedInitHandler}));
					}
				}
				else
				{
					trace("++++++++++++++++++++++++++++++++", i);
					for (j = 0; j < ROW_HORIZONTAL; j++)
					{
						rowV = i;
						rowH = j;
						baseMc = createBaseMc();
						baseMc.setRow(rowV, rowH);
						baseMc.x = DISTANCE_WIDTH  * rowH;
						baseMc.y = - 100//DISTANCE_HEIGHT// * (ROW_VERTICAL - rowV);
						baseMc.name = "name:"+i;
						container.addChild(baseMc);
						if (! allObjectsArr[rowV]) allObjectsArr[rowV] = [];
						allObjectsArr[rowV][rowH] = baseMc;
						//timeLineMax.append(TweenMax.to(baseMc, UNITS_TIME, {y:DISTANCE_HEIGHT * rowV, onCompleteListener:onCompletedInitHandler}));
						arrTimeLine.push(TweenMax.to(baseMc, UNITS_TIME, {y:DISTANCE_HEIGHT * rowV, onCompleteListener:onCompletedInitHandler}));
					}
				}
				
			}
			timeLineMax.addEventListener(TweenEvent.COMPLETE, initObjectsCompleted);
			//timeLineMax.appendMultiple(arrTimeLine, 0, TweenAlign.START, 0.01);
			timeLineMax.insertMultiple(arrTimeLine, 0, TweenAlign.START, 0.015);
			//timeLineMax.prependMultiple(arrTimeLine,TweenAlign.START,0.01);
			arrTimeLine = null;
		}
		
		private function onCompletedInitHandler(e:TweenEvent):void
		{
			TweenMax.killTweensOf(e.target.target);
		}
		
		private function initObjectsCompleted(e:TweenEvent):void
		{
			trace("::::555555555555555");
		}
		
		private function addAndRemoveEvents(isAdd:Boolean):void
		{
			if (isAdd)
			{
				container.addEventListener(MouseEvent.CLICK, clickHandler);
			}
			else
			{
				container.removeEventListener(MouseEvent.CLICK, clickHandler);
			}
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			var baseMc1:* = e.target;
			if ( baseMc1 is BaseMc)
			{
				var times:Number = getTimer();
				clearAfterClick();
				container.mouseChildren = container.mouseEnabled = false;
				var baseMc:BaseMc = e.target as BaseMc;
				markID = baseMc.markID;
				
				//traceArr();
				/////////////////////// 查找阶段///////////////
				removeObjectsArr.push(baseMc);
				checkRemoveDisplayObjects(baseMc.rowV, baseMc.rowH);
				
				if (removeObjectsArr.length <3)
				{
					container.mouseChildren = container.mouseEnabled = true;
					return;
				}
				
				checkMoveDisplayObjects();
				addNewDisplayObjects();
			
				trace("removeObjectsArr:", removeObjectsArr.length);
				trace("moveObjectsArr:", moveObjectsArr.length);
				trace("addObjectsArr:", addObjectsArr.length);
				/////////////////////// 查找阶段///////////////
				trace("查找阶段用时为：", getTimer() - times);
				/////////////////////// 数据处理阶段///////////////
				refreshData();
				/////////////////////// 数据处理阶段///////////////
				trace("数据处理阶段用时为：", getTimer() - times)
				/////////////////////// 显示对象处理阶段///////////////
				refreshDisplayObjects();
				/////////////////////// 显示对象处理阶段///////////////
				trace("显示对象处理阶段用时为：", getTimer() - times);
			}
		}
		
		function traceArr():void
		{
			for each (var i in allObjectsArr)
			{
				for each (var j:BaseMc in i)
				{
					trace(j.rowV, j.rowH, j.name);
				}
			}
		}
		
		/////////// ******************  共用方法 Start **************************////////////////
		
		private function isContainElement(baseMC:BaseMc, arr:*):Boolean
		{
			var leng:int = arr.length;
			for (var i:int = 0; i < leng; i++)
			{
				var baseM:BaseMc = arr[i] as BaseMc;
				if (baseMC.rowV == baseM.rowV && baseMC.rowH == baseM.rowH)
				{
					return true;
				}
			}
			return false;
		}
		
		private function clearAfterClick():void
		{
			adjustDisplayPoint(moveObjectsArr);
			adjustDisplayPoint(addObjectsArr);
			clearArray(removeObjectsArr, false);
			clearArray(moveObjectsArr, false);
			clearArray(addObjectsArr, false);
			rowLineNumArr=new Array(ROW_HORIZONTAL);
		}
		
		private function clearArray(arr:*, isNull:Boolean):void
		{
			if (arr)
			{
				while (arr.length > 0)
				{
					arr[0] = null;
					arr.shift();
				}
			}
			arr = isNull ? null : [];
		}
		
		/////////// ******************  共用方法 over **************************////////////////
		
		/////////// *********************  查找需要移除的对象  start ********************/////////////////
		
		private function checkRemoveDisplayObjects(rowV:int, rowH:int):void
		{
			var tv:int = rowV - 1;
			var th:int = rowH;
			var bv:int = rowV + 1;
			var bh:int = rowH;
			var lv:int = rowV;
			var lh:int = rowH - 1;
			var rv:int = rowV;
			var rh:int = rowH + 1;
			
			if (tv > -1) checkRemoveNext(tv, th);
			if (bv < ROW_VERTICAL) checkRemoveNext(bv, bh);
			if (lh > -1) checkRemoveNext(lv, lh);
			if (rh < ROW_HORIZONTAL) checkRemoveNext(rv, rh);
		}
		
		private function checkRemoveNext(rowV:int, rowH:int):void
		{
			var baseMC:BaseMc = allObjectsArr[rowV][rowH];
			if (baseMC)
			{
				if (baseMC.markID == markID)
				{
					var boo:Boolean = isContainElement(baseMC, removeObjectsArr);
					if (! boo)
					{
						removeObjectsArr.push(baseMC);
						checkRemoveDisplayObjects(rowV, rowH);
					}
				}
			}
		}
		
		/////////// *********************  查找需要移除的对象  over ********************/////////////////
		
		/////////// *********************  查找需要移动的对象  Start ********************/////////////////
		
		private function checkMoveDisplayObjects():void
		{
			for each (var baseMc:BaseMc in removeObjectsArr)
			{
				RecordMovePointsAndNum(baseMc.rowV, baseMc.rowH);
			}
		}
		
		private function RecordMovePointsAndNum(rowV:int, rowH:int):void
		{
			var boo:Boolean;
			if (rowLineNumArr[rowH] == null || rowLineNumArr[rowH] == undefined)
			{
				rowLineNumArr[rowH] = 1;
			}
			else
			{
				rowLineNumArr[rowH] += 1;
			}
			
			while (rowV > 0)
			{
				rowV--;
				if (allObjectsArr[rowV])
				{
					var baseMC:BaseMc = allObjectsArr[rowV][rowH];
					if (baseMC)
					{
						boo = isContainElement(baseMC, removeObjectsArr);
						if (! boo)
						{
							boo = isContainElement(baseMC, moveObjectsArr);
							if (! boo)
							{
								moveObjectsArr.push(baseMC);
							}
							baseMC.moveRowV +=  1;
							if (baseMC.moveRowV + baseMC.rowV > ROW_VERTICAL - 1)
							{
								baseMC.moveRowV = ROW_VERTICAL - baseMC.rowV - 1;
							}
						}
					}
				}
			}
		}
		
		/////////// *********************  查找需要移动的对象  over ********************/////////////////
		
		/////////// *********************  添加新的对象  Start ********************/////////////////
		
		private function addNewDisplayObjects():void
		{
			for (var i:int = 0; i < ROW_HORIZONTAL; i++)
			{
				if (rowLineNumArr[i])
				{
					var num = rowLineNumArr[i] - 1;
					while ( num > -1)
					{
						var baseMc:BaseMc = createBaseMc();
						baseMc.setRow(num, i);
						addObjectsArr.push(baseMc);
						num --;
					}
				}
			}
		}
		
		/////////// *********************  添加新的对象  over ********************/////////////////
		
		/////////// *********************  数据处理  Start ********************/////////////////
		
		private function refreshData():void
		{
			for each (var bm1:BaseMc in removeObjectsArr)
			{
				allObjectsArr[bm1.rowV][bm1.rowH] = null;
			}
			
			for each (var bm2:BaseMc in moveObjectsArr)
			{
				allObjectsArr[bm2.rowV + bm2.moveRowV][bm2.rowH] = bm2;
			}
			
			for each (var bm3:BaseMc in addObjectsArr)
			{
				allObjectsArr[bm3.rowV][bm3.rowH] = bm3;
			}
			// 检查是否 _everyPointObjectArr 二维数组中是否有空对象
			var leng:int = ROW_HORIZONTAL * ROW_VERTICAL;
			for (var i:int = 0; i < leng; i++)
			{
				var bmv:int = int(i / ROW_HORIZONTAL);
				var bmh:int = i % ROW_HORIZONTAL;
				var baseMc:BaseMc = allObjectsArr[bmv][bmh];
				if (baseMc == null)
				{
					trace("this is 空 Object:",bmv, bmh);
					var len:int = container.numChildren;
					// 查找在容器中是否有指定位置的对象
					for (var kk:int = 0; kk < len; kk++)
					{
						var tmc:* = container.getChildAt(kk);
						if (tmc is BaseMc)
						{
							var checkx:Number = bmh * DISTANCE_WIDTH;
							var checky:Number = bmv * DISTANCE_HEIGHT;
							if (tmc.x == checkx && tmc.y == checky)
							{
								BaseMc(tmc).rowV = bmv;
								BaseMc(tmc).rowH = bmh;
								allObjectsArr[bmv][bmh] = tmc;
								break;
							}
							else if (BaseMc(tmc).rowV == bmv && BaseMc(tmc).rowH == bmh)
							{
								allObjectsArr[bmv][bmh] = tmc;
								tmc.x = checkx;
								tmc.y = checky;
								break;
							}
							else if (kk == len - 1)
							{
								throw new Error((((("索引【" + bmv) + ",") + bmh) + "】处缺少索引对象"));
							}
						}
						
					}
				}
			}
		}
		
		/////////// *********************  数据处理  over ********************/////////////////
		
		/////////// *********************  显示对象处理  Start ********************/////////////////
		
		private function refreshDisplayObjects():void
		{
			var timeLineMax:TimelineMax = new TimelineMax();
			var arrTimeLine:Array = new Array();
			// 向下移动
			for each (var bm2:BaseMc in moveObjectsArr)
			{
				var endPointY:Number;
				bm2.rowV += bm2.moveRowV;
				endPointY = DISTANCE_HEIGHT * bm2.rowV;
				bm2.moveRowV = 0;
				arrTimeLine.push(TweenMax.to(bm2, UNITS_TIME, {y:endPointY, onCompleteListener:onCompletedHandler}));
			}
			timeLineMax.addEventListener(TweenEvent.COMPLETE, moveObjectsCompleted);
			timeLineMax.appendMultiple(arrTimeLine, 0, TweenAlign.START, 0.01);
			arrTimeLine = null;
			// 移除
			for each (var bm1:BaseMc in removeObjectsArr)
			{
				if (bm1.parent) bm1.parent.removeChild(bm1);
				bm1 = null;
			}
			clearArray(removeObjectsArr, false);
			trace("********************************显示对象移除容器 完成*******************");
		}
		
		private function addNewDisplayObject():void
		{
			var timeLineMax:TimelineMax = new TimelineMax();
			var arrTimeLine:Array = new Array();
			var max:int;
			for each (var i:int in rowLineNumArr)
			{
				if (i > max) max = i;
			}
			for each (var bm2:BaseMc in addObjectsArr)
			{
				var endPointY:Number;
				bm2.rowV += bm2.moveRowV;
				bm2.x = DISTANCE_WIDTH * bm2.rowH;
				bm2.y =  -  DISTANCE_HEIGHT * (max - bm2.rowV);
				endPointY = DISTANCE_HEIGHT * bm2.rowV;
				container.addChild(bm2);
				bm2.moveRowV = 0;
				arrTimeLine.push(TweenMax.to(bm2, UNITS_TIME * 2, {y:endPointY, onCompleteListener:onCompletedHandler}));
			}
			timeLineMax.addEventListener(TweenEvent.COMPLETE, addObjectsCompleted);
			timeLineMax.appendMultiple(arrTimeLine, 0, TweenAlign.START, 0.01);
			arrTimeLine = null;
		}
		/** 矫正显示对象位置 */
		private function adjustDisplayPoint(arr:Vector.<BaseMc>):void
		{
			TweenMax.killAll();
			if (arr && arr.length > 0)
			{
				for each (var i:BaseMc in arr)
				{
					i.x = DISTANCE_WIDTH * i.rowH;
					i.y = DISTANCE_HEIGHT * i.rowV;
					container.addChild(i);
				}
			}
		}
		
		private function onCompletedHandler(e:TweenEvent):void
		{
			TweenMax.killTweensOf(e.target.target);
		}
		
		private function moveObjectsCompleted(e:TweenEvent):void
		{
			trace("********************************显示对象向下移动 完成*******************");
			clearArray(moveObjectsArr, false);
			container.mouseChildren = container.mouseEnabled = true;
			e.target.removeEventListener(TweenEvent.COMPLETE, moveObjectsCompleted);
			addNewDisplayObject();
		}
		
		private function addObjectsCompleted(e:TweenEvent):void
		{
			trace("********************************新的显示对象添加 完成*******************");
			e.target.removeEventListener(TweenEvent.COMPLETE, addObjectsCompleted);
			clearArray(addObjectsArr, false);
		}
		
		/////////// *********************  显示对象处理  over ********************/////////////////

	}

}