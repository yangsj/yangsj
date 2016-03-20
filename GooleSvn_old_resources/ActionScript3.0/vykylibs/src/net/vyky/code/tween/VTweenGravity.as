package net.vyky.code.tween
{
	import flash.display.DisplayObject;
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2012-1-13 下午06:17:03
	 */
	public class VTweenGravity
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var targetVector:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		private var varsVector:Vector.<VTweenGravityVars> = new Vector.<VTweenGravityVars>();
		private var nameArray:Array = new Array();
		
		public function VTweenGravity()
		{
			
		}
		
		/////////////////////////////////////////static /////////////////////////////////

		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public function addItem($target:DisplayObject, 
								$targetName:String, 
								$duration:Number, 
								$delay:Number = 0,
								$onUpdateListener:Function = null, 
								$onCompleteListener:Function = null):VTweenGravity
		{
			targetVector[$targetName] = $target;
			var vars:VTweenGravityVars = new VTweenGravityVars();
			vars.target = $target;
			vars.targetName = $targetName;
			vars.delay = $delay;
			vars.onUpdateListener = $onUpdateListener;
			vars.onCompleteListener = $onCompleteListener;
			varsVector[$targetName] = vars;
			nameArray.push($targetName);
			
			return this;
		}
		
		public function removeItem($targetName:String):void
		{
			
		}
		
		public function start():void
		{
			
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}