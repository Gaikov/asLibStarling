package net.maygem.lib.scene.manipulator
{
import starling.display.Sprite;

public class ManipulableSprite extends Sprite implements IManipulableObject
{
	private var _policy:ManipulableObjectPolicy;

	public function ManipulableSprite(manipulatorName:String, parentManipulator:DisplayObjectManipulator = null)
	{
		super();
		_policy = new ManipulableObjectPolicy(manipulatorName, this, parentManipulator);
	}

	public function get manipulator():DisplayObjectManipulator
	{
		return _policy.manipulator;
	}
}
}