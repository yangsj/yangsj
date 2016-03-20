package pet.game.panels.continuousLanding.control.tabbutton
{

	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * 说明：Tab选项卡管理<br>使用例：<br>
	 * <code><b>
	 * var tabButton:TabButtonControl = new TabButtonControl();<br>
	 * tabButton.addEventListener(TabButtonEvent.BUTTON_EVENT_CLICK, tabButtonClickHandler);<br>
	 * tabButton.addTabMovieClip(target1, container, TAB_BUTTON_ONE, true);<br>
	 * private function tabButtonClickHandler(e:TabButtonEvent):void<br>
	 * {<br>
	 * switch(e.nameType)<br>
	 * {<br>
	 * case TAB_BUTTON_ONE:<br>
	 * doSomeThing();<br>
	 * break;<br>
	 * }<br>
	 * }<br>
	 * </b></code>
	 * @author yangshengjin
	 */

	public class YsjTabButtonControl extends EventDispatcher
	{
		private var container:DisplayObjectContainer;
		private var currentBtn:YsjTabMovieClipButton;
		private var list:Dictionary;

		public function YsjTabButtonControl()
		{
			list = new Dictionary();
		}

		/////////////////////////////////////////public /////////////////////////////////

		/**
		 *
		 * @param $clip 包含指定标签的MovieClip对象
		 * @param $parent $clip的父容器
		 * @param $type  用以 侦听 事件 区分按钮的 type
		 * @param $data 关联数据
		 * @param $isCurrent 是否设置为当前默认的按钮
		 */
		public function addTabMovieClip( $clip:MovieClip, $parent:DisplayObjectContainer, $type:String, $isCurrent:Boolean = false, $data:Object = null ):void
		{
			var btn:YsjTabMovieClipButton = new YsjTabMovieClipButton();
			btn.targetButton = $clip;
			createAndInitBtn( btn, $parent, $type, $data, $isCurrent );
		}

		/**
		 * 自定义三个状态
		 * @param $out 鼠标移出状态， 正常状态
		 * @param $over 鼠标移上时 状态
		 * @param $down 鼠标按下状态， 选中状态
		 * @param $container 按钮 添加到的 容器
		 * @param $x 按钮位置 x
		 * @param $y 按钮位置 y
		 * @param $type 用以 侦听 事件 区分按钮的 type
		 * @param $data 关联数据
		 * @param $isCurrent 是否设置为当前默认的按钮
		 */
		public function addTabStatusClip( $out:InteractiveObject, $over:InteractiveObject, $down:InteractiveObject, $container:DisplayObjectContainer, $x:Number, $y:Number, $type:String, $isCurrent:Boolean = false, $data:Object = null ):void
		{
			var btn:YsjTabMovieClipButton = new YsjTabMovieClipButton();
			btn.mouseOutStatus = $out;
			btn.mouseOverStatus = $over;
			btn.mouseDownStatus = $down;
			btn.start();
			btn.x = $x;
			btn.y = $y;
			$container.addChild( btn );

			createAndInitBtn( btn, $container, $type, $data, $isCurrent );
		}

		public function removeTabMovieClip( $type:String ):void
		{
			var btn:YsjTabMovieClipButton = list[ $type ] as YsjTabMovieClipButton;
			if ( btn )
				btn.dispose();
			btn = null;
			delete list[ $type ];
		}

		/////////////////////////////////////////private ////////////////////////////////

		private function createAndInitBtn( btn:YsjTabMovieClipButton, $parent:DisplayObjectContainer, $type:String, $data:Object = null, $isCurrent:Boolean = false ):void
		{
			btn.data = $data;
			btn.type = $type;
			container = $parent;
			list[ $type ] = btn; 
			addAndRemoveEvents( true ); 
			if ( $isCurrent ) 
				dispath( btn ); 
		}

		private function dispath( btn:YsjTabMovieClipButton ):void
		{
			if ( currentBtn )
				currentBtn.setVisibleFromStatus( YsjTabButtonType.TYPE_MOUSEOUT );
			currentBtn = btn;
			currentBtn.setVisibleFromStatus( YsjTabButtonType.TYPE_MOUSEDOWN );

			var evt:YsjTabButtonEvent = new YsjTabButtonEvent( YsjTabButtonEvent.BUTTON_EVENT_CLICK );
			evt.nameType = currentBtn.type;
			evt.clickBtn = currentBtn;
			this.dispatchEvent( evt );
		}

		private function clears():void
		{
			if ( list )
			{
				for ( var key:String in list ) 
					removeTabMovieClip( key ); 
				list = null;
			}
			container = null;
			currentBtn = null;
		}

		/////////////////////////////////////////events//////////////////////////////////

		private function addAndRemoveEvents( isAdd:Boolean ):void
		{
			if ( isAdd )
			{
				if ( container )
				{
					container.addEventListener( YsjTabButtonEvent.TYPE_TARGET_CLICK, buttonEventHandler );
					container.addEventListener( Event.REMOVED_FROM_STAGE, removedFromStage );
				}
			}
			else
			{
				if ( container )
				{
					container.removeEventListener( YsjTabButtonEvent.TYPE_TARGET_CLICK, buttonEventHandler );
					container.removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStage );
				}
			}
		}

		private function removedFromStage( e:Event ):void
		{
			addAndRemoveEvents( false );
			clears();
		}

		private function buttonEventHandler( e:YsjTabButtonEvent ):void
		{
			if ( currentBtn == e.clickBtn )
				return;
			dispath( e.clickBtn );
		}

		
	}
}
