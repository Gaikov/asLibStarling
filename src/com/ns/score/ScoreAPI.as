/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 16.2.12
 */
package com.ns.score
{
import com.adobe.crypto.MD5;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

import net.maygem.lib.debug.Log;

public class ScoreAPI implements IScoreAPI
{
	private var _gameID:String;
	private var _submitLoader:ScoreLoader;
	private var _listLoader:ScoreLoader;
	private var _listListener:IScoreListListener;
	private var _scoreUrl:String;

	public function ScoreAPI(gameID:String, scoreUrl:String, submitListener:IScoreSubmitListener = null, listListener:IScoreListListener = null)
	{
		_gameID = gameID;
		_listListener = listListener;
		_scoreUrl = scoreUrl;

		_submitLoader = new ScoreLoader(scoreUrl + "/score_add.php");
		_submitLoader.dispatcher().addEventListener(Event.COMPLETE, function (e:Event):void
		{
			var result:XML;

			try
			{
				result = new XML(e.target.data);
			}
			catch (e:Error)
			{
				submitListener.onError("Invalid result XML");
				return;
			}

			if (result.localName() == "success")
			{
				Log.info("score submited to: ", scoreUrl);
				if (submitListener)
				{
					submitListener.onSuccess(0);
				}
			}
			else
			{
				submitListener.onError(result.toString());
			}

		});

		_submitLoader.dispatcher().addEventListener(IOErrorEvent.IO_ERROR, function ():void
		{
			Log.error("score io error to: ", scoreUrl);
			if (submitListener)
			{
				submitListener.onError("Can't submit score!");
			}
		});

		_listLoader = new ScoreLoader(scoreUrl + "/score_list.php");
		_listLoader.dispatcher().addEventListener(Event.COMPLETE, onListLoaded);

		_listLoader.dispatcher().addEventListener(IOErrorEvent.IO_ERROR, function ():void
		{
			Log.error("score list io error to: ", scoreUrl);
			if (_listListener)
			{
				_listListener.onError("Can't load scores!");
			}
		});
	}

	private function onListLoaded(event:Event):void
	{
		Log.info("score list loaded from: ", _scoreUrl);

		var xml:XML;
		try
		{
			xml = XML(URLLoader(event.target).data);
		}
		catch (e:Error)
		{
			_listListener.onError("invalid xml");
			return;
		}

		if (xml.localName() == "scores")
		{
			var list:Array = [];
			for each (var node:XML in xml.score)
			{
				list.push(new ScoreInfo(node.@name, node.@score, node.@time));
			}
			_listListener.onSuccess(list);
		}
		else
		{
			_listListener.onError(xml.toString());
		}
	}

	public function loadList(limit:int, policy:String = null):void
	{
		var data:URLVariables = new URLVariables();
		data.game_id = _gameID;
		data.limit = limit;
		if (policy)
		{
			data.policy = policy;
		}

		_listLoader.loadData(data, URLRequestMethod.POST);
	}

	public function submitScore(name:String, score:int, time:int):void
	{
		var data:URLVariables = new URLVariables();
		data.game_id = _gameID;
		data.name = name;
		data.score = score;
		data.time = time;

		var str:String = "grom-" + _gameID + "," + name + "," + score + "," + time + "-games.com";
		data.hash = MD5.hash(str);

		_submitLoader.loadData(data, URLRequestMethod.POST);
	}
}
}


