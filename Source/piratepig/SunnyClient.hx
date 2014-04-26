package piratepig;

import neko.Lib;
import sys.net.Host;
import sys.net.Socket;
import sys.net.UdpSocket;

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
	}
}
