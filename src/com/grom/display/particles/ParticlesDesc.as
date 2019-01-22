/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.particles
{
import com.grom.display.filters.FiltersFactory;
import com.grom.display.particles.modifiers.Factory;
import com.grom.display.particles.modifiers.IParticleModifier;

public class ParticlesDesc
{
	public var _viewClass:Class;
	public var _numParticles:int = 100;
	private var _modifiers:Array = [];
	private var _filters:Array = [];

	public function ParticlesDesc()
	{
	}

	public function get filters():Array
	{
		return _filters;
	}

	public function addModifier(m:IParticleModifier):void
	{
		_modifiers.push(m);
	}

	public function get viewClass():Class
	{
		return _viewClass;
	}

	public function get numParticles():int
	{
		return _numParticles;
	}

	public function get modifiers():Array
	{
		return _modifiers;
	}

	public function parseFromXML(source:XML):void
	{
		_modifiers.length = 0;
		_numParticles = source.@num_particles;
		var node:XML;
		for each (node in source.modifiers.*)
		{
			var m:IParticleModifier = Factory.instance.create(node.name().localName);
			m.parseFromXML(node);
			_modifiers.push(m);
		}

		_filters.length = 0;
		for each (node in source.filters.*)
		{
			_filters.push(FiltersFactory.instance.create(node));
		}
	}
}
}
