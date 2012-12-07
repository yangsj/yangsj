package view.arena.battle.roles
{

	import character.ComplexPawn;
	import character.FrameLabels;
	import character.Pawn;
	import character.PawnEvent;

	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;

	import datas.RolesID;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	import utils.FunctionUtils;

	import view.arena.battle.ArenaBattleType;





	/**
	 * 说明：ArenaBattleRoleBase
	 * @author Victor
	 * 2012-11-1
	 */

	public class ArenaBattleRoleBase extends Sprite
	{
		private const EFFECT_ROLE_ID : Array = [ 19, 20, 14 ];
		private const HP_MIN_PERCENT : Number = 0.2; /*  当HP值百分比小于该值时，进入暴怒状态 */
		private const MOVE_TO_ATTACK_OR_BACK_TIME : Number = 0.2; /* 从原来位置移动到被攻击者前和从被攻击者前返回到原来的位置的过程移动的时间 */


		private var _endX : Number = 0;
		private var _endY : Number = 0;
		private var _rows : int = 0;
		private var _cols : int = 0;
		private var _type : int;
		private var _isSkillToUse : Boolean = false; /* 是否有特技可以使用 */
		private var _roleID : int = 0;
		private var _isDead : Boolean = false;

		public var roleTarget : Pawn;
		public var attackOmpleteFun : Function;
		public var deadFun : Function;

		public function ArenaBattleRoleBase( roleID : int )
		{
			super();
			_isSkillToUse = false;
			_roleID = roleID;
			_isDead = false;
			mouseChildren = mouseEnabled = false;

			roleTarget = new ComplexPawn( _roleID.toString());

			addEvents();
		}

		/**
		 * 移动到将要攻击的人物边
		 * @param __x
		 * @param __y
		 * @param onComplete
		 */
		public function moveTOAttack( __x : Number, __y : Number, onComplete : Function = null ) : void
		{
			moveTO( this, MOVE_TO_ATTACK_OR_BACK_TIME, __x, __y, onComplete );
		}

		/**
		 * 攻击结束后，返回到原来的位置
		 * @param onComplete
		 */
		public function moveTOBack( onComplete : Function = null ) : void
		{
			moveTO( this, MOVE_TO_ATTACK_OR_BACK_TIME, _endX, _endY, onComplete );
		}

		public function playDefault() : void
		{
			if ( this.stage )
				roleTarget.playDefault();
		}

		public function playWalk() : void
		{
			if ( this.stage == null )
				return;

			roleTarget.setFrameHandler( FrameLabels.WALK, -1, function() : void
			{
				roleTarget.play([ FrameLabels.WALK ]);
			});
			roleTarget.play([ FrameLabels.WALK ]);
		}

		/** 攻击 */
		public function playAttack( attackTarget : ArenaBattleRoleBase ) : void
		{
			if ( this.stage )
			{
				addAttackEvents();
				if ( attackTarget && attackTarget.roleTarget )
				{
					if ( _isSkillToUse )
						roleTarget.attack( [attackTarget.roleTarget], true, 2.5 );
					else
						roleTarget.attack( [attackTarget.roleTarget] );
				}
				veer();

				attackTarget.x = attackTarget.endX;
				var xx : Number = attackTarget.isPlayer ? attackTarget.endX - 50 : attackTarget.endX + 50;
				TweenMax.to( attackTarget, 0.1, { x: xx, ease: Elastic.easeInOut, yoyo: true, repeat: 1, onCompleteParams: [ attackTarget ], onComplete: function( target : * ) : void
				{
					TweenMax.killTweensOf( target );
					target.x = target[ "endX" ];
				}});
			}
		}

		/** 受伤害（被攻击） */
		public function playHarmed() : void
		{
			if ( roleTarget == null )
				return;
			if ( _isDead )
				return;
			if ( _isSkillToUse )
				return;
			var lessPercent : Boolean = ( roleTarget.HP / roleTarget.fullHP ) <= HP_MIN_PERCENT;
			var hasEffect : Boolean = EFFECT_ROLE_ID.indexOf( _roleID ) != -1;
			if ( lessPercent && hasEffect )
			{
				roleTarget.rageStart();
				_isSkillToUse = true;
			}
		}

		public function setParams( endx : Number, endy : Number, rows : int, cols : int, type : int ) : void
		{
			_endX = endx;
			_endY = endy;
			_rows = rows;
			_cols = cols;
			_type = type;
			y = endy;
		}


		private function addEvents() : void
		{
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			roleTarget.addEventListener( PawnEvent.DISPOSE, deadFunHandler );
			roleTarget.addEventListener( PawnEvent.RAGE_START_COMPLETE, rageStartCompleteHandler );
			roleTarget.addEventListener( "dead", deadHandler );
		}

		private function addAttackEvents() : void
		{
			roleTarget.addEventListener( PawnEvent.ATTACK_COMPLETE, attackOmpleteFunHandler );
		}

		private function removeEvents() : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			roleTarget.removeEventListener( PawnEvent.DISPOSE, deadFunHandler );
			roleTarget.removeEventListener( PawnEvent.RAGE_START_COMPLETE, rageStartCompleteHandler );
			roleTarget.removeEventListener( PawnEvent.ATTACK_COMPLETE, attackOmpleteFunHandler );
			roleTarget.addEventListener( "dead", deadHandler );
		}

		protected function deadHandler( event : Event ) : void
		{
			_isDead = true;
		}

		protected function deadFunHandler( event : Event ) : void
		{
			roleTarget.removeEventListener( PawnEvent.DISPOSE, deadFunHandler );
			if ( deadFun != null )
				deadFun.call( this, this );
			deadFun = null;
		}

		protected function addedToStageHandler( event : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );

			roleTarget.damage = 38; //int( Math.random() * 5 + 34 );
			roleTarget.alliance = isPlayer ? "Player" : "";

			veer();
			this.addChild( roleTarget );
		}

		protected function removedFromStageHandler( event : Event ) : void
		{
			removeEvents();
			dispose();
		}

		protected function rageStartCompleteHandler( event : Event ) : void
		{
			roleTarget.removeEventListener( PawnEvent.RAGE_START_COMPLETE, rageStartCompleteHandler );
			playDefault();
		}

		protected function attackOmpleteFunHandler( event : Event ) : void
		{
			roleTarget.removeEventListener( PawnEvent.ATTACK_COMPLETE, attackOmpleteFunHandler );
			if ( attackOmpleteFun != null )
				attackOmpleteFun.apply( this );
			attackOmpleteFun = null;
		}

		private function veer() : void
		{
			isPlayer ? roleTarget.turnRight() : roleTarget.turnLeft();
		}

		private function dispose() : void
		{
			roleTarget.stopAnim();
			roleTarget.stopMove();
			FunctionUtils.removeChild( roleTarget );
//			FunctionUtils.removeChild(this);

			roleTarget = null;
			deadFun = null;
			attackOmpleteFun = null;

			_isDead = false;
			_isSkillToUse = false;
		}

		private function moveTO( display : DisplayObject, duration : Number, x : Number, y : Number, onComplete : Function = null, onCompleteParams : Array = null ) : void
		{
			TweenMax.to( display, duration, { x: x, y: y, onComplete: function( display : DisplayObject, onComplete : Function = null, onCompleteParams : Array = null ) : void
			{
				if ( onComplete != null )
				{
					if ( onCompleteParams )
						onComplete.apply( this, onCompleteParams );
					else
						onComplete.apply( this );
					onComplete = null;
					onCompleteParams = null;
				}
				TweenMax.killTweensOf( display );
			}, onCompleteParams: [ display, onComplete, onCompleteParams ]});
		}

		////////////////// getter/setter ///////////////////////////////////////

		public function get endX() : Number
		{
			return _endX;
		}

		public function get endY() : Number
		{
			return _endY;
		}

		public function get rows() : int
		{
			return _rows;
		}

		public function get cols() : int
		{
			return _cols;
		}

		public function get isPlayer() : Boolean
		{
			return _type == ArenaBattleType.PLAYER;
		}

		public function get isDead() : Boolean
		{
			return _isDead;
		}


	}

}
