package net.maygem.lib.graphics.copy
{

import flash.display.Graphics;
import flash.utils.flash_proxy;
import flash.utils.Proxy;

public class GraphicsProxy extends Proxy
{
	private var _graphics:Graphics;
	private var _history:Array = new Array();

	public function GraphicsProxy(graphics:Graphics = null)
	{
		_graphics = graphics;
	}

	public function get graphics():Graphics
	{
		return _graphics;
	}

	public function set graphics(g:Graphics):void
	{
		_graphics = g;
		copyFrom(this);
	}

	public function copyFrom(graphicsCopy:GraphicsProxy):void
	{
		var hist:Array = graphicsCopy._history;
		_history = hist.slice();
		if (_graphics)
		{
			var i:int;
			var n:int = hist.length;
			_graphics.clear();
			for (i = 0; i < n; i += 2)
			{
				_graphics[hist[i]].apply(_graphics, hist[i + 1]);
			}
		}
	}

	override flash_proxy function callProperty(methodName:*, ... args):*
	{
		methodName = String(methodName);
		switch (methodName)
		{
		case "clear":
			_history.length = 0;
			break;
		default:
			_history.push(methodName, args);
		}

		if (_graphics && methodName in _graphics)
			return _graphics[methodName].apply(_graphics, args);

		return null;
	}
}
}