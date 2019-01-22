/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import net.maygem.lib.utils.UMath;

public class LinerPosModifier implements IParticleModifier
{
	public static const NAME:String = "linear_vel";

	private var _minAngle:Number, _maxAngle:Number;
	private var _minVel:Number, _maxVel:Number;

	public function LinerPosModifier(minAngle:Number = 0, maxAngle:Number = 0, minVel:Number = 0, maxVel:Number = 0)
	{
		_minAngle = minAngle;
		_maxAngle = maxAngle;
		_minVel = minVel;
		_maxVel = maxVel;
	}

	public function parseFromXML(node:XML):void
	{
		_minAngle = node.@min_angle;
		_maxAngle = node.@max_angle;
		_minVel = node.@min_vel;
		_maxVel = node.@max_vel;
	}

	public function init(p:Particle):void
	{
		var angle:Number = UMath.deg2rad(UMath.randomRange(_minAngle, _maxAngle));
		var vel:Number = UMath.randomRange(_minVel, _maxVel);
		p._velX = Math.sin(angle) * vel;
		p._velY = Math.cos(angle) * vel;
	}

	public function move(p:Particle):void
	{
		p.x += p._velX;
		p.y += p._velY;
	}
}
}
