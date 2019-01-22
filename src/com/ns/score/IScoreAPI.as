/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 13.11.12
 */
package com.ns.score
{
public interface IScoreAPI
{
	function loadList(limit:int, policy:String = null):void
	function submitScore(name:String, score:int, time:int):void
}
}
