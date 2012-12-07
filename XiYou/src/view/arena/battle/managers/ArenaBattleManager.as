package view.arena.battle.managers
{

	import com.greensock.TweenMax;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filters.GlowFilter;

	import utils.ArrayUtils;

	import view.arena.battle.ArenaBattleType;
	import view.arena.battle.roles.ArenaBattleRoleBase;


	/**
	 * 说明：ArenaBattleManager
	 * @author Victor
	 * 2012-11-1
	 */

	public class ArenaBattleManager extends EventDispatcher
	{
		private const DELAY_AFTER_ATTACK_TIME : Number = 0.7; /* 一次完整攻击动作做完后到下一次攻击间隔时间 */

		private var attacker : ArenaBattleRoleBase;
		private var defender : ArenaBattleRoleBase;
		private var container : DisplayObjectContainer;
		private var players : Vector.<ArenaBattleRoleBase>;
		private var enemyers : Vector.<ArenaBattleRoleBase>;
		private var attackType : int = ArenaBattleType.ENEMYER;
		private var isSwap : Boolean = false;
		private var index1 : int = -1;
		private var index2 : int = -1;

		public var result : int = -1;
		public var playerTeamsPoints : Array = [[], [], []];
		public var enemyerTeamsPoints : Array = [[], [], []];


		public function ArenaBattleManager()
		{
			players = new Vector.<ArenaBattleRoleBase>();
			enemyers = new Vector.<ArenaBattleRoleBase>();
		}

		public function dispose() : void
		{
			TweenMax.killChildTweensOf( attacker );
			TweenMax.killChildTweensOf( defender );

			ArrayUtils.removeAll( playerTeamsPoints );
			ArrayUtils.removeAll( enemyerTeamsPoints );
			ArrayUtils.removeAll( players );
			ArrayUtils.removeAll( enemyers );

			playerTeamsPoints = null;
			enemyerTeamsPoints = null;
			players = null;
			enemyers = null;
			attacker = null;
			defender = null;
			container = null;
		}

		public function initialization() : void
		{
			sortNewSequenceForRoles( players, playerTeamsPoints );
			sortNewSequenceForRoles( enemyers, enemyerTeamsPoints );

			delayedCallAttackStart(); // 延迟 
		}

		private function attackStart() : void
		{
			TweenMax.killDelayedCallsTo( attackStart );
			( attackType == ArenaBattleType.PLAYER ) ? checkAndSetRoles( false ) : checkAndSetRoles( true );
		}

		private function checkAndSetRoles( isPlayerAttack : Boolean ) : void
		{
			isSwap = false;
			attackType = isPlayerAttack ? ArenaBattleType.PLAYER : ArenaBattleType.ENEMYER;
			attacker = getSequenceItem( isPlayerAttack ? players : enemyers );
			if ( attacker )
				defender = getDefenderFromAttack( attacker ); //, (isPlayerAttack ? enemyerTeamsPoints : playerTeamsPoints));

			if ( defender && attacker )
			{
				if ( container == null )
					container = attacker.parent;
				setTargetParentIndex( false );
				var movex : Number = isPlayerAttack ? ( defender.x - 100 ) : ( defender.x + 100 );
				var movey : Number = defender.y;
				attacker.moveTOAttack( movex, movey, moveToAttackTweenHandler );
			}
			else
			{
				// 战斗结束 
				if ( attacker )
					result = attacker.isPlayer ? ArenaBattleType.WIN : ArenaBattleType.LOSE;
				else
					result = isPlayerAttack == false ? ArenaBattleType.WIN : ArenaBattleType.LOSE;

				this.dispatchEvent( new Event( Event.COMPLETE ));
			}
		}

		private function setTargetParentIndex( isOver : Boolean = true ) : void
		{
			if ( defender && attacker )
			{
				var parent1 : DisplayObjectContainer = attacker.parent;
				var parent2 : DisplayObjectContainer = defender.parent;
				if ( isOver )
				{
					if ( isSwap )
					{
						if ( parent1 )
							container.setChildIndex( attacker, index1 );
						if ( parent2 )
							container.setChildIndex( defender, index2 );
					}
					isSwap = false;
				}
				else
				{
					index1 = container.getChildIndex( attacker );
					index2 = container.getChildIndex( defender );
					if ( index1 <= index2 )
					{
						if ( parent1 )
							container.setChildIndex( attacker, index2 );
						if ( parent2 )
							container.setChildIndex( defender, index2 - 1 );
						isSwap = true;
					}
				}
			}
		}

		private function moveToAttackTweenHandler() : void
		{
			if ( defender && attacker )
			{
				attacker.attackOmpleteFun = attackComplete;
				defender.deadFun = defenderDead;
				attacker.playAttack( defender );
			}
		}

		private function defenderDead( defender : ArenaBattleRoleBase ) : void
		{
			if ( defender )
			{
				removeDeadRoleFromArray( defender );
				if ( defender.parent )
					defender.parent.removeChild( defender );
				defender = null;
			}
		}

		private function attackComplete() : void
		{
			if ( attacker )
			{
				attacker.playDefault();
				attacker.moveTOBack( delayedCallAttackStart );
			}
			if ( defender && defender.isDead == false)
			{
				defender.playHarmed();
			}
			setTargetParentIndex();
		}

		private function delayedCallAttackStart() : void
		{
			TweenMax.delayedCall( DELAY_AFTER_ATTACK_TIME, attackStart );
		}

		private function getSequenceItem( vec : Vector.<ArenaBattleRoleBase> ) : ArenaBattleRoleBase
		{
			var item : ArenaBattleRoleBase;
			if ( vec && vec.length > 0 )
			{
				item = vec.pop();
				vec.unshift( item );
			}
			return item;
		}

		private function removeDeadRoleFromArray( defender : ArenaBattleRoleBase ) : void
		{
			var isPlayer : Boolean = defender.isPlayer;
			var arr : Array = isPlayer ? playerTeamsPoints : enemyerTeamsPoints;
			var vec : Vector.<ArenaBattleRoleBase> = isPlayer ? players : enemyers;
			arr[ defender.rows ][ defender.cols ] = null;
			var index : int = vec.indexOf( defender );
			if ( index != -1 )
				vec.splice( index, 1 );
		}

		private function getDefenderFromAttack( item : ArenaBattleRoleBase ) : ArenaBattleRoleBase
		{
			if ( item == null )
				return null;
			var teams : Array = item.isPlayer ? enemyerTeamsPoints : playerTeamsPoints;
			for ( var cols : int = 2; cols >= 0; cols-- )
			{
				var rows : int = item.rows;
				var it0 : ArenaBattleRoleBase = teams[ rows ][ cols ] as ArenaBattleRoleBase;
				var it1 : ArenaBattleRoleBase; // = teams[ 0 ][ cols ] as ArenaBattleRoleBase;
				var it2 : ArenaBattleRoleBase; // = teams[ 1 ][ cols ] as ArenaBattleRoleBase;

				if ( it0 )
					return it0;

				if ( rows == 0 )
				{
					it1 = teams[ 1 ][ cols ] as ArenaBattleRoleBase;
					it2 = teams[ 2 ][ cols ] as ArenaBattleRoleBase;
				}
				else if ( rows == 1 )
				{
					it1 = teams[ 0 ][ cols ] as ArenaBattleRoleBase;
					it2 = teams[ 2 ][ cols ] as ArenaBattleRoleBase;
				}
				else if ( rows == 2 )
				{
					it1 = teams[ 1 ][ cols ] as ArenaBattleRoleBase;
					it2 = teams[ 0 ][ cols ] as ArenaBattleRoleBase;
				}

				if ( it1 )
					return it1;
				else if ( it2 )
					return it2;
			}
			return null;
		}

		private function sortNewSequenceForRoles( saveTargetArray : Vector.<ArenaBattleRoleBase>, checkTargetArray : Array ) : void
		{
			var item : ArenaBattleRoleBase;
			var array : Array;
			for each ( array in checkTargetArray )
			{
				for each ( item in array )
				{
					if ( item )
						saveTargetArray.push( item );
				}
			}
			saveTargetArray.sort( arraySortFun );

			item = null;
			array = null;
		}

		private function arraySortFun( a : ArenaBattleRoleBase, b : ArenaBattleRoleBase ) : Number
		{
			if ( a.cols > b.cols )
				return 1;
			else if ( a.cols == b.cols )
			{
				if ( a.rows <= b.rows )
					return 1;
				else
					return -1;
			}
			else
				return -1;
			return 0;
		}




	}

}
