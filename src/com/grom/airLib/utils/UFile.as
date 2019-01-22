/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.02.13
 */
package com.grom.airLib.utils
{
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

public class UFile
{
	static public function readFile(file:File):ByteArray
	{
		var bytes:ByteArray = new ByteArray();
		var stream:FileStream = new FileStream();
		stream.open(file, FileMode.READ);
		stream.readBytes(bytes);
		stream.close();
		bytes.position = 0;
		return bytes;
	}

	static public function readXML(file:File):XML
	{
		var bytes:ByteArray = readFile(file);
		return new XML(bytes.readUTFBytes(bytes.bytesAvailable));
	}
}
}
