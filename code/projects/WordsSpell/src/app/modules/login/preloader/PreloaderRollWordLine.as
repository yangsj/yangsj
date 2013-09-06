package app.modules.login.preloader
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	
	import app.Language;
	
	import victor.framework.utils.BitmapUtil;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.TextFiledUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class PreloaderRollWordLine extends Sprite
	{
		private var txtLine:TextField;
		private var maskShape:Shape;
		private var wordArray:Array;
		private var lastIndex:int;
		
		private const HEIGHT:Number = 20;
		
		public function PreloaderRollWordLine()
		{
			this.graphics.beginFill(0,0);
			this.graphics.drawRect( 0, 0, 500, HEIGHT);
			this.graphics.endFill();
			
			txtLine = TextFiledUtil.create( "", 14, 0xffffff, TextFormatAlign.CENTER );
			txtLine.width = 500;
			txtLine.height = HEIGHT;
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			
			this.mask = null;
			TweenMax.killDelayedCallsTo( start );
			DisplayUtil.removedAll( this );
			DisplayUtil.removedFromParent( maskShape );
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			
			maskShape = new Shape();
			maskShape.graphics.beginFill(0, 0);
			maskShape.graphics.drawRect( 0, 0, 500, HEIGHT);
			maskShape.graphics.endFill();
			maskShape.x = x;
			maskShape.y = y;
			parent.addChild( maskShape );
			this.mask = maskShape;
			
			wordArray = Language.PreloaderRollWordLine_0.split("|");
			
			if ( wordArray && wordArray.length > 0 )
			{
				start();
			}
		}		
		
		private function start():void
		{
			var index:int;
			var bitmap:Bitmap;
			while ( index == lastIndex )
			{
				index = int(wordArray.length * Math.random());
			}
			
			lastIndex = index;
			txtLine.text = wordArray[ lastIndex ];
			bitmap = BitmapUtil.cloneBitmapFromTarget( txtLine );
			bitmap.y = HEIGHT;
			bitmap.alpha = 0;
			addChild( bitmap );
			
			const moveTime:Number = 0.4;
			const delayTime:Number = 2.4;
			
			TweenMax.to( bitmap, moveTime, { y:0, alpha:1, ease:Linear.easeNone });
			TweenMax.to( bitmap, moveTime, { y:-HEIGHT, alpha:0, ease:Linear.easeNone, delay:delayTime, onComplete:BitmapUtil.disposeBitmapFromTarget, onCompleteParams:[ bitmap ]});
			TweenMax.delayedCall( delayTime, start );
		}		
		
		/*
		和同学比赛提高得更快哦
		练习模式将记录你曾经出错过的单词
		是不是感觉越来越难了,努力提高自己吧
		玩过的关卡可以重复玩
		遇到困难请老师和同学帮忙吧
		学无止境,游戏中的提高也是如此
		*/
		
		
		
	}
}