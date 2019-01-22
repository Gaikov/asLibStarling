package net.maygem.lib.scene.manipulator
{

import flash.geom.Point;
import flash.geom.Rectangle;

import net.maygem.lib.debug.Log;

import starling.display.DisplayObjectContainer;

public class DisplayObjectManipulator
{
	private var _name:String;
	private var _object:DisplayObjectContainer;
	private var _children:Object = {};
	private var _parent:DisplayObjectManipulator;
	private var _listeners:Array = [];
	private var _setters:Object = {};

	public function DisplayObjectManipulator(name:String, object:DisplayObjectContainer)
	{
		_name = name;
		_object = object;
	}

	final public function get name():String
	{
		return _name;
	}

	final public function get fullName():String
	{
		var path:String = "";
		if (_parent)
			path = _parent.fullName + "/";
		return path + _name;
	}

	final public function get parent():DisplayObjectManipulator
	{
		return _parent;
	}

	final public function get children():Object
	{
		var res:Object = {};
		for each (var child:DisplayObjectManipulator in _children)
			res[child.name] = child;
		return res;
	}

	final public function getCenterAtStage():Point
	{
		if (!_object.stage)
			return null;

		var pc:IPositionComputer = _object as IPositionComputer;
		if (pc) return pc.getCenterAtStage();

		var res:Rectangle = _object.getBounds(_object.stage);
		return new Point(res.x + res.width / 2, res.y + res.height / 2);
	}

	public function setProperty(name:String, value:Object, cascade:Boolean = false):void
	{
		var setter:IPropertySetter = _setters[name] as IPropertySetter;

		if (setter)
			setter.setProperty(name, value);
		else
			Log.warning("property '" + name + "' setter not found for: " + fullName);

		if (cascade)
		{
			for each (var m:DisplayObjectManipulator in _children)
				m.setProperty(name, value, cascade);
		}
	}

	public function setPropertySetter(name:String, setter:IPropertySetter):void
	{                                                                                             
		_setters[name] = setter;
	}

	public function clearPropertySetters():void
	{
		_setters = {};
	}

	final public function addChild(v:DisplayObjectManipulator):void
	{
		if (_children[v.name])
		{
			var msg:String = "Manipulator with name '" + v.name + "' already exists in '" + name + "'!";
			Log.warning(msg);
			throw new Error(msg);
		}
		else
		{
			v.removeFromParent();
			_children[v.name] = v;
			v._parent = this;
		}
	}

	final public function removeFromParent():void
	{
		if (_parent)
			_parent.removeChild(this);
	}

	final public function removeChild(v:DisplayObjectManipulator):void
	{
		if (_children[v.name] == v)
		{
			v._parent = null;
			delete _children[v.name];
		}
		else
		{
			var msg:String = "can't remove Manipulator '" + v.name + "' from Manipulator '" + name + "'";
			Log.warning(msg);
			throw new Error(msg);
		}
	}

	final public function removeAllChildren():void
	{
		_children = {};
	}

	final public function getChildByName(name:String):DisplayObjectManipulator
	{
		return _children[name] as DisplayObjectManipulator;
	}

	final public function getChildByPath(fullPath:String):DisplayObjectManipulator
	{
		var path:Array = fullPath.split("/");
		var current:DisplayObjectManipulator = this;
		for each (var objName:String in path)
		{
			current = current.getChildByName(objName);
			if (!current)
			{
				Log.warning("can't find Manipulator '" + fullPath + "' at '" + fullName + "'");
				return null;
			}
		}

		return current;
	}

	final public function addEventListener(listener:Function):void
	{
		_listeners.push(listener);
	}

	final public function dispatchEvent(name:String):void
	{
		Log.info("manipulator: " + fullName + ", event: " + name, 0x00ff00);
		traceEvent(new ManipulatorEvent(this, name));
	}

	internal function traceEvent(event:ManipulatorEvent):void
	{
		for each (var func:Function in _listeners)
			func(event);

		if (_parent)
			_parent.traceEvent(event);
	}
}
}
