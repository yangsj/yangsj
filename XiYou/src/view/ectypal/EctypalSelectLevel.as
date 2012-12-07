package view.ectypal
{

	import com.greensock.TweenMax;
	
	import datas.EctypalData;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DisplacementMapFilter;
	
	import global.Global;
	
	import ui.resource.ectypal.ResourceEctypalLevel0001;
	
	import utils.FunctionUtils;
	import utils.TextFieldTyper;


	/**
	 * 说明：EctypalSelectLevel
	 * @author Victor
	 * 2012-10-1
	 */

	public class EctypalSelectLevel extends Sprite
	{
		private var child : MovieClip;
		private var isPrev : Boolean = false;
		private var isTweenOut : Boolean = false;
		private var index : int = 0;

		public var callBackWriteTextFunc : Function;
		public var currentEctypalID : int = -1;

		public function EctypalSelectLevel()
		{
			super();
		}

		public function initialization() : void
		{
			if (currentEctypalID == EctypalData.DEFAULT_ECTYPAL_ID)
			{
				if (EctypalData.currentEctypalID != EctypalData.DEFAULT_ECTYPAL_ID)
				{
					index = EctypalData.ectypalDataArrayID.indexOf(EctypalData.currentEctypalID);
				}
				else
				{
					index = 0;
				}
				
			}
			currentEctypalID = EctypalData.ectypalDataArrayID[index];
			
			createResource();

			initLayoutItemData();
			
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			FunctionUtils.removeChild(child);
			callBackWriteTextFunc = null;
		}
		
		private function createResource() : void
		{
			switch (currentEctypalID)
			{
				case 0:
					child = new ResourceEctypalLevel0001();
					break;
				default:
					child = new ResourceEctypalLevel0001();
			}

			this.addChild(child);
		}

		private function initLayoutItemData() : void
		{
			EctypalData.currentEctypalID = currentEctypalID;
			var array : Array = EctypalData.getCurrentEctypalData(currentEctypalID);
			var object : Object;
			if (array == null)
			{
				array = EctypalData.getDefaultEctypalData(currentEctypalID);
				EctypalData.setCurrentEctypalData(array);
			}
			for each (object in array)
			{
				var item : EctypalLevelItem = EctypalLevelItem.create();
				item.data = object;
				item.target = child["level_" + item.level] as MovieClip;
				item.callBackFunction = callBackFun;
				item.initialization();
			}

		}

		private function callBackFun(item : EctypalLevelItem) : void
		{
			if (item)
			{
				if (item.canToPrev)
				{
					index--;
					isPrev = true;
					pageContent();
				}
				else if (item.canToNext)
				{
					index++;
					isPrev = false;
					pageContent();
				}
				else if (callBackWriteTextFunc != null)
				{
					callBackWriteTextFunc.call(this, item);
				}
			}
		}

		private function pageContent() : void
		{
			callBackWriteTextFunc.call(this, null);
			isTweenOut = true;
			var endX : Number = isPrev ? Global.stageWidth : -Global.stageWidth;
			TweenMax.to(child, 0.3, {x: endX, onComplete: tweenOnComplete});
		}

		private function tweenOnComplete() : void
		{
			TweenMax.killTweensOf(child);
			if (isTweenOut)
			{
				FunctionUtils.removeChild(child);
				initialization();
				tweenIn();
			}
		}

		private function tweenIn() : void
		{
			isTweenOut = false;
			child.x = isPrev ? -Global.stageWidth : Global.stageWidth;
			TweenMax.to(child, 0.3, {x: 0, onComplete: tweenOnComplete});
		}


	}

}
