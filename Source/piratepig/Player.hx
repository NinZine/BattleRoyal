package piratepig;

import flash.display.Bitmap;
import flash.display.Sprite;
import motion.Actuate;
import motion.actuators.GenericActuator;
import motion.easing.Linear;
import motion.easing.Quad;
import openfl.Assets;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.*;
import flash.geom.Vector3D;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.display.MovieClip;
import haxe.Unserializer;


class Player extends Sprite {
	static public var RADIANS_TO_DEGREES:Float = 180 / Math.PI;
	static public var DEGREES_TO_RADIANS:Float = Math.PI / 180;
	private var frameRate:Float = 0.024;
	private var lastFrameUpdate:Float = 0;

	// Input
	private var movingUp:Bool = false;
	private var movingDown:Bool = false;
	private var movingLeft:Bool = false;
	private var movingRight:Bool = false;
	private var shooting:Bool = false;

	// Pixels per second
	@isVar public var speed(default, default):Int = 100;
	private var cursorPosition:Point;
	private var currentAngle:Float = 0;
	@isVar private var direction(default, default):Vector3D = new Vector3D(0, 1);

	private var teddy:MovieClip;
	static private var FRONT = "front";
	static private var BACK = "back";
	static private var RIGHT = "right";
	private var currentAnimationName:String = RIGHT;
	
	public function new () {
		
		super ();
		
		Assets.loadLibrary ("characters", function (_) {
			teddy = Assets.getMovieClip ("characters:TeddyMC");
			teddy.gotoAndStop(0);
			teddy.getChildByName(FRONT).visible = false;
			teddy.getChildByName(BACK).visible = false;
			teddy.getChildByName(RIGHT).visible = true;
			cast(teddy.getChildByName(currentAnimationName), MovieClip).gotoAndStop(0);

			// Feet at bottom
			teddy.y -= teddy.height * 0.5;
			addChild (teddy);
		});

		mouseChildren = false;
		buttonMode = true;
		
		//graphics.beginFill (0x000000, 0);
		//graphics.drawRect (-5, -5, 66, 66);
		this.x = 200;
		this.y = 200;

		// XXX: Framerate is to fast, so animation become fast too
		//teddy.addEventListener(Event.ENTER_FRAME, onAnimateTeddy);
		//teddy.gotoAndPlay("front");

		// XXX: It's null in Flash target :/
		if (teddy != null) {
			teddy.gotoAndStop(0);
		}
	}
	
	/* Event Handlers ***********************************************************/
	
	public function onMouseMove(event:MouseEvent):Void {
		direction.x = this.x - event.localX;
		direction.y = this.y - event.localY;
		direction.normalize();
		var angle = Math.atan2(direction.y, direction.x) * RADIANS_TO_DEGREES;
		this.rotation = angle - 90;
	}
	
	
	public function onKeyDown (event:KeyboardEvent):Void {
		// XXX: Cases don't fall through in haXe, therefore no break <3
		switch (event.keyCode) {
			case Keyboard.DOWN: {
				movingDown = true;
				movingRight = false;
				movingUp = false;
				movingLeft = false;

				teddy.scaleX = 1;
				teddy.getChildByName(currentAnimationName).visible = false;
				teddy.getChildByName(FRONT).visible = true;
				currentAnimationName = FRONT;
			}
			case Keyboard.LEFT: {
				movingRight = false;
				movingUp = false;
				movingDown = false;
				movingLeft = true;

				teddy.scaleX = -1;
				teddy.getChildByName(currentAnimationName).visible = false;
				teddy.getChildByName(RIGHT).visible = true;
				currentAnimationName = RIGHT;
			}
			case Keyboard.RIGHT: {
				movingRight = true;
				movingLeft = false;
				movingUp = false;
				movingDown = false;

				teddy.scaleX = 1;
				teddy.getChildByName(currentAnimationName).visible = false;
				teddy.getChildByName(RIGHT).visible = true;
				currentAnimationName = RIGHT;
			}
			case Keyboard.UP: {
				movingUp = true;
				movingLeft = false;
				movingRight = false;
				movingDown = false;

				teddy.getChildByName(currentAnimationName).visible = false;
				teddy.getChildByName(BACK).visible = true;
				currentAnimationName = BACK;
			}
			case Keyboard.SPACE: {
				shooting = true;
			}
		}
	}
	
	
	public function onKeyUp (event:KeyboardEvent):Void {
		// XXX: Cases don't fall through in haXe, therefore no break <3
		switch (event.keyCode) {
			case Keyboard.DOWN: movingDown = false;
			case Keyboard.LEFT: movingLeft = false;
			case Keyboard.RIGHT: movingRight = false;
			case Keyboard.UP: movingUp = false;
			case Keyboard.SPACE: shooting = false;
		}
	}

	private function onAnimateTeddy(dt:Float) {
		lastFrameUpdate += dt;
		if (lastFrameUpdate < frameRate || teddy == null) {
			return;
		}

		var currentAnimation = cast(teddy.getChildByName(currentAnimationName), flash.display.MovieClip);
		if (movingRight || movingLeft || movingUp || movingDown) {
			if (currentAnimation.currentFrame == currentAnimation.totalFrames) {
				currentAnimation.gotoAndStop(0);
			} else {
				currentAnimation.gotoAndStop(currentAnimation.currentFrame + 1);
			}
		} else {
			currentAnimation.gotoAndStop(0);
		}
		lastFrameUpdate = 0;
	}
	
	
	public function update (dt:Float):Void {
		if (movingLeft) {
			this.x -= speed * dt;
		} else if (movingRight) {
			this.x += speed * dt;
		} else if (movingUp) {
			this.y -= speed * dt;
		} else if (movingDown) {
			this.y += speed * dt;
		}

		onAnimateTeddy(dt);
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
