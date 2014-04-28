package piratepig.shared;

class Client {
	@:isVar private var id(get_id, set_id): Int;
	@:isVar private var x(get_x, set_x): Int;
	@:isVar private var y(get_y, set_y): Int;
	@:isVar private var direction(get_direction, set_direction): Int;
	@:isVar private var velocity(get_velocity, set_velocity): Int; // pixels-per-second
	@:isVar private var status(get_status, set_status): ClientStatus;

	public function new(id: Int, x: Int, y: Int, direction: Int, velocity: Int, status: ClientStatus) {
		this.id = id;
		this.x = x;
		this.y = y;
		this.direction = direction;
		this.velocity = velocity;
		this.status = status;
	}

	public function toString() : String {
		return
			"Client: { "
			+ "id: " + id
			+ ", x: " + x
			+ ", y: " + y
			+ ", direction: " + direction
			+ ", velocity: " + velocity
			+ ", status: " + status
			+ " }";
	}

	public function set_id(value:Int) {
		return this.id = value;
	}

	public function get_id():Int {
		return id;
	}

	public function set_x(value:Int) {
		return this.x = value;
	}

	public function get_x():Int {
		return x;
	}

	public function set_y(value:Int) {
		return this.y = value;
	}

	public function get_y():Int {
		return y;
	}

	public function set_direction(value:Int) {
		return this.direction = value;
	}

	public function get_direction():Int {
		return direction;
	}

	public function get_velocity():Int {
		return velocity;
	}

	public function set_velocity(value:Int) {
		return this.velocity = value;
	}

	public function get_status():ClientStatus {
		return status;
	}

	public function set_status(value:ClientStatus) {
		return this.status = value;
	}
}