package net.maygem.lib.utils
{
import flash.filters.BitmapFilter;
import flash.filters.ColorMatrixFilter;

public class UFilter
{
	static public function grayScale():BitmapFilter
	{
		return new ColorMatrixFilter(
				[
						0.5, 0.5, 0.5, 0, 0,
						0.5, 0.5, 0.5, 0, 0,
						0.5, 0.5, 0.5, 0, 0,
						0, 0, 0, 1, 0
				]);
	}
}
}