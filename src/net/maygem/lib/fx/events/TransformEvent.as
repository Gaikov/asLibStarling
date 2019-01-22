package net.maygem.lib.fx.events
{
import flash.events.Event;

public class TransformEvent extends Event
{
	static public const VALUE_CHANGED:String = "valueChanged";
	static public const TRANSFORM_COMPLETE:String = "transformComplete";

	private var _value:Number;

	public function TransformEvent(type:String, value:Number)
	{
		super(type);
		_value = value;
	}

	public function get value():Number
	{
		return _value;
	}

	override public function clone():Event
	{
		return new TransformEvent(type, _value);
	}
}
}