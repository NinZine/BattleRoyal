package piratepig.shared;

class ClientAction {
	public function new() {
	}

	public function doHandle(c : Client) {
	}

	public function toString() : String {
		return "";
	}
}

class StartMoving extends ClientAction {
	@:isVar private var direction(get_direction, set_direction): Int;
	@:isVar private var velocity(get_velocity, set_velocity): Int;

	public function new(direction: Int, velocity: Int) {
		super();
		this.direction = direction;
		this.velocity = velocity;
	}

	public override function doHandle(c : Client) {
		c.set_direction(direction);
		c.set_velocity(velocity);
	}

	public override function toString() : String {
		return "StartMoving: { direction: " + direction + ", velocity: " + velocity + " }";
	}

	public function get_direction():Int {
		return direction;
	}

	public function set_direction(value:Int) {
		return this.direction = value;
	}

	public function get_velocity():Int {
		return velocity;
	}

	public function set_velocity(value:Int) {
		return this.velocity = value;
	}
}

class StopMoving extends ClientAction {

	public function new() {
		super();
	}

	public override function doHandle(c : Client) {
		c.set_velocity(0);
	}

	public override function toString() : String {
		return "StopMoving: {  }";
	}
}
