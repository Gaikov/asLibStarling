package net.maygem.lib.ui.layout
{
import flash.display.DisplayObject;

import net.maygem.lib.utils.UDisplay;

public class HorizontalTileLayout extends BaseLayout
{
	private var _verticalPadding:int;
	private var _horizontalPadding:int;
	private var _numRows:int;
	private var _cellSizeX:int;
	private var _cellSizeY:int;
	private var _paddings:int;

	public function HorizontalTileLayout(verticalPadding:int, horizontalPadding:int,
	                                     numRows:int,
	                                     cellSizeX:int, cellSizeY:int, paddings:int)
	{
		_verticalPadding = verticalPadding;
		_horizontalPadding = horizontalPadding;
		_numRows = numRows;

		_cellSizeX = cellSizeX;
		_cellSizeY = cellSizeY;
		_paddings = paddings;
	}

	override public function get width():Number
	{
		return computeColumnsWidth(numColumns) + _paddings * 2;
	}

	override public function get height():Number
	{
		return _numRows * _cellSizeY + (_numRows - 1) * _verticalPadding + _paddings * 2;
	}

	public function get numColumns():int
	{
		return Math.ceil(numChildren / _numRows);
	}

	public function computeColumnsWidth(numCols:int):Number
	{
		if (!numCols) return 0;
		return numCols * _cellSizeX + (numCols - 1) * _horizontalPadding;
	}

	override public function updateLayout():void
	{
		super.updateLayout();

		var numCols:int = numColumns;

		for (var i:int = 0; i < numChildren; i++)
		{
			var child:DisplayObject = getChildAt(i);

			var col:int = i % numCols;
			var row:int = i / numCols;

			var posX:int = col * (_cellSizeX + _horizontalPadding);
			var posY:int = row * (_cellSizeY + _verticalPadding);

			UDisplay.placeAtOrigin(child, posX + _paddings, posY + _paddings);
		}
	}
}
}