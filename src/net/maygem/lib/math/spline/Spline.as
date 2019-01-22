package net.maygem.lib.math.spline
{
import flash.geom.Point;

public class Spline
{
	private var _polyX:Polynomial;
	private var _polyY:Polynomial;

	public function Spline()
	{
	}

	public function setSegment(pos1:Point, vel1:Point, pos2:Point, vel2:Point, time:Number):void
	{
		_polyX = new Polynomial(pos1.x, vel1.x, pos2.x, vel2.x, time);
		_polyY = new Polynomial(pos1.y, vel1.y, pos2.y, vel2.y, time);
	}

	public function computePos(time:Number):Point
	{
		return new Point(_polyX.computePos(time), _polyY.computePos(time));
	}
}
}