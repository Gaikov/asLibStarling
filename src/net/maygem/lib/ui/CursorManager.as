package net.maygem.lib.ui
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.ui.Mouse;

public class CursorManager extends Sprite
{
	private static var _instance:CursorManager;

	private var _cursor:DisplayObject;
	private var _cursors:Array /*of CursorObj*/ = [];
	private var _cursorBounds:Rectangle = new Rectangle();

	private var _attachement:DisplayObject;
	private var _cursorVisible:Boolean = true;
	private var _attachX:int;
	private var _attachY:int;

	public function CursorManager()
	{
		mouseEnabled = false;
		mouseChildren = false;

		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	static public function instance():CursorManager
	{
		if (!_instance)
			_instance = new CursorManager();
		return _instance;
	}

	public function setCursor(cursorClass:Class, priority:int, bounds:Rectangle = null):DisplayObject
	{
		var cursorObj:CursorObj = new CursorObj(cursorClass, priority, bounds);
		if (unicCursorObj(cursorObj))
		{
			_cursors.push(cursorObj);
			return setPriorityCursor();
		}
		return null;
	}

	public function attachToCursor(obj:DisplayObject, offsetX:int = 0, offsetY:int = 0):DisplayObject
	{
		var old:DisplayObject = _attachement;
		if (_attachement)
		{
			removeChild(_attachement);
			_attachement = null;
		}

		if (obj)
		{
			_attachX = offsetX;
			_attachY = offsetY;
			_attachement = obj;
			addChild(_attachement);
			updateCursorPos();
		}
		return old;
	}

	public function removeCursor(cursorClass:Class, priority:int):void
	{
		for (var i:int = 0; i < _cursors.length; i++)
		{
			var obj:CursorObj = _cursors[i];

			if (obj._cursorClass == cursorClass && obj._priority == priority)
				_cursors.splice(i, 1);
		}
		setPriorityCursor();
	}

	public function getCurrentCursor():DisplayObject
	{
		return _cursor;
	}

	public function getCursorBounds():Rectangle
	{
		return _cursorBounds;
	}

	private function unicCursorObj(cursorObj:CursorObj):Boolean
	{
		var unic:Boolean = true;
		if (_cursors && _cursors.length > 0)
		{
			var i:int = 0;
			while (unic && i < _cursors.length - 1)
			{
				if (_cursors[i]._cursorClass == cursorObj._cursorClass && _cursors[i]._priority == cursorObj._priority)
				{
					unic = false;
				}
				i++;
			}
		}
		return unic;
	}

	private function setPriorityCursor():DisplayObject
	{
		if (_cursor)
		{
			removeChild(_cursor);
			_cursor = null;
		}

		var priorityCursor:CursorObj = _cursors[0];
		if (_cursors.length > 1)
		{
			priorityCursor = _cursors[0];
			for (var i:int = 1; i < _cursors.length; i++)
			{
				var cursor:CursorObj = _cursors[i];
				if (cursor._priority > priorityCursor._priority)
				{
					priorityCursor = cursor;
				}
			}
		}

		if (priorityCursor)
		{

			_cursor = DisplayObject(new priorityCursor._cursorClass);
			if (priorityCursor._bounds)
				_cursorBounds = priorityCursor._bounds;
			else
				_cursorBounds = _cursor.getBounds(_cursor);
			addChildAt(_cursor, 0);
			updateCursorPos();
			updateVisibility();
			return _cursor;
		}
		else
		{
			Mouse.show();
			_cursorBounds = new Rectangle();
		}

		return null;
	}

	private function updateVisibility():void
	{
		if (_cursor)
		{
			if (_cursorVisible)
			{
				Mouse.hide();
				_cursor.visible = true;
			}
			else
			{
				Mouse.show();
				_cursor.visible = false;
			}
		}
	}

	private function onEnterFrame(event:Event):void
	{
		updateCursorPos();
	}

	private function updateCursorPos():void
	{
		if (_cursor)
		{
			_cursor.x = mouseX;
			_cursor.y = mouseY;
		}

		if (_attachement)
		{
			_attachement.x = mouseX + _attachX;
			_attachement.y = mouseY + _attachY;
		}
	}

	public function hideCursor():void
	{
		_cursorVisible = false;
		updateVisibility();
	}

	public function showCursor():void
	{
		_cursorVisible = true;
		updateVisibility();
	}
}

}

import flash.geom.Rectangle;

class CursorObj
{
	public var _cursorClass:Class;
	public var _bounds:Rectangle;
	public var _priority:int;

	public function CursorObj(cursorClass:Class, priority:int, bounds:Rectangle)
	{
		_cursorClass = cursorClass;
		_priority = priority;
		_bounds = bounds;
	}
}
