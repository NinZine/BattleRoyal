package piratepig;

import neko.Lib;
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

	private var _server(get_server, set_server):UdpSocket;

	public function new() {
	}

	public function set_server(value:UdpSocket) {
		this._server = value;
	}

	public function get_server():UdpSocket {
		return _server;
	}

	public override function runThread(t) {
	}

	public override function readClientData(c:ClientInfos<Client>) {
	}

	public override function loopThread(t:ThreadInfos) {
	}

	public override function doClientDisconnected(s, c) {
	}

	public override function runWorker() {
	}

	override public function work(f:Void -> Void) {
	}

	public override function logError(e:Dynamic) {
	}

	public override function addClient(sock:sys.net.Socket) {
	}

	public override function refuseClient(sock:sys.net.Socket) {
	}

	public override function runTimer() {
	}

	public override function init() {
	}

	override public function addSocket(s:sys.net.Socket) {
	}

	override public function run(host, port) {
	}

	override public function sendData(s:sys.net.Socket, data:String) {
	}

	override public function stopClient(s:sys.net.Socket) {
	}

	override public dynamic function onError(e:Dynamic, stack) {
	}

	// create a client
	override public dynamic function clientConnected(s:sys.net.Socket) {
		var num = Std.random(100);
		Lib.println("client " + num + " is " + s.peer());
		return { id: num };
	}

	override public dynamic function clientDisconnected(c:Client) {
		Lib.println("client " + Std.string(c.id) + " disconnected");
	}

	override public dynamic function readClientMessage(c:Client, buf:haxe.io.Bytes, pos:Int, len:Int) : Message {
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
		var msg:String = buf.readString(pos, cpos-pos);
		return {msg: {str: msg}, bytes: cpos-pos};
	}

	// send message to client
	override public dynamic function clientMessage(c:Client, msg:Message) {
		Lib.println(c.id + " sent: " + msg.str);
	}

	override public dynamic function update() {
	}

	override public dynamic function afterEvent() {
	}

	public static function main()
	{
		var server = new SunnyServer();
		server.run("localhost", 1234);
	}

}
