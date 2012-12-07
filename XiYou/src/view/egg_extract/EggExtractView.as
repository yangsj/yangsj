package view.egg_extract
{
	import datas.RolesID;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import ui.resource.egg_extract.ResourceEggExtractView;
	
	import utils.ArrayUtils;
	import utils.FunctionUtils;
	
	import view.ViewBase;
	
	
	/**
	 * 说明：EggExtractView
	 * @author Victor
	 * 2012-10-2
	 */
	
	public class EggExtractView extends ViewBase
	{
		private const btnNameArray:Array = ["btnTab1", "btnTab2", "btnTab3", "btnReturn", "btnStart"];
		private const PREFIX_ROLE_NAME:String = "role_";
		private const PREFIX_LAB_FRAME:String = "lab_";
		
		private var eggExtractView:ResourceEggExtractView;
		private var btnTabName:String;
		private var roles:Vector.<MovieClip>;
		private var roleDataArray:Array;
		private var isStarted:Boolean = false;
		private var length:int = 6;
		private var IntervalID:uint;
		
		
		public function EggExtractView()
		{
			super();
			
			createResource();
		}
		
		private function createResource():void
		{
			eggExtractView = new ResourceEggExtractView();
			this.addChild(eggExtractView);
			
			adjustSize(eggExtractView);
			
			setTabSelectedStatus(null, false);
			eggExtractView.disSelectEffect.visible = false;
			eggExtractView.disSelectEffect.gotoAndStop(1);
			
			roleDataArray = [];
			roles = new Vector.<MovieClip>();
			for (var i:int = 1; i <= length; i++)
			{
				roles.push(eggExtractView[PREFIX_ROLE_NAME + i] as MovieClip);
			}
			
			btnTab1();
		}
		
		private function initLayoutRoleHead(type:int=1):void
		{
			eggExtractView.disNum.gotoAndStop(type);
			
			var arr:Array = ArrayUtils.createUniqueCopy(RolesID.canUseRoleId);
			ArrayUtils.randomSortOn(arr);
			
			roleDataArray = [];
			for (var i:int = 1; i <= length; i ++)
			{
				var key:String = PREFIX_LAB_FRAME + i;
				var id:int = -1;
				var role:DisplayObject = roles[i - 1] as DisplayObject;
				if (i < length)
				{
					id = arr[i - 1];
				}
				else
				{
					id = -1;
				}
				var labFrme:String = (id != -1) ? PREFIX_LAB_FRAME + id : PREFIX_LAB_FRAME + "empty";
				if (role.hasOwnProperty("role"))
				{
					role["role"].gotoAndStop(labFrme);
				}
				else if (role.hasOwnProperty("gotoAndStop"))
				{
					role["gotoAndStop"](labFrme);
				}
				roleDataArray[key] = id;
			}
			
			arr = null;
		}
		
		override protected function clear():void
		{
			clearInterval(IntervalID);
			while (roles.length > 0) 
			{
				roles.pop();
			}
			while (roleDataArray.length > 0)
			{
				roleDataArray.pop();
			}
			FunctionUtils.removeChild(eggExtractView);
			eggExtractView = null;
			roles = null;
			roleDataArray = null;
		}
		
		override protected function onClick(event:MouseEvent):void
		{
			super.onClick(event);
			if (btnNameArray.indexOf(targetName) != -1)
			{
				if (isStarted == true)
				{
					if (targetName != eggExtractView.btnReturn.name) return ;
				}
				this[targetName]();
			}
		}
		
		private function setTabSelectedStatus(dis:DisplayObject=null, visi:Boolean = true):void
		{
			eggExtractView.disSelectTabStatus.visible = visi;
			eggExtractView.disSelectTabStatus.mouseChildren = false;
			eggExtractView.disSelectTabStatus.mouseEnabled = false;
			if (dis)
			{
				eggExtractView.disSelectTabStatus.x = dis.x;
				eggExtractView.disSelectTabStatus.y = dis.y;
			}
			dis = null;
		}
		
		private function btnTab1():void
		{
			if (btnTabName != "btnTab1")
			{
				btnTabName = "btnTab1";
				initLayoutRoleHead(1);
				setTabSelectedStatus(eggExtractView.btnTab1);
			}
		}
		
		private function btnTab2():void
		{
			if (btnTabName != "btnTab2")
			{
				btnTabName = "btnTab2";
				initLayoutRoleHead(2);
				setTabSelectedStatus(eggExtractView.btnTab2);
			}
		}
		
		private function btnTab3():void
		{
			if (btnTabName != "btnTab3")
			{
				btnTabName = "btnTab3";
				initLayoutRoleHead(3);
				setTabSelectedStatus(eggExtractView.btnTab3);
			}
		}
		
		private function btnReturn():void
		{
			clearInterval(IntervalID);
			exit();
		}
		
		private function btnStart():void
		{
			if (isStarted == false)
			{
				isStarted = true;
				eggExtractView.disSelectEffect.visible = true;
				eggExtractView.disSelectEffect.gotoAndPlay(1);
				
				IntervalID = setInterval(onComplete, int(Math.random() * 1500 + 3000));
			}
		}
		
		private function onComplete():void
		{
			clearInterval(IntervalID);
			eggExtractView.disSelectEffect.stop();
			var key:String = eggExtractView.disSelectEffect.currentLabel;
			trace("选中：" + roleDataArray[key]);
		}
		
	}
	
}