/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 30.1.12
 */
package com.ns.match3
{
import net.maygem.lib.collections.Array2D;

public class Match3FieldModel
{
	private var _m:Array2D;
	private var _resultCells:Array = [];

	public function Match3FieldModel(width:int, height:int, cellBuilder:IMatch3CellBuilder)
	{
		_m = new Array2D(width, height);
		for (var y:int = 0; y < _m.height; y++)
		{
			for (var x:int = 0; x < _m.width; x++)
			{
				_m.setCell(x, y, new CellWrapper(cellBuilder.createCell(x, y)));
			}
		}
	}
	
	public function iterateCells(func:Function):void
	{
		_m.iterate(func);
	}
	
	public function get width():int
	{
		return _m.width;
	}
	
	public function get height():int
	{
		return _m.height;
	}

	public function isCellFree(x:int, y:int):Boolean
	{
		return getCell(x, y).isFree;
	}

	public function getCell(x:int, y:int):IMatch3Cell
	{
		return getCellWrapper(x, y)._cell;
	}

	public function cleanupMatch():void
	{
		for (var y:int = 0; y < _m.height; y++)
		{
			for (var x:int = 0; x < _m.width; x++)
			{
				getCellWrapper(x, y)._checked = false;
				cleanupMatchCell(x, y);
			}
		}
	}

	protected function cleanupMatchCell(x:int, y:int):void
	{

	}

	public function findMatch(x:int, y:int):Array
	{
		_resultCells.length = 0;
		
		var cell:CellWrapper = getCellWrapper(x, y);
		if (!cell.isCanMatch()) return null;
		pushResult(cell);
		
		matchCell(cell, x + 1, y);
		matchCell(cell, x - 1, y);
		matchCell(cell, x, y - 1);
		matchCell(cell, x, y + 1);

		return _resultCells.length >= 3 ? _resultCells.concat() : null;
	}
	
	private function matchCell(original:CellWrapper, x:int, y:int):void
	{
		if (_m.checkBounds(x, y))
		{
			var cell:CellWrapper = getCellWrapper(x, y);
			if (cell.isCanMatch())
			{
				if (original._cell.isMatchTo(cell._cell))
				{
					pushResult(cell);

					matchCell(cell, x + 1, y);
					matchCell(cell, x - 1, y);
					matchCell(cell, x, y - 1);
					matchCell(cell, x, y + 1);
				}
			}
		}
	}

	private function pushResult(cell:CellWrapper):void
	{
		cell._checked = true;
		_resultCells.push(cell._cell);
	}

	private function getCellWrapper(x:int, y:int):CellWrapper
	{
		return _m.getCell(x,  y);
	}

	public function inRange(x:Number, y:Number):Boolean
	{
		return _m.inRange(x, y);
	}
}
}

import com.ns.match3.IMatch3Cell;

class CellWrapper
{
	public var _cell:IMatch3Cell;
	public var _checked:Boolean = false;

	public function CellWrapper(cell:IMatch3Cell)
	{
		_cell = cell;
	}
	
	public function isCanMatch():Boolean
	{
		return !_checked && !_cell.isFree;
	}
}
