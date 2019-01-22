/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 24.07.12
 */
package net.maygem.lib.graphics.bitmap
{
import com.grom.display.particles.ParticlesDesc;

import flash.display.Sprite;
import flash.utils.Dictionary;

import net.maygem.lib.debug.CmdManager;
import net.maygem.lib.debug.Log;
import net.maygem.lib.utils.UArray;
import net.maygem.lib.utils.UContainer;

public class MoviesCache
{
	private static var _instance:MoviesCache;

	private var _cache:Dictionary = new Dictionary();

	public function MoviesCache()
	{
		CmdManager.instance().register("movie_cache", function():void
		{
			for (var key:Object in _cache)
			{
				Log.info(key);
			}
		});
	}

	public static function get instance():MoviesCache
	{
		if (!_instance)
		{
			_instance = new MoviesCache();
		}
		return _instance;
	}

	public function getSprite(cls:Class):Sprite
	{
		var frame:CachedFrame;
		if (_cache[cls] != undefined)
		{
			frame = CachedFrame(_cache[cls]);
		}
		else
		{
			var spr:Sprite = new cls();
			UContainer.removeChildrenWithPrefix(spr, "anchor");
			frame = CachedFrame.renderObject(spr);
			_cache[cls] = frame;
		}

		return frame.createSprite();
	}

	public function getMovie(cls:Class):CachedMovie
	{
		var frames:CachedMovieFrames;
		if (_cache[cls] != undefined)
		{
			frames = CachedMovieFrames(_cache[cls]);
		}
		else
		{
			frames = CachedMovieFrames.renderMovie(new cls);
			_cache[cls] = frames;
		}

		return new CachedMovie(frames);
	}

	public function getHierarchy(cls:Class):Sprite
	{
		var hierarchy:CachedHierarchy;
		if (_cache[cls] != undefined)
		{
			hierarchy = CachedHierarchy(_cache[cls]);
		}
		else
		{
			hierarchy = new CachedHierarchy(new cls);
			_cache[cls] = hierarchy;
		}

		return hierarchy.create();
	}

	public function cacheParticles(xmlClass:Class, viewClass:Class, numMovies:int = 3):void
	{
		var desc:ParticlesDesc = new ParticlesDesc();
		desc._viewClass = viewClass;
		desc.parseFromXML(xmlClass.data);

		var list:Array = [];
		for (var i:int = 0; i < 3; i++)
		{
			list[i] = CachedMovieFrames.renderParticles(desc)
		}

		_cache[xmlClass] = list;
	}

	public function getParticles(xmlClass:Class):CachedMovie
	{
		var list:Array;
		if (_cache[xmlClass] != undefined)
		{
			list = _cache[xmlClass] as Array;
		}
		else
		{
			throw new Error("call cacheParticles() before");
		}
		return new CachedMovie(UArray.getRandom(list));
	}
}
}
