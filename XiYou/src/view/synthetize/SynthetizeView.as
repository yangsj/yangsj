package view.synthetize
{

	import com.greensock.TweenMax;
	
	import datas.RolesID;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import global.DeviceType;
	import global.Global;
	
	import ui.resource.synthetize.ResourceSynthetizeView;
	
	import utils.FunctionUtils;
	
	import view.ViewBase;


	/**
	 * 说明：SynthetizeView
	 * @author Victor
	 * 2012-10-3
	 */

	public class SynthetizeView extends ViewBase
	{
		private const PREFIX_LAB_FRAME : String = "lab_";

		private var CONTAINER_WITDH : Number = 875.7;
		private var CONTAINER_HEIGHT : Number = 150;
		private var ITEM_START_X : Number = 0;
		private var ITEM_START_Y : Number = 0;
		private var ITEM_DISTANCE_X : Number = 149.95;
		private var ITEM_CONST_WIDTH_HEIGHT : Number = 150;

		private var synthetizeView : ResourceSynthetizeView;
		private var container : Sprite;

		private var synthetizeRole1 : SynthetizeItem;
		private var synthetizeRole2 : SynthetizeItem;
		private var synthetizeRole3 : SynthetizeItem;
		private var dragItem : SynthetizeItem;

		private var containerStartX : Number = 0;
		private var containerStartY : Number = 0;
		private var containerMoveX : Number = 0;
		private var containerMoveLeft : Number = 0;

		private var data : Array;

		public function SynthetizeView()
		{
			super();

			if (Global.isDifferenceSwf && Global.deviceType == DeviceType.ANDROID)
			{
				CONTAINER_WITDH = 550;
				CONTAINER_HEIGHT = 85;
				ITEM_START_X = 0;
				ITEM_START_Y = 0;
				ITEM_DISTANCE_X = 78;
				ITEM_CONST_WIDTH_HEIGHT = 80;
			}
			else
			{
				CONTAINER_WITDH = 875.7;
				CONTAINER_HEIGHT = 150;
				ITEM_START_X = 0;
				ITEM_START_Y = 0;
				ITEM_DISTANCE_X = 145;
				ITEM_CONST_WIDTH_HEIGHT = 150;
			}

			createTestData();
			createResource();
		}

		override protected function addEvents() : void
		{
			super.addEvents();
			if (container)
			{
				container.addEventListener(MouseEvent.MOUSE_DOWN, containerMouseHandler);
			}
			if (synthetizeRole3)
			{
				synthetizeRole3.addEventListener(MouseEvent.MOUSE_DOWN, containerMouseHandler);
			}
			this.addEventListener(MouseEvent.MOUSE_UP, containerMouseHandler);
		}

		override protected function removeEvents() : void
		{
			super.removeEvents();
			if (container)
			{
				container.removeEventListener(MouseEvent.MOUSE_DOWN, containerMouseHandler);
			}
			if (synthetizeRole3)
			{
				synthetizeRole3.removeEventListener(MouseEvent.MOUSE_DOWN, containerMouseHandler);
			}
			this.removeEventListener(MouseEvent.MOUSE_UP, containerMouseHandler);
		}
		
		override protected function removedFromStageHandler(event:Event):void
		{
			super.removedFromStageHandler(event);
			
			data = null;
			
			container.removeChildren();
			
			FunctionUtils.removeChild(synthetizeView);
			FunctionUtils.removeChild(container);
			FunctionUtils.removeChild(synthetizeRole1);
			FunctionUtils.removeChild(synthetizeRole2);
			FunctionUtils.removeChild(synthetizeRole3);
			FunctionUtils.removeChild(dragItem);
			
			container = null;
			synthetizeView = null;
			synthetizeRole1 = null;
			synthetizeRole2 = null;
			synthetizeRole3 = null;
			dragItem = null;
			
			SynthetizeItem.clearPool();
		}

		private function createResource() : void
		{
			synthetizeView = new ResourceSynthetizeView();
			addChild(synthetizeView);

			container = synthetizeView.container;
			containerStartX = container.x;
			containerStartY = container.y;
			container.mask = synthetizeView.containerMask;

			containerMoveX = container.x;

			adjustSize(synthetizeView);

			layoutDisplaySynthetized();
			initSynthetizeRole();
		}

		private function createTestData() : void
		{
			data = [];
			var array : Array = RolesID.canUseRoleId;
			var leng : int = array.length;
			for each (var keyValue : * in array)
			{
				data.push({id: keyValue, name: "keyValue" + keyValue, roles: [{id: array[int(Math.random() * leng)]}, {id: array[int(Math.random() * leng)]}]});
			}
			array = null;
		}

		private function initSynthetizeRole() : void
		{
			synthetizeView.roleContainer1.visible = false;
			synthetizeView.roleContainer2.visible = false;
			synthetizeView.roleContainer3.visible = true;
			if (synthetizeView.roleContainer3.hasOwnProperty("role"))
			{
				synthetizeView.roleContainer3["role"].gotoAndStop(PREFIX_LAB_FRAME + "empty");
			}
			else
			{
				synthetizeView.roleContainer3.gotoAndStop(PREFIX_LAB_FRAME + "empty");
			}
			var item:SynthetizeItem;
			for (var i:int = 1; i < 4; i++)
			{
				var dis:DisplayObject = synthetizeView["roleContainer" + i] as DisplayObject;
				item = SynthetizeItem.create();
				item.data = {};
				item.x = item.atParentX = dis.x;
				item.y = item.atParentY = dis.y;
				item.scaleX = dis.scaleX;
				item.scaleY = dis.scaleY;
				item.parentTarget = synthetizeView;
				if (i == 3)
				{
					item.endScaleX = dis.scaleX;
					item.endScaleY = dis.scaleY;
				}
				item.initialization();
				synthetizeView.addChild(item);
				this["synthetizeRole" + i] = item;
			}
			item = null;
		}

		private function layoutDisplaySynthetized() : void
		{
			if (container.numChildren > 0)
			{
				container.removeChildren();
			}
			var index : int = 0;
			for each (var object : Object in data)
			{
				var endx : Number = ITEM_START_X + ITEM_DISTANCE_X * index;
				var item : SynthetizeItem = SynthetizeItem.create();
				item.data = object;
				item.parentTarget = container;
				item.x = endx;
				item.y = 0;
				item.atParentX = endx;
				item.atParentY = 0;
				item.width = item.height = ITEM_CONST_WIDTH_HEIGHT;
				item.endScaleX = item.scaleX;
				item.endScaleY = item.scaleY;
				container.addChild(item);
				item.initialization();

				index++;
			}
			container.graphics.clear();
			var __width : Number = container.width;
			var __height : Number = container.height;
			container.graphics.beginFill(0xff0000, 0);
			container.graphics.drawRect(0, 0, __width > CONTAINER_WITDH ? __width : CONTAINER_WITDH, __height > CONTAINER_HEIGHT ? __height : CONTAINER_HEIGHT);
			container.graphics.endFill();

			containerMoveLeft = CONTAINER_WITDH - container.width + containerStartX;
			if (containerMoveX < containerMoveLeft)
				containerMoveX = containerMoveLeft;

			playContainerTween();
		}

		private function synthetizeNew() : void
		{
			if (synthetizeRole3)
			{
				if (synthetizeRole3.isEmpty)
				{
					synthetizeRole1.data = {};
					synthetizeRole2.data = {};
				}
				else
				{
					synthetizeRole1.data = synthetizeRole3.roles[0];
					synthetizeRole2.data = synthetizeRole3.roles[1];
				}
				synthetizeRole1.initialization();
				synthetizeRole2.initialization();
			}
		}

		override protected function onClick(event : MouseEvent) : void
		{
			super.onClick(event);

			if (targetName == synthetizeView.btnReturn.name)
			{
				exit();
			}
			else if (targetName == synthetizeView.btnSynthetize.name)
			{
				
			}
			else if (targetName == synthetizeView.btnPrev.name)
			{
				if (containerMoveX < containerStartX)
				{
					containerMoveX += ITEM_DISTANCE_X;
					if (containerMoveX > containerStartX)
					{
						containerMoveX = containerStartX;
					}
					playContainerTween();
				}
			}
			else if (targetName == synthetizeView.btnNext.name)
			{
				if (containerMoveX > containerMoveLeft)
				{
					containerMoveX -= ITEM_DISTANCE_X;
					if (containerMoveX < containerMoveLeft)
					{
						containerMoveX = containerMoveLeft;
					}
					playContainerTween();
				}
			}

		}

		protected function containerMouseHandler(event : MouseEvent) : void
		{
			var target : DisplayObject = event.target as DisplayObject;
			if (event.type == MouseEvent.MOUSE_DOWN)
			{
				if (target is SynthetizeItem)
				{
					dragItem = target as SynthetizeItem;
					if (dragItem.isEmpty == false)
					{
						if (dragItem.parentTarget == container)
						{
							container.parent.setChildIndex(synthetizeView.containerMask, synthetizeView.numChildren - 1);
							container.parent.setChildIndex(container, synthetizeView.numChildren - 2);
							container.mouseChildren = container.mouseEnabled = false;
						}
						else
						{
							dragItem.parent.setChildIndex(dragItem, dragItem.parent.numChildren - 1);
						}

						dragItem.startDrag();
					}
					else
					{
						dragItem = null;
					}
				}
			}
			else if (event.type == MouseEvent.MOUSE_UP)
			{
				if (dragItem)
				{
					var targetItem : SynthetizeItem;
					dragItem.stopDrag();
					if (dragItem == synthetizeRole3)
					{
						targetItem = target as SynthetizeItem;

						if (targetItem && targetItem.parentTarget == container)
						{
							relpaceTwoRole(targetItem);
						}
						else if (target == synthetizeView.roleContainer3)
						{
							dragItem.moveTo(dragItem.atParentX, dragItem.atParentY, dragItem.scaleX, dragItem.scaleY);
						}
						else
						{
							dragItem.moveAddToList(moveAddListComplete, [dragItem]);
							data.push(dragItem.data);
						}
					}
					else
					{
						container.mouseChildren = container.mouseEnabled = true;
						if (target is SynthetizeItem && target == synthetizeRole3)
						{
							targetItem = target as SynthetizeItem;
							if (targetItem.isEmpty == false)
							{
								relpaceTwoRole(targetItem);
							}
							else
							{
								deleteListData(dragItem.data);

								var point1 : Point = targetItem.getContainerPoint(dragItem.parentTarget);
								targetItem.data = dragItem.data;
								targetItem.moveTo(targetItem.atParentX, targetItem.atParentY, targetItem.scaleX, targetItem.scaleY);
								dragItem.moveTo(point1.x, point1.y, targetItem.scaleX, targetItem.scaleY, true, layoutDisplaySynthetized);

								synthetizeNew();
							}

						}
						else
						{
							dragItem.moveTo(dragItem.atParentX, dragItem.atParentY, dragItem.scaleX, dragItem.scaleY);
						}
					}
				}
				dragItem = null;
			}
		}

		private function relpaceTwoRole(targetItem : SynthetizeItem) : void
		{
			var point1 : Point, point2 : Point;
			var dragData : Object;

			dragData = dragItem.data;
			point1 = dragItem.getContainerPoint(targetItem.parentTarget);
			point2 = targetItem.getContainerPoint(dragItem.parentTarget);

			replaceListData(dragItem.data, targetItem.data);
			
			dragItem.data = targetItem.data;
			targetItem.data = dragData;

			dragItem.initialization();
			targetItem.initialization();

			dragItem.x = point2.x;
			dragItem.y = point2.y;
			targetItem.x = point1.x;
			targetItem.y = point1.y;
			dragItem.scaleX = targetItem.endScaleX;
			dragItem.scaleY = targetItem.endScaleY;
			targetItem.scaleX = dragItem.endScaleX;
			targetItem.scaleY = dragItem.endScaleY;

			dragItem.moveTo(dragItem.atParentX, dragItem.atParentY, dragItem.endScaleX, dragItem.endScaleY);
			targetItem.moveTo(targetItem.atParentX, targetItem.atParentY, targetItem.endScaleX, targetItem.endScaleY);

			targetItem = null;

			synthetizeNew();
		}

		private function moveAddListComplete(item : SynthetizeItem) : void
		{
			item.scaleX = item.endScaleX;
			item.scaleY = item.endScaleY;
			item.x = item.atParentX;
			item.y = item.atParentY;
			item.data = {};
			item.initialization();
			synthetizeNew();
			layoutDisplaySynthetized();
		}

		private function playContainerTween() : void
		{
			TweenMax.killTweensOf(container);
			TweenMax.to(container, 0.3, {x: containerMoveX});
		}

		private function deleteListData($data : Object) : void
		{
			var i : int = 0;
			for each (var object : Object in data)
			{
				if (object.id == $data.id)
				{
					data.splice(i, 1);
					return;
				}
				i++;
			}
		}

		private function replaceListData($data1 : Object, $data2 : Object) : void
		{
			var i : int = 0;
			for each (var object : Object in data)
			{
				if (object.id == $data1.id)
				{
					data[i] = $data2;
					return;
				}
				i++;
			}
		}

	}

}
