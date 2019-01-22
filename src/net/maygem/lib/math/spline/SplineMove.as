/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 25.06.12
 */
package net.maygem.lib.math.spline
{
import flash.geom.Point;

import net.maygem.lib.utils.UPoint;

public class SplineMove
{
	private var _points:Array = [];
	private var _targetPoint:MovePoint;
	private var _spline:Spline;
	private var _currTime:Number = 0;

	public function SplineMove()
	{
	}

	public function addPoint(pos:Point, vel:Point, time:Number):void
	{
		if (!_targetPoint)
		{
			_targetPoint = new MovePoint(pos, vel, time);
		}
		else
		{
			_points.push(new MovePoint(pos, vel, time));
		}
	}

	public function addSpeedPoint(pos:Point, speed:Number, timeScale:Number = 1):void
	{
		if (!_targetPoint)
		{
			_targetPoint = new MovePoint(pos, new Point(0, 0), 0);
		}
		else
		{
			var prev:MovePoint = _points.length ? _points[_points.length - 1] : _targetPoint;
			var dist:Number = UPoint.distance(prev._pos, pos);
			var time:Number = dist * timeScale / speed;
			var vel:Point = UPoint.direction(prev._pos, pos, speed);
			_points.push(new MovePoint(pos, vel, time));
		}
	}

	public function computePoint(elapsedTime:Number):Point
	{
		if (!_spline)
		{
			_currTime = 0;
			if (!nextSegment())
			{
				return null;
			}
		}
		else
		{
			_currTime += elapsedTime;
			if (_currTime >= _targetPoint._time)
			{
				_currTime = _currTime - _targetPoint._time;
				if (!nextSegment())
				{
					return null;
				}
			}
		}
		return _spline.computePos(_currTime);
	}

	private function nextSegment():Boolean
	{
		var point:MovePoint = _points.shift();
		if (point)
		{
			_spline = new Spline();
			_spline.setSegment(_targetPoint._pos, _targetPoint._vel, point._pos, point._vel, point._time);
			_targetPoint = point;
			return true;
		}
		return false;
	}
}
}

import flash.geom.Point;

class MovePoint
{
	public var _pos:Point;
	public var _vel:Point;
	public var _time:Number;

	public function MovePoint(pos:Point, vel:Point, time:Number)
	{
		_pos = pos.clone();
		_vel = vel.clone();
		_time = time;
	}
}
