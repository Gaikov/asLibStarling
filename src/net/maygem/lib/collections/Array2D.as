package net.maygem.lib.collections
{
import net.maygem.lib.utils.UMath;

public class Array2D
{
	private var _rows:Array;
	private var _width:int;
	private var _height:int;

	public function Array2D(width:uint, height:uint, defaultValue:Class = null)
	{
		setSize(width, height, defaultValue);
	}
	
	public function checkBounds(x:int, y:int):Boolean
	{
		return UMath.inRange(x, 0, _width - 1) && UMath.inRange(y, 0, _height - 1);
	}
	
	public function iterate(func:Function):void
	{
		for (var x:int = 0; x < _width; x++)
			for (var y:int = 0; y < _height; y++)
			{
				func(x, y);
			}
	}

	public function get rows():Array
	{
		return _rows;
	}

	public function get width():int
	{
		return _width;
	}

	public function set width(value:int):void
	{
		_width = value;
	}

	public function get height():int
	{
		return _height;
	}

	public function set height(value:int):void
	{
		_height = value;
	}

	public function setSize(width:uint, height:uint, defaultValue:Class = null):void
	{
		_width = width;
		_height = height;

		_rows = [];
		for (var y:int = 0; y < _height; y++)
		{
			var row:Array = [];
			_rows.push(row);

			for (var x:int = 0; x < _width; x++)
				row.push(defaultValue ? new defaultValue() : null);
		}
	}

	public function getCell(x:int, y:int):*
	{
		return _rows[y][x];
	}
	
	public function inRange(x:int, y:int):Boolean
	{
		return UMath.inRange(x, 0, _width - 1) && UMath.inRange(y, 0, _height - 1);
	}

	public function setCell(x:int, y:int, data:*):void
	{
		if (!inRange(x, y))
			throw new ArgumentError();
		
		_rows[y][x] = data;
	}

	public function copyFromOther(other:Array2D):void
	{
		for (var x:int = 0; x < Math.min(other.width, width); x++)
			for (var y:int = 0; y < Math.min(other.height, height); y++)
			{
				setCell(x, y, other.getCell(x, y));
			}
	}
}
}