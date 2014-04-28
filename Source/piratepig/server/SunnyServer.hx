package piratepig.server;

import piratepig.shared.ClientAction;
import piratepig.shared.ClientStatus;
import piratepig.shared.Client;
import haxe.Serializer;
import haxe.Unserializer;
import haxe.ds.IntMap;
import neko.Lib;
import neko.net.ThreadServer;
//import cpp.Lib;
//import cpp.net.ThreadServer;
//import sys.net.UdpSocket;

typedef Message = {
	var str : String;
}

class SunnyServer extends ThreadServer<Client, Message> {

//	private var _server(get_server, set_server) : UdpSocket;
	private var _nextClientId = 1;
	private var _clients:IntMap<Client> = new IntMap<Client>();

	public override function new() {
		super ();
	}

//	public function set_server(value : UdpSocket) {
//		this._server = value;
//	}
//
//	public function get_server() : UdpSocket {
//		return _server;
//	}

//	public override function readClientData(c:ClientInfos<Client>) {
//		super ();
//	}

//	public override function loopThread(t:ThreadInfos) {
//		super ();
//	}

	override public dynamic function clientConnected(s:sys.net.Socket) : Client {
		var client : Client = new Client(_nextClientId, Std.random(100)+1, Std.random(100)+1, 0, 0, ClientStatus.Connected);
		_clients.set(client.get_id(), client);
		_nextClientId++;
		Lib.println("client " + client.get_id() + " is " + s.peer());
		sendData(s, haxe.Serializer.run(client.get_id()));
		return client;
	}

	override public dynamic function clientDisconnected(c:Client) {
		Lib.println("client " + Std.string(c.get_id()) + " disconnected");
		c.set_status(ClientStatus.Disconnected);
	}

	override public dynamic function readClientMessage(c:Client, buf:haxe.io.Bytes, pos:Int, len:Int) {
		var msg:String = buf.getString(pos, len);
		return {msg: {str: msg}, bytes: len};
	}

	override public dynamic function clientMessage(c:Client, msg:Message) {
		Lib.println(c.get_id() + " sent: " + msg.str);
		var clientAction : ClientAction = haxe.Unserializer.run(msg.str);
		Lib.println("decoded action: " + clientAction.toString());
		clientAction.doHandle(_clients.get(c.get_id()));
		Lib.println("client after update: " + _clients.get(c.get_id()).toString());
	}

	override public dynamic function update() {
		// TODO move everybody by one and send client info delta to all connected clients
//		trace("begin update function");
//		trace(haxe.Serializer.run(_clients));
//		trace("end update function");
	}

	override public dynamic function afterEvent() {
		super.afterEvent();
	}

	public static function main() {
		var server = new SunnyServer();
		server.run("localhost", 1234);
	}

}
