package net.maygem.lib.math.spline
{
public class Polynomial
{
	private var _a:Number;
	private var _b:Number;
	private var _c:Number;
	private var _d:Number;

	public function Polynomial(pos1:Number, vel1:Number, pos2:Number, vel2:Number, time:Number)
	{
		_d = pos1;
		_c = vel1;
		_a = 2.0 * ( ( vel2 + vel1 ) * time / 2.0 + pos1 - pos2 ) / Math.pow(time, 3.0);
		_b = ( -vel2 - 2.0 * vel1 - 3.0 * ( pos1 - pos2 ) / time ) / time;
	}

	public function computePos(time:Number):Number
	{
		return _a * Math.pow(time, 3.0) + _b * Math.pow(time, 2.0) + _c * time + _d;
	}
}
}