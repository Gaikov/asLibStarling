package net.maygem.lib.utils
{
public class Color
{
	static public const WHITE:Color = new Color(1, 1, 1);

	public var r:Number;
	public var g:Number;
	public var b:Number;

	function Color(red:Number = 0, green:Number = 0, blue:Number = 0)
	{
		r = red;
		g = green;
		b = blue;
	}

	public function setFromUINT(color:uint):void
	{
		setFromByte(
				(color >> 16) & 0xff,
				(color >> 8) & 0xff,
				color & 0xff);
	}

	public function setFromByte(r:uint, g:uint, b:uint):void
	{
		r = UMath.clamp(r / 0xff, 0, 1);
		g = UMath.clamp(g / 0xff, 0, 1);
		b = UMath.clamp(b / 0xff, 0, 1);
	}

	public function blend(other:Color, alpha:Number):void
	{
		r = r * (1 - alpha) + other.r * alpha;
		g = g * (1 - alpha) + other.g * alpha;
		b = b * (1 - alpha) + other.b * alpha;
	}

	public function toUINT():uint
	{
		return ( redByte() << 16)
				| ( greenByte() << 8)
				| blueByte();
	}

	public function redByte():uint
	{
		return toByte(r);
	}

	public function greenByte():uint
	{
		return toByte(g);
	}

	public function blueByte():uint
	{
		return toByte(b);
	}

	private function toByte(value:Number):uint
	{
		return UMath.clamp(value, 0, 1) * 0xff;
	}
}
}