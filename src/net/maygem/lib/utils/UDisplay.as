package net.maygem.lib.utils
{
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Graphics;
import flash.display.InteractiveObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.filters.BitmapFilterQuality;
import flash.filters.ColorMatrixFilter;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import net.maygem.lib.debug.Log;

public class UDisplay
{
	static public const DEFAULT_NAME_PREFIX:String = "instance";

	static public function createAlphaSprite(w:int, h:int, center:Boolean = false):Sprite
	{
		var res:Sprite = new Sprite;
		fillRect(res.graphics, w, h, 0xffffff, 0, center);
		return res;
	}

	static public function createFilledSprite(w:int, h:int, color:uint = 0xffffff, center:Boolean = false):Sprite
	{
		var res:Sprite = new Sprite;
		fillRect(res.graphics, w, h, color, 1, center);
		return res;
	}

	static public function createAlphaShape(w:int, h:int, center:Boolean = false):Shape
	{
		var res:Shape = new Shape;
		fillRect(res.graphics, w, h, 0xffffff, 0, center);
		res.alpha = 0;
		return res;
	}

	static public function createFilledShape(w:int, h:int, color:uint = 0xffffff, center:Boolean = false):Shape
	{
		var res:Shape = new Shape;
		fillRect(res.graphics, w, h, color, 1, center);
		return res;
	}

	static public function fillRect(g:Graphics, w:int, h:int, color:uint, alpha:Number, center:Boolean):void
	{
		g.beginFill(color, alpha);
		if (center)
			g.drawRect(-w / 2, -h / 2, w, h);
		else
			g.drawRect(0, 0, w, h);
		g.endFill();
	}

	static public function centerObject(w:int, h:int, obj:DisplayObject):void
	{
		UDisplay.placeAtOrigin(obj, (w - obj.width) * 0.5, (h - obj.height) * 0.5);
	}

	static public function getCenterOffset(obj:DisplayObject):Point
	{
		var bounds:Rectangle = obj.getBounds(obj);
		return new Point(
				obj.width / 2 + bounds.x,
				obj.height / 2 + bounds.y);
	}

	static private const space:Sprite = new Sprite();

	static public function placeInCenter(obj:DisplayObject):void
	{
		obj.x = obj.y = 0;
		var bounds:Rectangle = obj.getBounds(space);
		obj.x = -obj.width / 2 - bounds.x;
		obj.y = -obj.height / 2 - bounds.y;
	}

	static public function placeAtOrigin(obj:DisplayObject, x:Number, y:Number):void
	{
		var pos:Point = convertToOriginPos(obj, x, y);
		obj.x = pos.x;
		obj.y = pos.y;
	}
	
	static public function convertToOriginPos(obj:DisplayObject, x:Number, y:Number):Point
	{
		var bounds:Rectangle = getScaledBounds(obj); 
		return new Point(x - bounds.x, y - bounds.y);
	}

	static public function traceChildren(obj:DisplayObject, tabs:String = ""):void
	{
		var offsX:Number = obj.x + obj.width;
		var offsY:Number = obj.y + obj.height;

		Log.info(tabs + "name: " + obj.name + ", bottom offset: " + offsX + "," + offsY, 0xaaaaaa);
		if (obj is DisplayObjectContainer)
		{
			var c:DisplayObjectContainer = DisplayObjectContainer(obj);
			for (var i:int = 0; i < c.numChildren; i++)
				traceChildren(c.getChildAt(i), tabs + "\t");
		}
	}

	static public function paintObject(obj:DisplayObject, color:uint):void
	{
		var c:Color = new Color();
		c.setFromUINT(color);

		obj.transform.colorTransform = new ColorTransform(0, 0, 0, 1,
				c.redByte(),
				c.greenByte(),
				c.blueByte(), 0);
	}

	static public function getTopCenterAtStage(obj:DisplayObject):Point
	{
		if (!obj.stage) return null;

		var pos:Point = new Point(0, 0);
		var rect:Rectangle = obj.getBounds(obj.stage);
		pos.x += obj.width / 2 + rect.x;
		pos.y += rect.y;
		return pos;		
	}

	static public function remapCoordinates(fromSpace:DisplayObject, toSpace:DisplayObject, point:Point):Point
	{
		point = fromSpace.localToGlobal(point);
		return toSpace.globalToLocal(point);
	}

	static public function getScaledBounds(obj:DisplayObject):Rectangle
	{
		var rect:Rectangle = obj.getBounds(obj);
		return new Rectangle(rect.left * obj.scaleX, rect.top * obj.scaleY,
				rect.right * obj.scaleX, rect.bottom * obj.scaleY);
	}

	static public function createTextField(font:String, size:int, color:uint = 0x000000, bold:Boolean = false):TextField
	{
		var format:TextFormat = new TextFormat(font, size, color, bold);
		var field:TextField = new TextField();
		field.defaultTextFormat = format;
		field.text = "";
		field.embedFonts = UFont.isEmbedded(font);
		field.autoSize = TextFieldAutoSize.LEFT;
		//field.border = true;
		field.selectable = false;
		field.mouseEnabled = false;
		return field;
	}

	static public function createBorderFilter(color:uint, width:int):GlowFilter
	{
		return new GlowFilter(color, 1, width, width, 10, BitmapFilterQuality.HIGH);
	}

	static public function createMonochromeFilter():ColorMatrixFilter
	{
		return new ColorMatrixFilter(
				[
					0.33, 0.33, 0.33, 0, 0,
					0.33, 0.33, 0.33, 0, 0,
					0.33, 0.33, 0.33, 0, 0,
					0, 0, 0, 1, 0
				]);
	}

	static public function cacheAsBitmapData(obj:DisplayObject):BitmapData
	{
		var rect:Rectangle = obj.getBounds(obj);
		rect.left *= obj.scaleX;
		rect.right *= obj.scaleX;
		rect.top *= obj.scaleY;
		rect.bottom *= obj.scaleY;

		var bm:BitmapData = new BitmapData(rect.width, rect.height);
		bm.draw(obj);

		return bm;
	}

	static public function drawCross(g:Graphics, size:int, color:uint = 0xffffff):void
	{
		g.lineStyle(1, color);
		g.moveTo(-size / 2, 0);
		g.lineTo(size / 2, 0);
		g.moveTo(0, -size/ 2);
		g.lineTo(0, size/ 2);
	}

	static public function disableMouse(obj:DisplayObject):void
	{
		var i:InteractiveObject = obj as InteractiveObject;
		if (i) i.mouseEnabled = false;

		var c:DisplayObjectContainer = obj as DisplayObjectContainer;
		if (c) c.mouseChildren = false;
	}
	
	static public function globalPos(obj:DisplayObject):Point
	{
		return obj.localToGlobal(new Point(0, 0));
	}
	
	static public function setGlobalPos(obj:DisplayObject, pos:Point):void
	{
		pos = obj.parent.globalToLocal(pos);
		obj.x = pos.x;
		obj.y = pos.y;
	}

	static public function copyPos(from:DisplayObject, to:DisplayObject):void
	{
		to.x = from.x;
		to.y = from.y;
	}

	static public function copyAttr(from:DisplayObject, to:DisplayObject):void
	{
		copyPos(from, to);
		to.rotation = from.rotation;
		to.scaleX = from.scaleX;
		to.scaleY = from.scaleY;
	}

	static public function setHeight(obj:DisplayObject, height:Number):void
	{
		var scale:Number = height / obj.height;
		obj.scaleX = obj.scaleY = scale;
	}

	static public function getRotation(dir:Point):Number
	{
		return UMath.rad2deg(Math.atan2(dir.y, dir.x));
	}

	static public function setDirection(obj:DisplayObject, dir:Point, addAngle:Number = 0):void
	{
		obj.rotation = getRotation(dir) + addAngle + 90;
	}

	static public function getDirection(rotation:Number):Point
	{
		var a:Number = UMath.deg2rad(rotation);
		return new Point(Math.sin(a), -Math.cos(a));
	}

	static public function setPos(obj:DisplayObject, pos:Point):void
	{
		obj.x = pos.x;
		obj.y = pos.y;
	}


	public static function getPos(obj:DisplayObject):Point
	{
		return new Point(obj.x, obj.y);
	}

	public static function isDefaultName(obj:DisplayObject):Boolean
	{
		return obj.name.indexOf(DEFAULT_NAME_PREFIX) == 0;
	}
}
}