/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.06.13
 */
package com.grom.starlingUtils.layout.movie
{
import flash.geom.Point;
import flash.geom.Rectangle;

import starling.display.DisplayObject;
import starling.display.MovieClip;
import starling.textures.Texture;

public class MovieClipFixed extends MovieClip
{
	public function MovieClipFixed(textures:Vector.<Texture>, fps:Number)
	{
		super(textures, fps);
	}

	override public function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject
	{
		if (forTouch && (!visible || !touchable)) return null;

		var t:Texture = getFrameTexture(currentFrame);
		var frame:Rectangle = t.frame;
		var hitFrame:Rectangle = new Rectangle(-frame.left, -frame.top, frame.width, frame.height);
		if (hitFrame.containsPoint(localPoint))
		{
			return this;
		}

		return null;
	}

	override public function set texture(value:Texture):void
	{
		if (texture != value)
		{
			var r:Rectangle = value.frame;

			mVertexData.setPosition(0, 0.0, 0.0);
			mVertexData.setPosition(1, r.width, 0.0);
			mVertexData.setPosition(2, 0.0, r.height);
			mVertexData.setPosition(3, r.width, r.height);

			super.texture = value;
		}
	}
}
}
