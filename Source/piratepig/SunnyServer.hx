package piratepig;

import haxe.Serializer;
import haxe.ds.IntMap;
import neko.Lib;
import neko.net.ThreadServer;
import sys.net.UdpSocket;

// ============================================================================
// Client Actions
// ============================================================================

abstract ClientAction {
	public function doHandle(c : Client) {
	}
}

class StartMoving extends ClientAction {
	var direction : Int;
	var velocity : Int;

	public override function doHandle(c : Client) {
		c.direction = direction;
		c.velocity = velocity;
	}
}

class StopMoving extends ClientAction {
	public override function doHandle(c : Client) {
		c.velocity = 0;
	}
}

// ============================================================================
// Enums and Typedefs
// ============================================================================

enum ClientStatus {
	Connected;
	Disconnected;
}

typedef Client = {
	var id : Int;
	var x : Int;
	var y : Int;
	var direction : Int;
	var velocity : Int; // pixels-per-second
	var status : ClientStatus;
}

typedef Message = {
	var str : String;
}

// ============================================================================
// Server
// ============================================================================

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

	public override function runThread(t) {
		super.runThread(t);
	}

//	public override function readClientData(c:ClientInfos<Client>) {
//		super ();
//	}

//	public override function loopThread(t:ThreadInfos) {
//		super ();
//	}

	public override function doClientDisconnected(s, c) {
		super.doClientDisconnected(s, c);
	}

	public override function runWorker() {
		super.runWorker();
	}

	override public function work(f:Void -> Void) {
		super.work(f);
	}

	public override function logError(e:Dynamic) {
		super.logError(e);
	}

	public override function addClient(sock:sys.net.Socket) {
		super.addClient(sock);
	}

	public override function refuseClient(sock:sys.net.Socket) {
		super.refuseClient(sock);
	}

	public override function runTimer() {
		super.runTimer();
	}

	public override function init() {
		super.init();
	}

	override public function addSocket(s:sys.net.Socket) {
		super.addSocket(s);
	}

	override public function run(host, port) {
		super.run(host, port);
	}

	override public function sendData(s:sys.net.Socket, data:String) {
		super.sendData(s, data);
	}

	override public function stopClient(s:sys.net.Socket) {
		super.stopClient(s);
	}

	override public dynamic function onError(e:Dynamic, stack) {
		super.onError(e, stack);
	}

	// create a client
	override public dynamic function clientConnected(s:sys.net.Socket) : Client {
		var client : Client = new Client();
		client.id = _nextClientId;
		client.x = Std.random(100)+1;
		client.y = Std.random(100)+1;
		client.direction = 0;
		client.velocity = 0;
		client.status = ClientStatus.Connected;

		_nextClientId++;
		Lib.println("client " + client.id + " is " + s.peer());
		sendData(s, haxe.Serializer.run(client.id));
		return { client : Client };
	}

	override public dynamic function clientDisconnected(c:Client) {
		Lib.println("client " + Std.string(c.id) + " disconnected");
		c.status = ClientStatus.Disconnected;
	}

	override public dynamic function readClientMessage(c:Client, buf:haxe.io.Bytes, pos:Int, len:Int) {
		// find out if there's a full message, and if so, how long it is.
		var complete = false;
		var cpos = pos;
		while (cpos < (pos+len) && !complete)
		{
			// check for a period/full stop (i.e.:  "." ) to signify a complete message
			complete = (buf.get(cpos) == 46);
			cpos++;
		}

		// no full message
		if( !complete ) return null;

		// got a full message, return it
		var msg:String = buf.getString(pos, cpos-pos);

		Unserializer.run(msg);

		return {msg: {str: msg}, bytes: cpos-pos};
	}

	// send message to client
	override public dynamic function clientMessage(c:Client, msg:Message) {
		Lib.println(c.id + " sent: " + msg.str);
	}

	override public dynamic function update() {
		super.update();
	}

	override public dynamic function afterEvent() {
		super.afterEvent();
	}

	public static function main()
	{
		var server = new SunnyServer();
		server.run("localhost", 1234);
	}

}
