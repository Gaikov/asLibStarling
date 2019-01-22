/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.particles.modifiers
{
public class Factory
{
	private static var _instance:Factory;

	private var _map:Object = {};

	public function Factory()
	{
		_map[LifeModifier.NAME] = LifeModifier;
		_map[LinerPosModifier.NAME] = LinerPosModifier;
		_map[ScaleByLifeModifier.NAME] = ScaleByLifeModifier;
		_map[PosInitModifier.NAME] = PosInitModifier;
		_map[VelByPosInit.NAME] = VelByPosInit;
		_map[AccelModifier.NAME] = AccelModifier;
		_map[ScaleModifier.NAME] = ScaleModifier;
		_map[GravityModifier.NAME] = GravityModifier;
		_map[VelScalePosInit.NAME] = VelScalePosInit;
		_map[RotateToVelModifier.NAME] = RotateToVelModifier;
		_map[ScaleGraphModifier.NAME] = ScaleGraphModifier;
		_map[AngleModifier.NAME] = AngleModifier;
	}

	public static function get instance():Factory
	{
		if (!_instance)
			_instance = new Factory();
		return _instance;
	}

	public function create(name:String):IParticleModifier
	{
		var cls:Class = _map[name];
		return new cls();
	}
}
}
