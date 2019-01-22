/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.2.12
 */
package net.maygem.lib.graphics.bitmap
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class CachedFrame
{
	private var _bitmapData:BitmapData;
	private var _offset:Point;

	public function CachedFrame(bitmapData:BitmapData, offset:Point)
	{
		_bitmapData = bitmapData;
		_offset = offset;
	}

	public function get bitmapData():BitmapData
	{
		return _bitmapData;
	}

	public function get offset():Point
	{
		return _offset;
	}
	
	public function createFrame():Bitmap
	{
		var bm:Bitmap = new Bitmap(_bitmapData, "auto", true);
		bm.x = _offset.x;
		bm.y = _offset.y;
		return bm;
	}

	public function createSprite():Sprite
	{
		var sprite:Sprite = new Sprite();
		sprite.addChild(createFrame());
		return sprite;
	}

	static public function renderObject(obj:DisplayObject, border:int = 0):CachedFrame
	{
		obj.rotation = 0;
		obj.x = 0;
		obj.y = 0;
		var bounds:Rectangle = obj.getBounds(new Sprite());
		bounds = new Rectangle(bounds.left - border, bounds.top - border, bounds.width + border * 2, bounds.height + border * 2);

		var offsX:int = Math.floor(bounds.left);
		var offsY:int = Math.floor(bounds.top);

/*
		var diffX:Number = bounds.left - offsX;
		var diffY:Number = bounds.top - offsY;
*/

		var w:int = Math.ceil(bounds.right) - offsX;
		var h:int = Math.ceil(bounds.bottom) - offsY;

		var bm:BitmapData = new BitmapData(w, h, true, 0);
		var m:Matrix = new Matrix(obj.scaleX, 0, 0, obj.scaleY,
			-offsX,
			-offsY);

		bm.draw(obj, m);

		return new CachedFrame(bm, new Point(offsX, offsY));
	}

	static public function createCached(obj:DisplayObject):DisplayObject
	{
		return renderObject(obj).createFrame();
	}

	static public function cachedSprite(obj:DisplayObject):Sprite
	{
		return renderObject(obj).createSprite();
	}
}
}
