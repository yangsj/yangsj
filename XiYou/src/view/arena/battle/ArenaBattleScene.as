package view.arena.battle
{

	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.events.TweenEvent;

	import datas.TeamInfoData;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getTimer;

	import global.DeviceType;
	import global.Global;

	import newview.SpriteBase;
	import newview.navi.MainNaviView;

	import ui.bg.ResourceArenaBattleBackground;

	import utils.ArrayUtils;
	import utils.FunctionUtils;

	import view.AlertPanel;
	import view.ViewBase;
	import view.arena.battle.managers.ArenaBattleManager;
	import view.arena.battle.roles.ArenaBattleRoleBase;


	/**
	 * 说明：ArenaBattleScene
	 * @author Victor
	 * 2012-11-1
	 */

	public class ArenaBattleScene extends SpriteBase
	{
		/** 体形较大的人物id */
		private const BODY_BIG_ID : Array = [ 4, 5, 6, 7, 8, 9, 10, 15, 18 ];

		private const MAX_NUM : int = 4;
		private const CON_WIDTH : Number = 1024;
		private const CON_HEIGHT : Number = 768;
		private const GO_SCENE_TIME : Number = 2;

		private var playerTeam : Array = TeamInfoData.selected;
		private var enemyTeam : Array = TeamInfoData.enemyerTeams;
		private var backGroundRes : Sprite;
		private var container : Sprite;
		private var goinOver : Boolean = false; /* 人物入场完毕 */
		private var battleManager : ArenaBattleManager;
		private var containerChildrenVec : Vector.<ArenaBattleRoleBase> = new Vector.<ArenaBattleRoleBase>();

//		private var teamsOrder : Array = [[ 0, 0 ], [ 0, 1 ], [ 0, 2 ], [ 1, 0 ], [ 1, 1 ], [ 1, 2 ], [ 2, 0 ], [ 2, 1 ], [ 2, 2 ]];
		private var teamsOrder : Array = [[[ 0, 0 ], [ 0, 2 ], [ 1, 1 ], [ 2, 2 ]], [[ 0, 0 ], [ 1, 1 ], [ 2, 0 ], [ 2, 2 ]], [[ 0, 0 ], [ 0, 2 ], [ 2, 0 ], [ 2, 2 ]], [[ 0, 1 ], [ 1, 0 ], [ 1, 2 ], [ 2, 1 ]]];


		private var timelineMax : TimelineMax = new TimelineMax();
		private var timelineArray : Array = [];

		public function ArenaBattleScene()
		{
			playerTeam = playerTeam.length <= MAX_NUM ? playerTeam : playerTeam.slice( 0, MAX_NUM );
			enemyTeam = enemyTeam.length <= MAX_NUM ? enemyTeam : enemyTeam.slice( 0, MAX_NUM );

			sortBodyBigAhead( playerTeam );
			sortBodyBigAhead( enemyTeam );

			super()
		}

		private function sortBodyBigAhead( array : Array ) : void
		{
			if ( array )
			{
				var leng : int = array.length;
				var i : int = 0;
				for ( i = 0; i < leng; i++ )
				{
					var id : int = int( array[ i ]);
					if ( BODY_BIG_ID.indexOf( id ) != -1 )
					{
						array.splice( i, 1 );
						array.unshift( id );
					}
				}
			}
		}

		override protected function addedToStageHandler( event : Event ) : void
		{
			super.addedToStageHandler( event );

			TweenMax.delayedCall( 1, createRole );
		}

		override protected function clear() : void
		{
			super.clear();

			battleManager.dispose();

			FunctionUtils.removeChild( container );
			FunctionUtils.removeChild( backGroundRes );

			battleManager = null;
			backGroundRes = null;
			container = null;
			playerTeam = null;
			enemyTeam = null;
		}

		override protected function addEvents() : void
		{
			super.addEvents();
			battleManager.addEventListener( Event.COMPLETE, battleCompleteHandler );
		}

		override protected function removeEvents() : void
		{
			super.removeEvents();
			battleManager.removeEventListener( Event.COMPLETE, battleCompleteHandler );
		}

		override protected function createResource() : void
		{
			backGroundRes = new ResourceArenaBattleBackground();

			container = new Sprite();
			container.graphics.lineStyle( 1, 0, 0 );
			container.graphics.drawRect( 0, 0, CON_WIDTH, CON_HEIGHT );
			container.graphics.endFill();

			addChild( backGroundRes );
			addChild( container );
			container.mouseChildren = container.mouseEnabled = false;

			battleManager = new ArenaBattleManager();

			AlertPanel.instance.show( "正在加载并初始化资源, 请稍等……", "初始化", true );
		}

		private function createRole() : void
		{
			TweenMax.killDelayedCallsTo( createRole );
			createLayoutItem( playerTeam, true );
			createLayoutItem( enemyTeam, false );
			initTimeLineMax();
			TweenMax.delayedCall( 1, displayWalkToScene );
		}

		protected function battleCompleteHandler( event : Event ) : void
		{
			// 战斗结束
			TweenMax.delayedCall( 2, MainNaviView.instance.show );
		}

		private function displayWalkToScene() : void
		{
			TweenMax.killDelayedCallsTo( displayWalkToScene );

			AlertPanel.instance.removed();

			addItemToStage();
			timelineMax.play();
		}

		private function addItemToStage() : void
		{
			containerChildrenVec.sort( sortChildrenIndexFun );
			for each ( var item : ArenaBattleRoleBase in containerChildrenVec )
			{
				container.addChild( item );
				item.playWalk();
			}
			ArrayUtils.removeAll( containerChildrenVec );
			containerChildrenVec = null;
		}

		private function createLayoutItem( teams : Array, isPlayer : Boolean ) : void
		{
			const DIS_X : Number = 110;
			const DIS_Y : Number = 50;
			const START_Y : Number = isPlayer ? 500 : 530;
			const START_L : Number = 120;
			const START_R : Number = 900;
			const GO_DISTANE : Number = START_L + DIS_X * 3 + 50;

			ArrayUtils.randomSortOn( teamsOrder );

			var length : int = teams.length;
			var arrayIDs : Array = teamsOrder[ 0 ];
			for ( var i : int = 0; i < length; i++ )
			{
				var arr : Array = arrayIDs[ i ] as Array;
				var rows : int = arr[ 0 ];
				var cols : int = arr[ 1 ];
				var endx : Number = isPlayer ? ( START_L + DIS_X * cols ) : ( START_R - DIS_X * cols );
				var endy : Number = isPlayer ? ( START_Y + DIS_Y * rows ) : ( START_Y + DIS_Y * rows );
				var item : ArenaBattleRoleBase = new ArenaBattleRoleBase( teams[ i ].toString());
				item.x = isPlayer ? ( endx - GO_DISTANE ) : ( endx + GO_DISTANE );
				item.setParams( endx, endy, rows, cols, isPlayer ? ArenaBattleType.PLAYER : ArenaBattleType.ENEMYER );
				if ( isPlayer )
					battleManager.playerTeamsPoints[ rows ][ cols ] = item;
				else
					battleManager.enemyerTeamsPoints[ rows ][ cols ] = item;
				timelineArray.push( TweenMax.to( item, GO_SCENE_TIME, { x: endx, y: endy, ease: Linear.easeNone, onComplete: tweenComplete, onCompleteParams: [ item ]}));
				containerChildrenVec.push( item );
			}
		}

		private function initTimeLineMax() : void
		{
			timelineMax.appendMultiple( timelineArray, 0, TweenAlign.START, 0.05 );
			timelineMax.addEventListener( TweenEvent.COMPLETE, tweenlineComplete );
			timelineMax.pause();
		}

		private function sortChildrenIndexFun( a : ArenaBattleRoleBase, b : ArenaBattleRoleBase ) : Number
		{
			if ( a.endY > b.endY )
				return 1;
			else if ( a.endY == b.endY )
			{
				if ( a.endX < CON_WIDTH * 0.5 && b.endX < CON_WIDTH * 0.5 )
				{
					if ( a.endX > b.endX )
						return 1;
					else
						return -1;
				}
				else
				{
					if ( a.endX > b.endX )
						return -1;
					else
						return 1;
				}
			}
			else
				return -1;
			return 0;
		}

		protected function tweenlineComplete( event : TweenEvent ) : void
		{
			timelineMax.removeEventListener( TweenEvent.COMPLETE, tweenlineComplete );

			onCompleteLayout();

			ArrayUtils.removeAll( timelineArray );
			timelineMax = null;
			timelineArray = null;
		}

		private function tweenComplete( item : ArenaBattleRoleBase ) : void
		{
			if ( item )
			{
				TweenMax.killTweensOf( item );
				item.playDefault();
				item = null;
			}
		}

		private function onCompleteLayout() : void
		{
			battleManager.initialization();
		}


	}

}
