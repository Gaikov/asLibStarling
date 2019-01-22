/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.08.12
 */
package net.maygem.lib.ui.layout
{
import flash.display.DisplayObject;

import net.maygem.lib.utils.UDisplay;

public class GridLayout extends BaseLayout
{
	private var _vStep:int;
	private var _hStep:int;
	private var _numCols:int;

	public function GridLayout(hStep:int, vStep:int, numCols:int)
	{
		_vStep = vStep;
		_hStep = hStep;
		_numCols = numCols;
	}

	override public function updateLayout():void
	{
		super.updateLayout();
		if (!numChildren) return;

		for (var i:int = 0; i < numChildren; i++)
		{
			var child:DisplayObject = getChildAt(i);
			var row:int = i / _numCols;
			var col:int = i % _numCols;

			var posX:Number = _hStep * col;
			var posY:Number = _vStep * row;
			
			UDisplay.placeAtOrigin(child, posX, posY);
		}
	}
}
}
