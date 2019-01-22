/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 16.2.12
 */
package com.ns.score
{
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLVariables;

internal class ScoreLoader
{
	private var _loader:URLLoader = new URLLoader();
	private var _url:String;

	public function ScoreLoader(url:String)
	{
		super();
		_url = url;
	}

	public function dispatcher():EventDispatcher
	{
		return _loader;
	}

	public function loadData(data:URLVariables, method:String):void
	{
		var request:URLRequest = new URLRequest(_url);
		request.method = method;
		request.data = data;
		_loader.load(request);
	}
}
}
