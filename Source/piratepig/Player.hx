package piratepig;


import flash.display.Bitmap;
import flash.display.Sprite;
import motion.Actuate;
import motion.actuators.GenericActuator;
import motion.easing.Linear;
import motion.easing.Quad;
import openfl.Assets;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;


class Player extends Sprite {
	private static var SPEED:Int = 40;

	private var movingUp:Bool = false;
	private var movingDown:Bool = false;
	private var movingLeft:Bool = false;
	private var movingRight:Bool = false;
	
	public function new () {
		
		super ();
		
		var image = new Bitmap (Assets.getBitmapData ("images/game_bear.png"));
		image.smoothing = true;
		addChild (image);
		
		mouseChildren = false;
		buttonMode = true;
		
		graphics.beginFill (0x000000, 0);
		graphics.drawRect (-5, -5, 66, 66);
	}
	
	
	
	
	// Event Handlers
	
	
	
	
	public function onKeyDown (event:KeyboardEvent):Void {
		switch (event.keyCode) {
			case Keyboard.DOWN: movingDown = true;
			case Keyboard.LEFT: movingLeft = true;
			case Keyboard.RIGHT: movingRight = true;
			case Keyboard.UP: movingUp = true;
		}
	}
	
	
	public function onKeyUp (event:KeyboardEvent):Void {
		
		switch (event.keyCode) {
			case Keyboard.DOWN: movingDown = false;
			case Keyboard.LEFT: movingLeft = false;
			case Keyboard.RIGHT: movingRight = false;
			case Keyboard.UP: movingUp = false;
		}
		
	}
	
	
	public function update (dt:Float):Void {
		var x = 0;
		var y = 0;

		if (movingDown) {
			y += SPEED;
		}
		
		if (movingLeft) {
			x -= SPEED;
		}
		
		if (movingRight) {
			x += SPEED;
		}
		
		if (movingUp) {
			y -= SPEED;
		}

		this.x += x * dt;
		this.y += y * dt;

		trace("x: " + x + " y: " + y);
	}

	
	
	public function initialize ():Void {
		mouseEnabled = false;
		buttonMode = true;
		
		#if (!js || openfl_html5)
		scaleX = 1;
		scaleY = 1;
		alpha = 1;
		#end
		
	}
	
	
	public function moveTo (duration:Float, targetX:Float, targetY:Float):Void {
		
		//Actuate.tween (this, duration, { x: targetX, y: targetY } ).ease (Quad.easeOut).onComplete (this_onMoveToComplete);
		
	}
	
	
	public function remove (animate:Bool = true):Void {
	}

	// Event Handlers
	private function this_onMoveToComplete ():Void {
	}
	
}
