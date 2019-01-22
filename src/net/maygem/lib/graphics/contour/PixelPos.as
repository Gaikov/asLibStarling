package net.maygem.lib.graphics.contour
{
public class PixelPos
{
	private var _x:int;
	private var _y:int;

	public function PixelPos(x:int, y:int)
	{
		_x = x;
		_y = y;
	}

	public function get x():int
	{
		return _x;
	}

	public function get y():int
	{
		return _y;
	}
}
}