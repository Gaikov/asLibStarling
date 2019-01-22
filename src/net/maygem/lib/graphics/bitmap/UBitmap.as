package net.maygem.lib.graphics.bitmap
{
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class UBitmap
{
	static public function createSquare(src:BitmapData):BitmapData
	{
		var size:int = src.width > src.height ? src.height : src.width;
		var res:BitmapData = new BitmapData(size, size);
		var rect:Rectangle = new Rectangle(
				(src.width - size) / 2,
				(src.height - size) / 2,
				size, size);

		res.copyPixels(src, rect, new Point(0, 0));
		return res;
	}


}
}