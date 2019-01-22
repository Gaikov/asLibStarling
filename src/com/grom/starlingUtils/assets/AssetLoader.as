/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.02.13
 */
package com.grom.starlingUtils.assets
{
import com.grom.starlingUtils.display.UImage;
import com.grom.starlingUtils.display.UMovieClip;

import flash.filesystem.File;

import net.maygem.lib.debug.Log;

import starling.display.DisplayObject;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

public class AssetLoader
{
	private static var _instance:AssetLoader;

	private var _assets:AssetManager = new AssetManager(1);
	private var _subTexToAtlasName:Object = {};

	public function AssetLoader()
	{
		_assets.verbose = true;
	}

	public function loadAssets(onFeedback:Function):void
	{
		var appDir:File = File.applicationDirectory;
		Log.info("app directory:", File.applicationDirectory.nativePath);
		_assets.enqueue(appDir.resolvePath("assets/atlases"));
		_assets.verbose = true;
		_assets.loadQueue(function(progress:Number):void
		{
			if (progress == 1)
			{
				onResourcesLoaded();
			}
			onFeedback(progress);
		});
	}

	public function getSubTexture(name:String):Texture
	{
		var texture:Texture = _assets.getTextureAtlas(_subTexToAtlasName[name]).getTexture(name);
		if (!texture)
		{
			Log.error("texture not found: ", name);
		}
		return texture;
	}

	private function onResourcesLoaded():void
	{
		var atlasName:String = "atlas";

		var atlas:TextureAtlas = _assets.getTextureAtlas(atlasName);
		var names:Vector.<String> = new <String>[];
		atlas.getNames("", names);
		for each (var name:String in names)
		{
			_subTexToAtlasName[name] = atlasName;
		}
	}

	public static function get instance():AssetLoader
	{
		if (!_instance)
		{
			_instance = new AssetLoader();
		}
		return _instance;
	}

	public function isMovie(subTextureName:String):Boolean
	{
		if (_subTexToAtlasName[subTextureName] == undefined)
		{
			return _subTexToAtlasName[subTextureName + "000"] != undefined;
		}
		return false;
	}

	public function getFrames(name:String):Vector.<Texture>
	{
		var atlasName:String = _subTexToAtlasName[name + "000"];
		var atlas:TextureAtlas = _assets.getTextureAtlas(atlasName);
		return atlas.getTextures(name);
	}

	public function createByName(name:String):DisplayObject
	{
		if (isMovie(name))
		{
			return UMovieClip.create(name);
		}

		return UImage.create(name);
	}

}
}
