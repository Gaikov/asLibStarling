/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 16.2.12
 */
package com.ns.score
{
public class ScoreInfo
{
	private var _name:String;
	private var _score:int;
	private var _time:int;

	public function ScoreInfo(name:String, score:int, time:int)
	{
		_name = name;
		_score = score;
		_time = time;
	}

	public function get name():String
	{
		return _name;
	}

	public function get score():int
	{
		return _score;
	}

	public function get time():int
	{
		return _time;
	}

    public function toString():String
    {
        return _name + "," + _score + "," + _time;
    }
}
}
