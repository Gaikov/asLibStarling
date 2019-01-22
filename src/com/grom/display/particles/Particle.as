/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.particles
{
import flash.display.Sprite;

public class Particle extends Sprite
{
	public var _dead:Boolean;
	public var _maxLife:Number;
	public var _life:Number;
	public var _velX:Number;
	public var _velY:Number;
	public var _accel:Number;
	public var _scaleStart:Number;
	public var _scaleEnd:Number;
	public var _gravity:Number;
	public var _size:Number;
	public var _angle:Number = 0;
	public var _angleVel:Number = 0;

	public function Particle(cls:Class)
	{
		addChild(new cls())
	}

	public function get lifeStage():Number
	{
		return 1 - _life / _maxLife;
	}
}
}
