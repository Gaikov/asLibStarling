/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.starlingUtils.display
{
import com.grom.airLib.utils.UFile;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.filesystem.File;
import flash.utils.ByteArray;

import net.maygem.lib.debug.Log;

import starling.text.BitmapFont;

import starling.text.TextField;

import starling.textures.Texture;

public class UFont
{
	public static function loadFont(xmlFileName:String):void
	{
		var xmlFile:File = File.applicationDirectory.resolvePath(xmlFileName);

		Log.info("...loading font: ", xmlFile.nativePath);
		var xml:XML = UFile.readXML(xmlFile);
		var textureName:String = xml.pages.page[0].@file;
		var textureFile:File = xmlFile.parent.resolvePath(textureName);

		Log.info("read texture bytes: ", textureFile.nativePath);
		var bytes:ByteArray = UFile.readFile(textureFile);

		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
		{
			var bm:Bitmap = Bitmap(loader.content);
			var texture:Texture = Texture.fromBitmapData(bm.bitmapData, false);
			var font:BitmapFont = new BitmapFont(texture, xml);
			TextField.registerBitmapFont(font);

			Log.info("font loaded: ", font.name);

		});
		loader.loadBytes(bytes);
	}
}
}
