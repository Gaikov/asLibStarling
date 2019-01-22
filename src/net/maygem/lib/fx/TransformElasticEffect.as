package net.maygem.lib.fx
{
import net.maygem.lib.utils.UMath;

public class TransformElasticEffect extends TransformEffect
{
	private var _value:Number;
	private var _tMax:Number;
	private var _height:Number;

	public function TransformElasticEffect(frameStep:Number, tMax:Number, height:Number)
	{
		_tMax = UMath.clamp(tMax, 0, 1);
		_height = height;

		super(frameStep);
	}


	override public function get value():Number
	{
		return _value;
	}

	override internal function transformFunction():Number
	{
		if (_lerp < _tMax)
		{
			_value = (1 + _height) * Math.sin(_lerp / _tMax * (Math.PI / 2));
		}
		else
		{
			var _rad:Number = (_lerp - 1 + (1 - _tMax) / 2) / ((1 - _tMax) / 2) * (Math.PI / 2);
			_value = (1 + _height / 2 - _height / 2 * Math.sin(_rad));
		}

		return _value;
	}
}
}