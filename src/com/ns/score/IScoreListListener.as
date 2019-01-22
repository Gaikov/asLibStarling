/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 16.2.12
 */
package com.ns.score
{
public interface IScoreListListener
{
	function onSuccess(list:Array):void
	function onError(reason:String):void
}
}
