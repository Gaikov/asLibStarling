package net.maygem.lib.fx
{
public class TransformQuadricEffect extends TransformEffect
{
	private var _value:Number;

	public function TransformQuadricEffect(frameStep:Number)
	{
		super(frameStep);
	}

	override public function get value():Number
	{
		return _value;
	}

	override internal function transformFunction():Number
	{
		_value = _lerp * (2 - _lerp);
		return _value;
	}


}
}