package net.maygem.lib.utils
{
import flash.geom.Point;
import flash.geom.Rectangle;

public class URectangle
{
	static public function union(list:Array):Rectangle
	{
		var res:Rectangle = new Rectangle();
		for each (var rect:Rectangle in list)
			res = res.union(rect);
		return res;
	}

	static public function center(rect:Rectangle):Point
	{
		return new Point(rect.left + rect.width / 2, rect.top + rect.height / 2);
	}
}
}