package net.maygem.lib.utils
{
import flash.geom.Matrix;
import flash.geom.Point;

public class UPoint
{
	static public function distance(p1:Point, p2:Point):Number
	{
		var res:Point = p2.subtract(p1);
		return res.length;
	}

	static public function computeAngle(from:Point, to:Point):Number
	{
		var dir:Point = to.subtract(from);
		dir.normalize(1);
		return Math.atan2(dir.x, dir.y);
	}

	static public function dotProduct(p1:Point, p2:Point):Number
	{
		return p1.x * p2.x + p1.y * p2.y;
	}

	static public function move(from:Point, to:Point, step:Number):Point
	{
		var dir:Point = to.subtract(from);
		var dist:Number = dir.length;
		if (!dist) return null;

		dir.x = dir.x / dist * step;
		dir.y = dir.y / dist * step;

		var res:Point = from.add(dir);

		var dir2:Point = to.subtract(res);

		if (dotProduct(dir2, dir) <= 0)
			return null;

		return res;
	}

	static public function random(length:Number):Point
	{
		var res:Point = new Point(
				Math.random() * 100 - 50,
				Math.random() * 100 - 50);

		res.normalize(length);
		return res.clone();
	}

	public static function scale(p:Point, scale:Number):void
	{
		p.x *= scale;
		p.y *= scale;
	}

	public static function rotate(pos:Point, angle:Number):Point
	{
		var m:Matrix = new Matrix();
		m.rotate(UMath.deg2rad(angle));
		return m.transformPoint(pos);
	}
	
	public static function direction(from:Point, to:Point, scaleFactor:Number = 1):Point
	{
		var res:Point = to.subtract(from);
		res.normalize(scaleFactor);
		return res;
	}

	public static function toInt(pos:Point):Point
	{
		return new Point(int(pos.x), int(pos.y));
	}

	public static function round(pos:Point):Point
	{
		return new Point(Math.round(pos.x), Math.round(pos.y));
	}

	public static function set(pos:Point, x:Number, y:Number):void
	{
		pos.x = x;
		pos.y = y;
	}
}
}