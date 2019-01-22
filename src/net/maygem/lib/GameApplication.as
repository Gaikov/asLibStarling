package net.maygem.lib
{

import flash.desktop.NativeApplication;
import flash.desktop.SystemIdleMode;
import flash.events.KeyboardEvent;
import flash.system.Capabilities;
import flash.text.Font;
import flash.utils.getDefinitionByName;

import net.maygem.lib.debug.CmdManager;
import net.maygem.lib.debug.FPSView;
import net.maygem.lib.debug.Log;
import net.maygem.lib.lang.LangLoader;
import net.maygem.lib.scene.manipulator.ManipulableSprite;
import net.maygem.lib.scene.manipulator.SceneManipulator;
import net.maygem.lib.sound.SoundManager;
import net.maygem.lib.sound.USound;

import starling.display.Sprite;
import starling.events.Event;

public class GameApplication extends ManipulableSprite
{
	private var _fpsView:FPSView = new FPSView();

	private var _gameLayer:Sprite = new Sprite();
	private var _systemLayer:Sprite = new Sprite();

	public function GameApplication()
	{
		super("app", SceneManipulator.instance());

		Log.info("=== embedded fonts");
		var fonts:Array = Font.enumerateFonts(false);
		for (var i:int = 0; i < fonts.length; ++i)
		{
			var font:Font = fonts[i];
			Log.info("name: " + font.fontName + ", style: " + font.fontStyle);
		}
		Log.info("=== embedded fonts");

		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		CmdManager.instance().register("fps", cmdFPS);
		CmdManager.instance().register("lang", cmdLang);
		//CmdManager.instance().register("fullscreen", cmdFullscreen);
		CmdManager.instance().register("sound", cmdSound);

		Log.allowConsole(Capabilities.isDebugger);

		//if(Capabilities.cpuArchitecture=="ARM")
		{
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, handleActivate, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, handleDeactivate, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys, false, 0, true);
		}
	}

	private function handleActivate(event:flash.events.Event):void
	{
		NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		SoundManager.instance.resumeMusic();
		onAppActivated();
	}

	protected function onAppActivated():void
	{

	}

	private function handleDeactivate(event:flash.events.Event):void
	{
		SoundManager.instance.pauseMusic();
		onAppDeactivated();
	}

	protected function onAppDeactivated():void
	{

	}

	private function handleKeys(event:KeyboardEvent):void
	{
/*
		if(event.keyCode == Keyboard.BACK)
			NativeApplication.nativeApplication.exit();
*/
	}

	protected function get gameLayer() : Sprite
	{
		return _gameLayer;
	}

	private function onAddedToStage(e:Event):void
	{
		Log.attachToStage(stage);

		addChild(_gameLayer);
		addChild(_systemLayer);
		if (Capabilities.isDebugger)
		{
			//_systemLayer.addChild(_fpsView);
		}

		stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, onKeyDown);
		onApplicationLoaded();
	}

	protected function onApplicationLoaded():void
	{
	}

	private function onKeyDown(event:starling.events.KeyboardEvent):void
	{
		if (!Log.isConsoleActive())
			CmdManager.instance().execCommandsForKey(event.keyCode);
	}

	private function cmdFPS(args:Array):void
	{
		if (!_fpsView.parent)
			stage.addChild(_fpsView);
		else
			_fpsView.parent.removeChild(_fpsView);
	}

	private function cmdLang(args:Array):void
	{
		if (!args.length)
		{
			Log.info("usage: lang [language id]");
			return;
		}

		LangLoader.instance().applyLang(args[0]);
	}

	private function cmdSound(args:Array):void
	{
		if (!args.length)
			Log.info("usage: sound [soundClassName]");
		else
		{
			var cls:Class = getDefinitionByName(args[0]) as Class;
			if (cls)
				USound.play(cls);
			else
				Log.warning("sound class not found!");
		}
	}
}
}