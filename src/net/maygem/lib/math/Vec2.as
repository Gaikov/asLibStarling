package net.maygem.lib.math
{
import flash.geom.Point;

public class Vec2
{
	public var _x:Number;
	public var _y:Number;

	public function Vec2(x:Number = 0, y:Number = 0)
	{
		_x = x;
		_y = y;
	}

	public function scale(t:Number):Vec2
	{
		return new Vec2(_x * t, _y * t);
	}

	public function subtract(v:Vec2):Vec2
	{
		return new Vec2(_x - v._x, _y - v._y);
	}

	public function toString():String
	{
		return "Vec2(" + _x + ", " + _y + ")";
	}

	static public function fromPoint(p:Point):Vec2
	{
		return new Vec2(p.x, p.y);
	}
}
}