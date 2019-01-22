/**
 * Created by IntelliJ IDEA.
 * User: Roman Gaikov
 * Date: 10.02.12
 */
package net.maygem.lib.scene
{
import starling.display.DisplayObject;
import starling.display.Sprite;

import net.maygem.lib.scene.transition.ISceneTransition;

public class SceneDirector
{
	private static var _instance:SceneDirector;

	private var _root:Sprite;
	private var _transitionOverlay:Sprite;
	private var _scenesRoot:Sprite;
	private var _currentScene:DisplayObject;
	private var _sceneTransition:ISceneTransition;

	public function SceneDirector()
	{
		_root = new Sprite();
		//_root.mouseEnabled = false;

		_scenesRoot = new Sprite();
		//_scenesRoot.mouseEnabled = false;
		_root.addChild(_scenesRoot);

		_transitionOverlay = new Sprite();
		//_transitionOverlay.mouseEnabled = false;
		_root.addChild(_transitionOverlay);
	}

	public static function get instance():SceneDirector
	{
		if (!_instance)
		{
			_instance = new SceneDirector();
		}
		return _instance;
	}

	public function set sceneTransition(value:ISceneTransition):void
	{
		if (_sceneTransition)
		{
			_sceneTransition.stop();
		}
		_sceneTransition = value;
	}

	public function isTransitionActive():Boolean
	{
		return _sceneTransition && _sceneTransition.isActive();
	}

	public function get root():DisplayObject
	{
		return _root;
	}

	public function startScene(scene:DisplayObject, useTransition:Boolean = true):void
	{
		var placer:ScenePlacer = new ScenePlacer(_currentScene, scene, _scenesRoot,
				function (newScene:DisplayObject):void
				{
					_currentScene = newScene;
				});

		if (_sceneTransition)
		{
			_sceneTransition.stop();
		}

		if (_sceneTransition && useTransition)
		{
			_sceneTransition.startTransition(_transitionOverlay, placer);
		}
		else
		{
			placer.removeOldScene();
			placer.addNewScene();
		}
	}

	public function isSceneActive(sceneClass:Class):Boolean
	{
		return _currentScene is sceneClass;
	}
}
}

import starling.display.DisplayObject;
import starling.display.Sprite;
import flash.system.System;

import net.maygem.lib.scene.event.SceneEvent;

import net.maygem.lib.scene.transition.IScenePlacer;
import net.maygem.lib.utils.UDisplay;

class ScenePlacer implements IScenePlacer
{
	private var _sceneRoot:Sprite;
	private var _oldScene:DisplayObject;
	private var _newScene:DisplayObject;
	private var _onSceneChanged:Function;
	private var _completedDispatcher:DisplayObject;

	public function ScenePlacer(oldScene:DisplayObject, newScene:DisplayObject, sceneRoot:Sprite, onSceneChanged:Function)
	{
		_oldScene = oldScene;
		_completedDispatcher = _newScene = newScene;
		_sceneRoot = sceneRoot;
		_onSceneChanged = onSceneChanged;


		if (_oldScene)
		{
			_oldScene.touchable = false;
		}
	}

	public function get newScene():DisplayObject
	{
		return _newScene;
	}

	public function removeOldScene():void
	{
		if (_oldScene)
		{
			_sceneRoot.removeChild(_oldScene);
			_oldScene = null;
			_onSceneChanged(null);
		}
		System.gc();
	}

	public function addNewScene():void
	{
		if (_newScene)
		{
			_sceneRoot.addChild(_newScene);
			_onSceneChanged(_newScene);
			_newScene = null;
		}
		System.gc();
	}

	public function onTransitionCompleted():void
	{
		_completedDispatcher.dispatchEvent(new SceneEvent(SceneEvent.TRANSITION_COMPLETED));
	}
}