package net.maygem.lib.scene.culling
{
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;

import flash.geom.Point;
import flash.geom.Rectangle;

import net.maygem.lib.utils.UContainer;

public class CullNode extends Sprite
{
	private var _visual:DisplayObject;
	private var _rect:Rectangle;

	public function CullNode()
	{
		super();

		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}

	public function set visual(value:DisplayObject):void
	{
		if (_visual)
		{
			UContainer.safeRemove(this, _visual);
			_visual = null;
		}
		_visual = value;
		if (_visual)
		{
			_rect = _visual.getRect(this);
			graphics.lineStyle(1);
			graphics.drawRect(_rect.x, _rect.y, _rect.width, _rect.height);
		}
		updateVisibility();
	}

	public function get isVisible():Boolean
	{
		return _visual && _visual.parent;
	}

	public function updateVisibility():void
	{
		if (!_visual || !stage) return;

		//UContainer.safeAdd(this, _visual);

		var stageRect:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		if (stageRect.intersects(getGlobalRect()))
			UContainer.safeAdd(this, _visual);
		else
			UContainer.safeRemove(this, _visual);//*/
	}

	private function onAddedToStage(event:Event):void
	{
		CullManager.instance().addNode(this);
		updateVisibility();
	}

	private function onRemovedFromStage(event:Event):void
	{
		CullManager.instance().removeNode(this);
	}

	private function getGlobalRect():Rectangle
	{
		var pt1:Point = localToGlobal(new Point(_rect.left, _rect.top));
		var pt2:Point = localToGlobal(new Point(_rect.right, _rect.bottom));
		return new Rectangle(
				pt1.x, pt1.y,
				pt2.x - pt1.x, pt2.y - pt1.y);
	}

}
}