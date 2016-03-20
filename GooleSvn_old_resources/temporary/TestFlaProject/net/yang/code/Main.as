package net.yang.code
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import net.yang.resource.RedMC;
	import net.yang.resource.BlueMc;
	import net.yang.resource.GreenMc;
	import net.yang.resource.BaseMc;
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	import net.yang.resource.BtnOutputArr;
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import net.yang.resource.YellowMc;
	import net.yang.resource.BlackMc;
	import net.yang.resource.BrownMc;

	public class Main
	{
		// 开放的种类数目
		private var _openKind:int = 4;

		private var _container:DisplayObjectContainer;
		// 记录每个位置的对象
		private var _everyPointObjectArr:Array;
		// 记录点击后查找到符合移除条件的对象
		private var _canRemoveObjectArr:Array;
		// 记录已检查过的可移除的对象
		private var _checkRemovedObjectArr:Array;
		// 记录需要移动的对象
		private var _needMoveObjectsArr:Array;
		// 记录当前点击的对象的markID
		private var _currentTargetID:int;
		// 记录每列移除的对象数目
		private var _everyRowRemoveNumArr:Array;

		private var _btn:BtnOutputArr;
		private var arr:Array = new Array();

		private const DISTANCE_WIDTH:int = 30;
		private const DISTANCE_HEIGHT:int = 30;
		private const ROW_HORIZONTAL:int = 10;
		private const ROW_VERTICAL:int = 10;
		private const UNITS_TIME:Number = 0.1;

		private const classObjectArr:Array = [RedMC,BlueMc,GreenMc,YellowMc,BlackMc,BrownMc];

		public function Main()
		{

		}

		public function initializion():void
		{
			addAndRemoveEvents(true);
			initVars();
			initMap();
		}
		/**
		* 容器对象
		*/
		public function get container():DisplayObjectContainer
		{
			return _container;
		}
		/**
		* @private
		*/
		public function set container(value:DisplayObjectContainer):void
		{
			_container = value;
			if (_btn == null)
			{
				_btn = new BtnOutputArr();
				_btn.x = _btn.y = 20;
				_container.parent.addChild(_btn);
				_btn.addEventListener(MouseEvent.CLICK, btnClickHandler);
			}
		}
		/**
		* 开放的种类数目
		*/
		public function get openKind():int
		{
			if (_openKind > classObjectArr.length)
			{
				_openKind = classObjectArr.length;
			}
			return _openKind;
		}
		/**
		* @private
		*/
		public function set openKind(value:int):void
		{
			_openKind = value;
		}
		/**
		* 初始 或 实例化 变量
		*/
		private function initVars():void
		{
			_everyPointObjectArr= new Array();
			_canRemoveObjectArr= new Array();
			_checkRemovedObjectArr= new Array();
			_needMoveObjectsArr = new Array();
			_everyRowRemoveNumArr = new Array(ROW_HORIZONTAL);
		}
		/**
		* 清除对对象的引用
		*/
		private function clearsVars():void
		{
			_everyPointObjectArr= 
			_canRemoveObjectArr= 
			_checkRemovedObjectArr= 
			_needMoveObjectsArr = 
			_everyRowRemoveNumArr = null;

			addAndRemoveEvents(false);

			container = null;
		}
		/**
		* 初始化界面元素
		*/
		private function initMap():void
		{
			for (var i:int = 0; i < ROW_HORIZONTAL * ROW_VERTICAL; i++)
			{
				var _tempNum:int = int(Math.random() * openKind);
				var _disObj:BaseMc = new (classObjectArr[_tempNum] as Class)();
				var _RH:int = i % ROW_HORIZONTAL;
				var _RV:int = int(i / ROW_VERTICAL);
				var _tx:Number = DISTANCE_WIDTH * _RH;
				var _ty:Number = DISTANCE_HEIGHT * _RV;
				_disObj.x = _tx;
				_disObj.y = _ty;
				_disObj.rowV = _RV;
				_disObj.rowH = _RH;
				container.addChild(_disObj);

				if (_disObj.txt)
				{
					_disObj.txt.text = String(i).length == 1 ? "0" + String(i):String(i);
				}
				if (_everyPointObjectArr[_RV] == null)
				{
					_everyPointObjectArr[_RV] = [];
				}
				_everyPointObjectArr[_RV][_RH] = _disObj;
			}
		}
		/**
		* 检查可以或符合移除条件的对象
		*/
		private function checkRemoveObj($rv:int, $rh:int):void
		{
			var _checkStr:String = "\"" + $rv + "," + $rh + "\"";
			var _arrToString:String = _checkRemovedObjectArr.toString();
			if (_arrToString.search(_checkStr) == -1)
			{
				_checkRemovedObjectArr.push(_checkStr);

				var _top1:int = $rv - 1;
				var _top2:int = $rh;
				var _bottom1:int = $rv + 1;
				var _bottom2:int = $rh;
				var _left1:int = $rv;
				var _left2:int = $rh - 1;
				var _right1:int = $rv;
				var _right2:int = $rh + 1;

				if (_top1 > -1)
				{
					addRemoveObjectsFun(_top1, _top2);
				}

				if (_left2 > -1)
				{
					addRemoveObjectsFun(_left1, _left2);
				}

				if (_everyPointObjectArr[_bottom1])
				{
					addRemoveObjectsFun(_bottom1, _bottom2);
				}

				if (_everyPointObjectArr[_right1])
				{
					addRemoveObjectsFun(_right1, _right2);
				}

			}
		}
		/**
		* 增加可以或符合移除条件的对象到指定数组中
		*/
		private function addRemoveObjectsFun($rv:int, $rh:int):void
		{
			var boo:Boolean = false;
			var baseMC:BaseMc = _everyPointObjectArr[$rv][$rh];
			if (baseMC)
			{
				if (baseMC.markID == _currentTargetID)
				{
					boo = isContainElement(baseMC, _canRemoveObjectArr);
					if (! boo)
					{
						_canRemoveObjectArr.push(baseMC);
					}
					checkRemoveObj($rv, $rh);
				}
			}
		}
		/**
		* 检查指定对象在指定对象中是否存在， 若存在则返回true， 否则返回false
		*/
		private function isContainElement(bm:BaseMc, appointArr:Array):Boolean
		{
			var boo:Boolean = false;
			for each (var i in appointArr)
			{
				if (i == bm)
				{
					boo = true;
					break;
				}
			}
			return boo;
		}
		/**
		* 从容器中将可以或符合移除条件的对象移除
		*/
		private function removeCheckedObjects():void
		{
			var bm:BaseMc;
			var leng:int = _canRemoveObjectArr.length;

			if (_needMoveObjectsArr == null)
			{
				_needMoveObjectsArr = [];
			}
			while (_needMoveObjectsArr.length > 0)
			{
				_needMoveObjectsArr[_needMoveObjectsArr.length - 1] = null;
				_needMoveObjectsArr.pop();
			}
			for (var i:int = 0; i < leng; i++)
			{
				bm = _canRemoveObjectArr[i];
				if (bm)
				{
					moveCheckUpObjects(bm.rowV, bm.rowH);
				}
				bm = null;
			}

			for (var k:int = 0; k < leng; k++)
			{
				bm = _canRemoveObjectArr[k];
				if (bm)
				{
					if (bm.parent)
					{
						if (_everyPointObjectArr[bm.rowV])
						{
							if (_everyPointObjectArr[bm.rowV][bm.rowH])
							{
								_everyPointObjectArr[bm.rowV][bm.rowH] = null;
							}
						}
						arr.push(bm.txt.text);
						bm.parent.removeChild(bm);
					}
				}
				bm = null;
				_canRemoveObjectArr[k] = null;
			}
			updateNeedMoveObjectPoint();
			trace("--------------------分界线------------------------");
		}
		/**
		* 检查需要向下移动的所有对象
		*/
		private function moveCheckUpObjects($rv:int, $rh:int):void
		{
			var _top1:int = $rv - 1;
			var _top2:int = $rh;
			var boo:Boolean = false;

			if (_everyRowRemoveNumArr[$rh] == null || _everyRowRemoveNumArr[$rh] == undefined)
			{
				_everyRowRemoveNumArr[$rh] = 1;
			}
			else
			{
				_everyRowRemoveNumArr[$rh] +=  1;
			}

			while (_top1 >= 0)
			{
				if (_everyPointObjectArr[_top1])
				{
					var baseMC:BaseMc = _everyPointObjectArr[_top1][_top2];
					if (baseMC)
					{
						boo = isContainElement(baseMC, _canRemoveObjectArr);
						if (! boo)
						{
							boo = isContainElement(baseMC, _needMoveObjectsArr);
							if (! boo)
							{
								_needMoveObjectsArr.push(baseMC);
							}
							baseMC.moveRowV +=  1;
							if (baseMC.moveRowV + baseMC.rowV > ROW_VERTICAL - 1)
							{
								baseMC.moveRowV = ROW_VERTICAL - baseMC.rowV - 1;
							}
						}
					}
				}
				_top1--;
			}
		}
		/**
		* 更新需要移动位置的对象的指定位置
		*/
		private function updateNeedMoveObjectPoint():void
		{
			//trace("_needMoveObjectsArr.length：" + _needMoveObjectsArr.length);
			container.mouseChildren = container.mouseEnabled = false;
			var bm:BaseMc;
			var timeLineMax:TimelineMax = new TimelineMax();
			var arrTimeLine:Array = new Array();

			var leng:int = _needMoveObjectsArr.length;
			for (var i:int = 0; i < leng; i++)
			{
				bm = _needMoveObjectsArr[i];
				if (bm)
				{
					var _rv:int = bm.rowV;
					var _rh:int = bm.rowH;
					var _mrv:int = bm.moveRowV;
					bm.rowV = _rv + _mrv;
					var _pointy:Number = DISTANCE_HEIGHT * bm.rowV;
					//trace("::::", _mrv, "_pointy:", _pointy, "R V H:", _rv, _rh, "bm.rowV::", bm.rowV);
					if (bm.rowV > ROW_VERTICAL - 1)
					{
						bm.rowV = ROW_VERTICAL - 1;
					}
					_everyPointObjectArr[bm.rowV][bm.rowH] = bm;
					_everyPointObjectArr[_rv][_rh] = null;
					bm.moveRowV = 0;
					arrTimeLine.push(TweenMax.to(bm, 0.3, {y:_pointy, onCompleteListener:onCompletedHandler}));
				}
			}
			timeLineMax.addEventListener(TweenEvent.COMPLETE, moveObjectsCompleted);
			timeLineMax.appendMultiple(arrTimeLine, 0, TweenAlign.START, 0.01);
			arrTimeLine = null;
		}

		private function moveObjectsCompleted(e:TweenEvent):void
		{
			e.target.removeEventListener(TweenEvent.COMPLETE, moveObjectsCompleted);
			checkCanAddResMcPoint();
		}
		/**
		* 增加符合条件的对象
		*/
		private function checkCanAddResMcPoint():void
		{
			var maxNum:int;// 列中 空缺的最多的数目
			var leng:int = _everyRowRemoveNumArr.length;
			var timeLineMax:TimelineMax = new TimelineMax();
			var arrTimeLine:Array = new Array();
			// 找出列中空缺最多的数目
			for each (var ii in _everyRowRemoveNumArr)
			{
				if (ii)
				{
					if (ii > maxNum)
					{
						maxNum = ii;
					}
				}
			}
			// 遍历数组 按每列 所缺少的对象添加新的对象
			for (var iii:int = 0; iii < leng; iii++)
			{
				if (_everyRowRemoveNumArr[iii])
				{
					var num:int = _everyRowRemoveNumArr[iii];
					while (num > 0)
					{
						num--;
						var tempNum:int = int(Math.random() * openKind);
						var mc:BaseMc = new (classObjectArr[tempNum] as Class)();
						var moveToY:Number = DISTANCE_HEIGHT * num;
						mc.x = DISTANCE_WIDTH * iii;
						mc.y =  -  DISTANCE_HEIGHT * (maxNum - num);
						mc.rowV = num;
						mc.rowH = iii;
						_everyPointObjectArr[num][iii] = mc;
						container.addChild(mc);
						arrTimeLine.push(TweenMax.to(mc, 0.3, {y:moveToY, onCompleteListener:onCompletedHandler}));
					}
					_everyRowRemoveNumArr[iii] = 0;
				}
			}
			// 检查是否 _everyPointObjectArr 二维数组中是否有空对象
			for (var iiii:int = 0; iiii < ROW_HORIZONTAL * ROW_VERTICAL; iiii++)
			{
				var bmv:int = int(iiii / ROW_HORIZONTAL);
				var bmh:int = iiii % ROW_HORIZONTAL;
				var baseMc:BaseMc = _everyPointObjectArr[bmv][bmh];
				if (baseMc == null)
				{
					trace("this is 空 Object:",bmv, bmh);
					var len:int = container.numChildren;
					// 查找在容器中是否有指定位置的对象
					for (var kk:int = 0; kk < len; kk++)
					{
						var tmc:* = container.getChildAt(kk);
						var checkx:Number = bmh * DISTANCE_WIDTH;
						var checky:Number = bmv * DISTANCE_HEIGHT;
						if (tmc.x == checkx && tmc.y == checky)
						{
							BaseMc(tmc).rowV = bmv;
							BaseMc(tmc).rowH = bmh;
							_everyPointObjectArr[bmv][bmh] = tmc;
							break;
						}
						else if (kk == len - 1)
						{
							throw new Error((((("索引【" + bmv) + ",") + bmh) + "】处缺少索引对象"));
						}
					}
				}
			}

			timeLineMax.addEventListener(TweenEvent.COMPLETE, addResTweenCompleted);
			timeLineMax.appendMultiple(arrTimeLine, 0, TweenAlign.START, 0.01);
			arrTimeLine = null;
		}

		private function addResTweenCompleted(e:TweenEvent):void
		{
			e.target.removeEventListener(TweenEvent.COMPLETE, addResTweenCompleted);
			container.mouseChildren = container.mouseEnabled = true;
		}

		private function onCompletedHandler(e:TweenEvent):void
		{
			var bm:BaseMc = e.target.target as BaseMc;
			bm.moveRowV = 0;
		}
		/**
		* 鼠标点击后  需要清除的 或 需要初始化的变量
		*/
		private function clickAfterClearVars():void
		{
			while (_canRemoveObjectArr.length > 0)
			{
				_canRemoveObjectArr[_canRemoveObjectArr.length - 1] = null;
				_canRemoveObjectArr.pop();
			}
			while (_checkRemovedObjectArr.length > 0)
			{
				_checkRemovedObjectArr[_checkRemovedObjectArr.length - 1] = null;
				_checkRemovedObjectArr.pop();
			}
			_canRemoveObjectArr = [];
			_checkRemovedObjectArr = [];
		}
		/**
		* 监听或移除事件
		*/
		private function addAndRemoveEvents(boo:Boolean):void
		{
			if (container)
			{
				if (boo)
				{
					container.addEventListener(MouseEvent.CLICK, containerClickHandler);
				}
				else
				{
					container.removeEventListener(MouseEvent.CLICK, containerClickHandler);
				}
			}
		}

		private function containerClickHandler(e:MouseEvent):void
		{
			var disObj:BaseMc = e.target as BaseMc;
			_everyRowRemoveNumArr = new Array(ROW_HORIZONTAL);
			_currentTargetID = disObj.markID;
			clickAfterClearVars();
			_canRemoveObjectArr.push(disObj);
			checkRemoveObj(disObj.rowV, disObj.rowH);
			//if (_canRemoveObjectArr.length > 2)
			//{
				removeCheckedObjects();
			//}
		}

		private function btnClickHandler(e:MouseEvent):void
		{
			trace(arr);
			trace("container.numChildren111:",container.numChildren);
			for (var i:int = 0; i < ROW_HORIZONTAL * ROW_VERTICAL; i++)
			{
				var baseMc:BaseMc = _everyPointObjectArr[int(i / ROW_HORIZONTAL)][i % ROW_HORIZONTAL];
				if (baseMc == null)
				{
					trace(int(i / ROW_HORIZONTAL), i % ROW_HORIZONTAL, baseMc);
				}
			}
		}

	}

}