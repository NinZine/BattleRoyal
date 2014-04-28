package piratepig.client;

import haxe.Serializer;
import piratepig.shared.ClientAction.StartMoving;
import neko.Lib;
import sys.net.Host;
import sys.net.Socket;
import sys.net.UdpSocket;

class SunnyClient {
	public function new() {
	}

//	public function run()
	public static function main() {
		Lib.println("opening connection");
		var sock = new Socket();
		sock.connect(new Host("localhost"), 1234);

		var action : StartMoving = new StartMoving(10, 20);
		Lib.println("sending message: " + action.toString());
		sock.write(haxe.Serializer.run(action));

		sock.close();
		Lib.println("client done");
	}
}
