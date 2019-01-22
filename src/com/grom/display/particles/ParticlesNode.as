/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.particles
{
import com.grom.display.particles.modifiers.IParticleModifier;

import flash.display.Sprite;

import net.maygem.lib.scene.frameListener.FramePolicy;
import net.maygem.lib.scene.frameListener.IFrameListener;
import net.maygem.lib.utils.UContainer;

public class ParticlesNode extends Sprite implements IFrameListener
{
	private var _desc:ParticlesDesc;
	private var _particles:Array = [];

	public function ParticlesNode(desc:ParticlesDesc)
	{
		_desc = desc;
		//new FramePolicy(this, this);
		filters = desc.filters;
	}

	public function emmit():void
	{
		_particles.length = 0;
		UContainer.removeAllChildren(this);

		for (var i:int = 0; i < _desc.numParticles; i++)
		{
			var p:Particle = new Particle(_desc.viewClass);
			addChild(p);
			_particles.push(p);

			for each (var m:IParticleModifier in _desc.modifiers)
			{
				m.init(p);
			}
		}
	}

	public function onEnterFrame():void
	{
		emulateStep();
	}

	public function get isAlive():Boolean
	{
		return _particles.length > 0;
	}

	public function emulateStep():void
	{
		for (var i:int = _particles.length - 1; i >= 0; i--)
		{
			var p:Particle = _particles[i];
			for each (var m:IParticleModifier in _desc.modifiers)
			{
				m.move(p);
			}

			if (p._dead)
			{
				_particles.splice(i, 1);
				removeChild(p);
			}
		}
	}
}
}
