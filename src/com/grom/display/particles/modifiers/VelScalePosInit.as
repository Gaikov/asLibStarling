/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 06.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

public class VelScalePosInit implements IParticleModifier
{
	public static const NAME:String = "vel_scaled_pos";

	private var _scaleX:Number;
	private var _scaleY:Number;

	public function VelScalePosInit()
	{
	}

	public function parseFromXML(node:XML):void
	{
		_scaleX = node.@x;
		_scaleY = node.@y;
	}

	public function init(p:Particle):void
	{
		p._velX = p.x * _scaleX;
		p._velY = p.y * _scaleY;
	}

	public function move(p:Particle):void
	{
	}
}
}
