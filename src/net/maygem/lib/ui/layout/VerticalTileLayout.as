package net.maygem.lib.ui.layout
{
import flash.display.DisplayObject;

import net.maygem.lib.utils.UDisplay;

public class VerticalTileLayout extends BaseLayout
{
	private var _verticalPadding:int;
	private var _horizontalPadding:int;
	private var _numColumns:int;
	private var _cellSizeX:int;
	private var _cellSizeY:int;
	private var _paddings:int;

	public function VerticalTileLayout(verticalPadding:int, horizontalPadding:int,
	                                     numColumns:int,
	                                     cellSizeX:int, cellSizeY:int, paddings:int)
	{
		super();
		_verticalPadding = verticalPadding;
		_horizontalPadding = horizontalPadding;
		_numColumns = numColumns;

		_cellSizeX = cellSizeX;
		_cellSizeY = cellSizeY;
		_paddings = paddings;
	}

	override public function get width():Number
	{
		return _numColumns * _cellSizeX + (_numColumns - 1) * _horizontalPadding + _paddings * 2;
	}

	override public function get height():Number
	{
		return computeRowsHeight(numRows);
	}

	public function get numRows():int
	{
		return Math.ceil(numChildren / _numColumns);
	}

	public function computeRowsHeight(numRows:int):Number
	{
		if (!numRows) return 0;
		return numRows * _cellSizeY + (numRows - 1) * _verticalPadding;
	}

	override public function updateLayout():void
	{
		super.updateLayout();

		var numRows:int = numRows;

		for (var i:int = 0; i < numChildren; i++)
		{
			var child:DisplayObject = getChildAt(i);

			var col:int = i % numRows;
			var row:int = i / numRows;

			var posX:int = col * (_cellSizeX + _horizontalPadding);
			var posY:int = row * (_cellSizeY + _verticalPadding);

			UDisplay.placeAtOrigin(child, posX + _paddings, posY + _paddings);
		}
	}
}
}