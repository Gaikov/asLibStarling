package net.maygem.lib.ui.layout
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import flash.utils.Dictionary;

import net.maygem.lib.debug.Log;
import net.maygem.lib.utils.UContainer;

public class BaseLayout extends Sprite implements ILayout
{
	private var _exclusions : Dictionary = new Dictionary();
	private var _parent : DisplayObjectContainer;
	private var _inLayout : Boolean = false;

	public function drawBorder() : void
	{
		graphics.clear();
		graphics.lineStyle(1);
		graphics.drawRect(0, 0, width, height);
	}

	public function get inLayout() : Boolean
	{
		return _inLayout && _parent;
	}

	public function set inLayout(value : Boolean) : void
	{
		if (value)
		{
			if (_parent)
				_parent.addChild(this);
		}
		else
		{
			if (_parent && _parent == parent)
				_parent.removeChild(this);
			_inLayout = false;
		}
	}

	public function updateFromXML(meta : XML) : void
	{
		if (meta.@id != undefined) name = meta.@id;
		if (meta.@x != undefined) x = Number(meta.@x);
		if (meta.@y != undefined) y = Number(meta.@y);
	}

	override public function addChild(child : DisplayObject) : DisplayObject
	{
		var res : DisplayObject = super.addChild(child);
		var layout : BaseLayout = res as BaseLayout;
		if (layout) layout.onAddedToList();
		return res;
	}

	override public function addChildAt(child : DisplayObject, index : int) : DisplayObject
	{
		var res : DisplayObject = super.addChildAt(child, index);
		var layout : BaseLayout = res as BaseLayout;
		if (layout) layout.onAddedToList();
		return res;
	}

	override public function removeChild(child : DisplayObject) : DisplayObject
	{
		delete _exclusions[child];
		return super.removeChild(child);
	}

	override public function removeChildAt(index : int) : DisplayObject
	{
		delete _exclusions[getChildAt(index)];
		return super.removeChildAt(index);
	}

	public function excludeFromLayout(child : DisplayObject, exclude : Boolean = true) : void
	{
		_exclusions[child] = exclude;
	}

	public function isExcludedFromLayout(child : DisplayObject) : Boolean
	{
		return _exclusions[child];
	}

	public function updateLayout():void
	{
		for (var i:int = 0; i < numChildren; i++)
		{
			var obj:ILayout = getChildAt(i) as ILayout;
			if (obj) obj.updateLayout();
		}
	}

	public function updatePresence(child:DisplayObject, add:Boolean):void
	{
		UContainer.updatePresence(this, child, add);
	}

	public function findChildInDepth(id : String) : BaseLayout
	{
		var res : BaseLayout = findChildRecursive(id);
		if (!res)
			Log.error("layout not found by id: ", id);
		return res;
	}

	public function setChildProperty(id : String, propName : String, value : Object) : void
	{
		var child : BaseLayout = findChildInDepth(id);
		if (child)
		{
			if (child.hasOwnProperty(propName))
				child[propName] = value;
			else
				Log.error("layout '", id, "' don't have propery: ", propName, " at: ", name);
		}
	}

	private function findChildRecursive(id : String) : BaseLayout
	{
		for (var i : int = 0; i < numChildren; i++)
		{
			var child : BaseLayout = getChildAt(i) as BaseLayout;
			if (child)
			{
				if (child.name == id)
					return child;
				else
				{
					child = child.findChildRecursive(id);
					if (child) return child;
				}
			}
		}
		return null;
	}

	private function onAddedToList() : void
	{
		_parent = parent;
		_inLayout = true;
	}
}
}