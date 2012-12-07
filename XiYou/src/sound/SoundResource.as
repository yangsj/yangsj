package sound {
	/**
	 * @author Chenzhe
	 */
	public class SoundResource {
		public static const instance : SoundResource = new SoundResource;
		// [Embed(source="../resource/sound/暴击.mp3", mimeType="application/octet-stream")]
		// public var critical_attack : Class;
		[Embed(source="../resource/sound/骑兵攻击.mp3", mimeType="application/octet-stream")]
		public var enemy_attack : Class;
		[Embed(source="../resource/sound/砸击系攻击.mp3", mimeType="application/octet-stream")]
		public var player_attack : Class;
		[Embed(source="../resource/sound/特技发动1.mp3", mimeType="application/octet-stream")]
		public var rage_start : Class;
		// [Embed(source="../resource/sound/特技攻击.mp3", mimeType="application/octet-stream")]
		// public var rage_attack : Class;
		// [Embed(source="../resource/sound/猪八戒特技.mp3", mimeType="application/octet-stream")]
		// public var zhubajie_rage_attack : Class;
		// [Embed(source="../resource/sound/敌方挨打.mp3", mimeType="application/octet-stream")]
		// public var enemy_hurt : Class;
		// [Embed(source="../resource/sound/敌方挨打2.mp3", mimeType="application/octet-stream")]
		// public var dead : Class;
		// [Embed(source="../resource/sound/挨打2.mp3", mimeType="application/octet-stream")]
		// public var hurt : Class;
		// [Embed(source="../resource/sound/战斗开始.mp3", mimeType="application/octet-stream")]
		// public var battle_start : Class;
		// [Embed(source="../resource/sound/我方启动.mp3", mimeType="application/octet-stream")]
		// public var player_team_battle_start : Class;
		// [Embed(source="../resource/sound/骑兵启动.mp3", mimeType="application/octet-stream")]
		// public var knight_start : Class;
		[Embed(source="../resource/sound/宝箱开启.mp3", mimeType="application/octet-stream")]
		public var chest_open : Class;
		[Embed(source="../resource/sound/冒险关卡.mp3", mimeType="application/octet-stream")]
		public var bg_battle : Class;
		[Embed(source="../resource/sound/背景音乐.mp3", mimeType="application/octet-stream")]
		public var background : Class;
	}
}
