/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 05.03.13
 */
package com.grom.starlingUtils.layout.movie
{
import starling.display.MovieClip;
import starling.display.Sprite;

public class MovieWrapper extends Sprite
{
	private var _movie:MovieClip;

	public function MovieWrapper(mc:MovieClip)
	{
		_movie = mc;
		addChild(_movie);
	}

	public function get movie():MovieClip
	{
		return _movie;
	}
}
}


