/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.02.13
 */
package net.maygem
{
import com.grom.system.UDevice;

import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.system.Capabilities;

import net.maygem.lib.debug.Log;

import starling.core.Starling;
import starling.events.Event;
import starling.utils.RectangleUtil;
import starling.utils.ScaleMode;

public class GameStartup extends Sprite
{
	private var _scaleFactor:Number;

	private var _starling:Starling;

	public function GameStartup(gameClass:Class, gameWidth:Number, gameHeight:Number)
	{
		Starling.handleLostContext = true;

		var viewport:Rectangle = RectangleUtil.fit(
			new Rectangle(0, 0, gameWidth, gameHeight),
			new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
			ScaleMode.SHOW_ALL, false);

		_starling = new Starling(gameClass, stage, viewport);
		_starling.addEventListener(Event.ROOT_CREATED, onRootCreated);
		_starling.stage.stageWidth = gameWidth;
		_starling.stage.stageHeight = gameHeight;
		_starling.start();

		_scaleFactor = viewport.width / gameWidth;

		Log.info("starling scale factor: ", Starling.contentScaleFactor);
		Log.info("scale factor: ", _scaleFactor);
		Log.info("viewport:", viewport);
		Log.info("full size size: ", stage.fullScreenWidth, "x", stage.fullScreenHeight);
		Log.info("stage size: ", stage.stageWidth, "x", stage.stageHeight);

		Log.info("======== DEVICE ========");
		Log.info("screen: " + Capabilities.screenResolutionX + " x " + Capabilities.screenResolutionY);
		Log.info("DPI: ", Capabilities.screenDPI);
		Log.info("screen size: ", UDevice.screenSize());
		Log.info("========================");

	}

	private function onRootCreated(event:Event):void
	{
		//_starling.root.scaleX = _starling.root.scaleY = _scaleFactor;
	}
}
}
