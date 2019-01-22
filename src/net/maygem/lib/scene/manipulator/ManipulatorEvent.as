package net.maygem.lib.scene.manipulator
{
public class ManipulatorEvent
{
	private var _target:DisplayObjectManipulator;
	private var _eventName:String;

	public function ManipulatorEvent(target:DisplayObjectManipulator, eventName:String)
	{
		_target = target;
		_eventName = eventName;
	}

	public function get target():DisplayObjectManipulator
	{
		return _target;
	}

	public function get eventName():String
	{
		return _eventName;
	}
}
}