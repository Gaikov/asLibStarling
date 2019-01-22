/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.02.13
 */
package com.grom.starlingUtils.display
{
import com.grom.starlingUtils.assets.AssetLoader;
import com.grom.starlingUtils.layout.movie.MovieClipFixed;

import starling.core.Starling;
import starling.display.MovieClip;
import starling.events.Event;
import starling.textures.Texture;

public class UMovieClip
{
	public static function create(name:String):MovieClip
	{
		var frames:Vector.<Texture> = AssetLoader.instance.getFrames(name);
		var mc:MovieClip = new MovieClipFixed(frames, 35);

		mc.addEventListener(Event.ADDED_TO_STAGE, function():void
		{
			Starling.juggler.add(mc);
		});

		mc.addEventListener(Event.REMOVED_FROM_STAGE, function():void
		{
			Starling.juggler.remove(mc);
		});

		return mc;
	}
}
}
