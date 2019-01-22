/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 16.2.12
 */
package com.ns.score
{
public interface IScoreSubmitListener
{
	function onSuccess(place:int):void
	function onError(reason:String):void
}
}
