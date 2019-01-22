/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 11.02.13
 */
package net.maygem.lib.graphics.bitmap
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import net.maygem.lib.utils.UContainer;

public class CachedHierarchy
{
	private var _root:CachedNode;

	public function CachedHierarchy(obj:DisplayObject)
	{
		_root = cacheNode(obj);
	}

	private function cacheNode(obj:DisplayObject):CachedNode
	{
		var node:CachedNode;

		if (obj is DisplayObjectContainer)
		{
			var c:DisplayObjectContainer = DisplayObjectContainer(obj);
			var children:Array = UContainer.getChildrenList(c);
			var cachedChildren:Array = [];

			for each(var child:DisplayObject in children)
			{
				if (child.name.indexOf("instance") != 0)
				{
					cachedChildren.push(child);
					c.removeChild(child);
				}
			}

			node = new CachedNode(c);

			for each (child in cachedChildren)
			{
				node.addChild(cacheNode(child));
			}
		}
		else
		{
			node = new CachedNode(obj);
		}
		return node;
	}

	public function create():Sprite
	{
		return _root.create();
	}
}
}

import flash.display.DisplayObject;
import flash.display.Sprite;

import net.maygem.lib.graphics.bitmap.CachedFrame;

class CachedNode
{
	private var _x:Number;
	private var _y:Number;
	private var _rotation:Number;
	private var _name:String;
	private var _frame:CachedFrame;
	private var _children:Array = [];

	public function CachedNode(obj:DisplayObject)
	{
		_x = obj.x;
		_y = obj.y;
		_name = obj.name;
		_rotation = obj.rotation;
		_frame = CachedFrame.renderObject(obj);
	}

	public function addChild(child:CachedNode):void
	{
		_children.push(child);
	}

	public function create():Sprite
	{
		var sprite:Sprite = _frame.createSprite();
		sprite.x = _x;
		sprite.y = _y;
		sprite.name = _name;
		sprite.rotation = _rotation;

		for each (var child:CachedNode in _children)
		{
			sprite.addChild(child.create());
		}
		return sprite;
	}
}
