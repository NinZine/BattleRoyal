package piratepig;

import cpp.net.ThreadServer;
import sys.net.UdpSocket;
import sys.net.Host;

typedef Client = {
	var id : Int;
}

typedef Message = {
	var str : String;
}


class SunnyServer extends  ThreadServer<Client, Message>{
	private var _server:UdpSocket;
	public function new() {
	}
}
