package net.maygem.lib.fx
{

public class TransformLinearEffect extends TransformEffect
{
	public function TransformLinearEffect(frameStep:Number)
	{
		super(frameStep);
	}

	override internal function transformFunction():Number
	{
		return _lerp;
	}
}
}