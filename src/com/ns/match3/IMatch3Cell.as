/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 30.1.12
 */
package com.ns.match3
{
public interface IMatch3Cell
{
	function get isFree():Boolean;
	function isMatchTo(other:IMatch3Cell):Boolean;
	function get x():int;
	function get y():int;
}
}
