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

	public override function readClientData(c:ClientInfos<null>) {
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

	override public dynamic function clientConnected(s:sys.net.Socket)

	override public dynamic function clientDisconnected(c:null) {
	}

	override public dynamic function readClientMessage(c:null, buf:haxe.io.Bytes, pos:Int, len:Int):{
	}

	override public dynamic function clientMessage(c:null, msg:null) {
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
