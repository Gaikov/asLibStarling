package net.maygem.lib.graphics.bitmap
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

import net.maygem.lib.utils.UContainer;

public class CachedBitmap extends Sprite
{
	static private const MAX_BITMAP_SIZE:int = 2800;

	private var _originalWidth:int = 0;
	private var _originalHeight:int = 0;

	private var _obj:DisplayObject;

	private var _offset:Point = new Point(0, 0);
	private var _transparent:Boolean = false;

	private var _width:int = 0;
	private var _height:int = 0;
	private var _colorTransform:ColorTransform;

	public function CachedBitmap(obj:DisplayObject, transparent:Boolean, initWidth:int, initHeight:int, colorTransform:ColorTransform = null)
	{
		super();
		mouseEnabled = false;
		mouseChildren = false;
		_colorTransform = colorTransform;
		if (!_colorTransform) _colorTransform = new ColorTransform();

		_obj = obj;
		_transparent = transparent;
		var rect:Rectangle = obj.getBounds(new Sprite());
		_offset.x = rect.left;
		_offset.y = rect.top;
		_originalWidth = rect.width;
		_originalHeight = rect.height;

		updateSize(initWidth, initHeight);
	}

	public function get originalWidth():int
	{
		return _originalWidth;
	}

	public function get originalHeight():int
	{
		return _originalHeight;
	}

	public function updateScale(sx:Number, sy:Number):void
	{
		updateSize(_originalWidth * sx, _originalHeight * sy);
	}

	public function updateSize(w:int, h:int):void
	{
		if (_width == w && _height == h) return;

		_width = w;
		_height = h;

		UContainer.removeAllChildren(this);

		var widthCount:int = Math.ceil(w / MAX_BITMAP_SIZE);
		var heightCount:int = Math.ceil(h / MAX_BITMAP_SIZE);
		var partWidth:int = w / widthCount;
		var partHeight:int = h / heightCount;

		var sx:Number = w / _originalWidth;
		var sy:Number = h / _originalHeight;


		for (var y:int = 0; y < heightCount; y++)
			for (var x:int = 0; x < widthCount; x++)
			{
				var data:BitmapData = new BitmapData(partWidth, partHeight, _transparent, 0);

				var m:Matrix = new Matrix(
						sx, 0,
						0, sy,
						(-_originalWidth * x / widthCount - _offset.x) * sx,
						(-_originalHeight * y / heightCount - _offset.y) * sy);

				data.draw(_obj, m, _colorTransform);

				var bm:Bitmap = new Bitmap(data);
				bm.x = _offset.x * sx + x * partWidth;
				bm.y = _offset.y * sy + y * partHeight;

				addChild(bm);
			}
	}
}
}