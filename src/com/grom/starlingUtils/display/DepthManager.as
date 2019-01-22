/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 21.03.13
 */
package com.grom.starlingUtils.display
{
import starling.display.DisplayObject;
import starling.display.Sprite;

public class DepthManager
{
	private var _root:Sprite = new Sprite();
	private var _layerMap:Object = {};

	public function DepthManager()
	{
	}

	public function addChild(view:DisplayObject, depth:int):void
	{
		getDepthLayer(depth).addChild(view);
	}

	public function removeChild(view:DisplayObject):void
	{
		if (view.parent.parent != _root)
		{
			throw new Error("Invalid view remove");
		}
		view.parent.removeChild(view);
	}

	public function get root():DisplayObject
	{
		return _root;
	}

	private function getDepthLayer(depth:int):DepthLayer
	{
		var layer:DepthLayer = _layerMap[depth];
		if (!layer)
		{
			layer = new DepthLayer(depth);
			_root.addChildAt(layer, findIndex(depth));
			_layerMap[depth] = layer;
		}

		return layer;
	}

	private function findIndex(depth:int):int
	{
		if (!_root.numChildren) return 0;

		var i:int;
		for (i = 0; i < _root.numChildren; i++)
		{
			var layer:DepthLayer = DepthLayer(_root.getChildAt(i));
			if (layer.depth > depth) return i;
		}
		return i;
	}

}
}

import starling.display.Sprite;

class DepthLayer extends Sprite
{
	private var _depth:int;

	public function DepthLayer(depth:int)
	{
		_depth = depth;
	}

	public function get depth():int
	{
		return _depth;
	}
}
