package piratepig;

import neko.Lib;
import sys.net.Host;
import sys.net.Socket;
import sys.net.UdpSocket;

class Test {
	public var x(default,default):Int;

	public function new() {
		x = 10;
	}
}

class SunnyClient {

	public function new() {
	}

//	public function run()
	public static function main()
	{
		Lib.println("opening connection");
		var sock = new Socket();
		sock.connect(new Host("localhost"), 1234);

		Lib.println("sending messages");
		sock.write("this is a test.");            Sys.sleep(.1);
		sock.write("this is another test.");      Sys.sleep(.1);
		sock.write("this is a third test.");      Sys.sleep(.1);
		sock.write("this is the last test.");

		sock.close();
		Lib.println("client done");


		var test = new Test();
		test.x = 20;
		var y = test.x;
		y = 40;

		trace("test.x: " + test.x + "y: " + y);
	}
}
