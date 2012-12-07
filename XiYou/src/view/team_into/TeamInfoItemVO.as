package view.team_into
{


	/**
	 * 说明：TeamInfoItemVO
	 * @author Victor
	 * 2012-10-31
	 */

	public class TeamInfoItemVO
	{


		public function TeamInfoItemVO(type : int = 0, atParentX : Number = 0, atParentY : Number = 0, endScaleX : Number = 1, endScaleY : Number = 1)
		{
			setParams(type, atParentX, atParentY, endScaleX, endScaleY);
		}

		public function setParams(type : int, atParentX : Number, atParentY : Number, endScaleX : Number, endScaleY : Number) : void
		{
			this.type = type;
			this.atParentX = atParentX;
			this.atParentY = atParentY;
			this.endScaleX = endScaleX;
			this.endScaleY = endScaleY;
		}

		public var type : int = 0;
		public var atParentX : Number = 0;
		public var atParentY : Number = 0;
		public var endScaleX : Number = 1;
		public var endScaleY : Number = 1;


	}

}
