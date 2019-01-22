package net.maygem.lib.utils
{
import flash.geom.Point;

public class UMath
{
	static public function lerp(a:Number, b:Number, t:Number):Number
	{
		return a + (b - a) * t;
	}

	static public function clamp(value:Number, minValue:Number, maxValue:Number):Number
	{
		var min:Number = minValue;
		var max:Number = maxValue;
		if (min > max)
		{
			var tmp:Number = min;
			min = max;
			max = tmp;
		}

		if (value < min)
		{
			value = min;
		}
		else if (value > max)
		{
			value = max;
		}
		return value;
	}

	static public function move(start:Number, end:Number, curr:Number, step:Number):Number
	{
		var dir:Number = end - start;
		if (!dir)
		{
			return end;
		}

		dir = dir / Math.abs(dir);
		curr += step * dir;

		return clamp(curr, start, end);
	}

	static public function inRange(a:Number, min:Number, max:Number):Boolean
	{
		if (min > max)
		{
			var tmp:Number = min;
			min = max;
			max = tmp;
		}
		return min <= a && a <= max;
	}

	static public function max(list:Array):Number
	{
		var res:Number = list[0];
		for (var i:int = 1; i < list.length; i++)
		{
			if (res < list[i])
			{
				res = list[i];
			}
		}
		return res;
	}

	static public function sign(n:Number):Number
	{
		if (!n)
		{
			return 0;
		}
		return n / Math.abs(n);
	}

	static public function signRandom():Number
	{
		return Math.random() > 0.5 ? -1 : 1;
	}

	static public function random(max:int):int
	{
		return Math.round(Math.random() * max);
	}

	static public function randomRange(min:Number, max:Number):Number
	{
		return Math.random() * (max - min) + min;
	}

	static public function randomRangeSign(min:Number, max:Number):Number
	{
		var v:Number = randomRange(min, max);
		return Math.random() > 0.5 ? v : -v;
	}

	static public function rad2deg(rad:Number):Number
	{
		return rad * 180.0 / Math.PI;
	}

	static public function deg2rad(deg:Number):Number
	{
		return deg * Math.PI / 180.0;
	}

	static public function pointDot(p1:Point, p2:Point):Number
	{
		return p1.x * p2.x + p1.y * p2.y;
	}

	static public function getRightVector(p:Point):Point
	{
		return new Point(p.y, -p.x);
	}

	static public function clampSignedToMin(signedValue:Number, unsignedMin:Number):Number
	{
		if (!signedValue)
		{
			return signedValue;
		}

		var absValue:Number = Math.abs(signedValue);

		if (absValue < unsignedMin)
		{
			var sign:Number = signedValue / absValue;
			signedValue = unsignedMin;
			signedValue *= sign;
		}

		return signedValue;
	}

	public static function closestAngle(from:Number, to:Number):Number
	{
		from = normalizeAngle(from);
		to = normalizeAngle(to);

		var delta:Number = to - from;
		if (delta < -180.0)
		{
			to += 360.0;
		}
		else if (delta > 180.0)
		{
			to -= 360.0;
		}
		return to;
	}

	public static function normalizeAngle(angle:Number):Number
	{
		angle = angle % 360.0;
		if (angle < 0)
		{
			angle = 360 + angle;
		}
		return angle;
	}
}
}