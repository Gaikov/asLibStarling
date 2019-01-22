/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 14.11.12
 */
package com.ns.score
{
import net.maygem.lib.settings.UserVar;

public class LocalScoreAPI implements IScoreAPI
{
	private var _listListener:IScoreListListener;
	private var _submitListener:IScoreSubmitListener;
	private var _scoresStore:UserVar;

	public function LocalScoreAPI(localVarID:String, listListener:IScoreListListener, submitListener:IScoreSubmitListener)
	{
		_scoresStore = new UserVar(localVarID, []);
		_listListener = listListener;
		_submitListener = submitListener;
	}

	public function loadList(limit:int, policy:String = null):void
	{
		var res:Array = [];
		var list:Array = _scoresStore.value;
		for each (var s:Object in list)
		{
			res.push(new ScoreInfo(s.name, s.score, s.time));
		}

		res.sortOn(["score"], Array.DESCENDING | Array.NUMERIC);
		if (res.length > limit)
		{
			res.length = limit;
		}

		_listListener.onSuccess(res);
	}

	public function submitScore(name:String, score:int, time:int):void
	{
		var list:Array = _scoresStore.value;
		list.push({name:name, score:score, time:time});
		_scoresStore.forceValue(list);
		_submitListener.onSuccess(0);
	}
}
}
