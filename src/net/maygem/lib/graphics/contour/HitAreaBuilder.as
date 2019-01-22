package net.maygem.lib.graphics.contour
{
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.filters.BlurFilter;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

import net.maygem.lib.graphics.copy.GraphicsProxy;

public class HitAreaBuilder
{
	static public function create(obj:DisplayObject, blur:int, alphaThreshold:int, contourStep:int = 1, useProxy:GraphicsProxy = null):Sprite
	{
		var oldFilters:Array = obj.filters;
		obj.filters = [new BlurFilter(blur, blur, 10)];

		var rect:Rectangle = obj.getBounds(obj);
		rect.left = rect.left * obj.scaleX - blur;
		rect.right = rect.right * obj.scaleX + blur;
		rect.top = rect.top * obj.scaleY - blur;
		rect.bottom = rect.bottom * obj.scaleY + blur;

		var bmData:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
		var resData:BitmapData = new BitmapData(rect.width, rect.height);
		var m:Matrix = new Matrix();
		m.translate(-rect.x, -rect.y);
		bmData.draw(obj, m, new ColorTransform(0, 0, 0, 1, 255, 255, 255, 0));

		var threshold:uint = alphaThreshold << 24;

		resData.threshold(bmData,
				new Rectangle(0, 0, bmData.width, bmData.height), new Point(0, 0),
				"<",
				threshold,
				0x00000000,
				0xff000000);

		obj.filters = oldFilters;
		var c:BitmapContourFinder = new BitmapContourFinder(resData, alphaThreshold);

		var contour:Array = c.contour;
		if (contour.length > 1)
		{
			var spr:Sprite = new Sprite();
			var gr:Object = spr.graphics;
			if (useProxy)
			{
				useProxy.graphics = spr.graphics;
				gr = useProxy;
			}

			var pos:PixelPos = contour[0];
			gr.beginFill(0xffffff);
			gr.lineStyle(1, 0xff0000);
			gr.moveTo(pos.x + rect.x, pos.y + rect.y);
			for (var i:int = 1; i < contour.length; i += contourStep)
			{
				pos = contour[i];
				gr.lineTo(pos.x + rect.x, pos.y + rect.y);
			}
			gr.endFill();
			spr.cacheAsBitmap = true;
			return spr;
		}

		return null;
	}
}
}