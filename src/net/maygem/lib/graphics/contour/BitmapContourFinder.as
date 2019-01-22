package net.maygem.lib.graphics.contour
{
import flash.display.BitmapData;

public class BitmapContourFinder
{
	private var _bmData:BitmapData;
	private var _threshold:uint;
	private var _bmChecked:BitmapData;
	private var _bmBounds:BitmapData;
	private var _startPoint:PixelPos;
	private var _contour:Array = [];

	public function BitmapContourFinder(bmData:BitmapData, alphaThreshold:uint)
	{
		_bmData = bmData;
		_threshold = alphaThreshold;
		_bmChecked = new BitmapData(_bmData.width, _bmData.height, true, 0);
		_bmBounds = new BitmapData(_bmData.width, _bmData.height, true, 0);

		var x:int;
		var y:int;

		for (y = 0; y < _bmData.height; y++)
			for (x = 0; x < _bmData.width; x++)
			{
				if (IsFilledPixel(x, y, _bmData) &&
						(!IsFilledPixel(x + 1, y, _bmData) ||
								!IsFilledPixel(x - 1, y, _bmData) ||
								!IsFilledPixel(x, y + 1, _bmData) ||
								!IsFilledPixel(x, y - 1, _bmData)))
				{
					if (!_startPoint)
						_startPoint = new PixelPos(x, y);
					_bmBounds.setPixel32(x, y, 0xff000000);
				}
			}

		if (_startPoint)
		{
			var lastPoint:PixelPos = _startPoint;
			while (true)
			{
				lastPoint = GetContourPixel(lastPoint.x, lastPoint.y);
				if (!lastPoint)
				{
					trace("contour: ", _contour.length);
					return;
				}
				else
					_contour.push(lastPoint);
			}
		}
	}

	private function GetContourPixel(posX:int, posY:int):PixelPos
	{
		var offsets:Array =
				[
					new PixelPos(-1, 0),
					new PixelPos(0, 1),
					new PixelPos(0, -1),
					new PixelPos(1, 0),

					new PixelPos(-1, -1),
					new PixelPos(1, 1),
					new PixelPos(1, -1),
					new PixelPos(-1, 1)
				];

		for (var i:int = 0; i < offsets.length; i++)
		{
			var offs:PixelPos = offsets[i];
			var x:int = posX + offs.x;
			var y:int = posY + offs.y;

			if (InBitmapRect(x, y) && !IsChecked(x, y))
			{
				if (_bmBounds.getPixel32(x, y) > 0)
				{
					MarkAsChecked(x, y);
					return new PixelPos(x, y);
				}
			}
		}

		return null;
	}

	public function get bmBounds():BitmapData
	{
		return _bmBounds;
	}

	public function get contour():Array
	{
		return _contour;
	}

	private function IsFilledPixel(x:int, y:int, data:BitmapData):Boolean
	{
		if (InBitmapRect(x, y))
		{
			var pixel:uint = data.getPixel32(x, y);
			var alpha:uint = (pixel >> 24) & 0xFF;
			return alpha >= _threshold;
		}
		return false;
	}

	private function InBitmapRect(x:int, y:int):Boolean
	{
		return x >= 0 && x < _bmData.width && y >= 0 && y < _bmData.height;
	}

	private function MarkAsChecked(x:int, y:int):void
	{
		_bmChecked.setPixel32(x, y, 0xff000000);
	}

	private function IsChecked(x:int, y:int):Boolean
	{
		var _pixel:uint = _bmChecked.getPixel32(x, y);
		return _pixel != 0;
	}
}
}
