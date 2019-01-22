/**
 * Created by IntelliJ IDEA.
 * User: Roman Gaikov
 * Date: 11.02.12
 */
package net.maygem.lib.scene.animations
{
import flash.display.DisplayObject;
import flash.display.MovieClip;

import net.maygem.lib.graphics.bitmap.CachedMovie;
import net.maygem.lib.graphics.bitmap.MoviesCache;

public class AnimationEffect
{
	static public function create(movieClass:Class, onCompleted:Function = null):DisplayObject
	{
		var mc:MovieClip = new movieClass();
		mc.addFrameScript(mc.totalFrames - 1, function ():void
		{
			mc.stop();
			mc.parent.removeChild(mc);

			if (onCompleted != null)
			{
				onCompleted();
			}
		});
		return mc;
	}

	static public function createCachedParticles(movieClass:Class, onCompleted:Function = null):DisplayObject
	{
		var mc:CachedMovie = MoviesCache.instance.getParticles(movieClass);
		return createFromMovie(mc, onCompleted);
	}

	static public function createCached(movieClass:Class, onCompleted:Function = null):DisplayObject
	{
		var mc:CachedMovie = MoviesCache.instance.getMovie(movieClass);
		createFromMovie(mc,  onCompleted);
		return mc;
	}

	static public function createFromMovie(mc:CachedMovie, onCompleted:Function = null):DisplayObject
	{
		mc.addFrameScript(mc.totalFrames - 1, function ():void
		{
			mc.stop();
			mc.parent.removeChild(mc);

			if (onCompleted != null)
			{
				onCompleted();
			}
		});
		return mc;
	}

}
}
