/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.starlingUtils.layout.builders
{
import com.grom.starlingUtils.display.UMovieClip;
import com.grom.starlingUtils.layout.LayoutUtils;
import com.grom.starlingUtils.layout.movie.MovieWrapper;

import starling.display.DisplayObject;
import starling.display.MovieClip;

public class MovieBuilder implements ILayoutItemBuilder
{
	public function MovieBuilder()
	{
	}

	public function create(source:XML):DisplayObject
	{
		var mc:MovieClip = UMovieClip.create(source["@class"]);
		mc.touchable = false;
		var wrapper:MovieWrapper = new MovieWrapper(mc);
		LayoutUtils.copyParams(source, wrapper);
		return wrapper;
	}
}
}
