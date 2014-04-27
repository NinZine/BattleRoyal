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
	private static var SPEED:Int = 40;
	private var frameRate:Float = 0.024;
	private var lastFrameUpdate:Float = 0;

	private var movingUp:Bool = false;
	private var movingDown:Bool = false;
	private var movingLeft:Bool = false;
	private var movingRight:Bool = false;
	private var cursorPosition:Point;
	private var currentAngle:Float = 0;
	@isVar private var direction(default, default):Vector3D = new Vector3D(0, 1);
	private var teddy:MovieClip;
	private var currentAnimation:String = "front";
	
	public function new () {
		
		super ();
		
		var image = new Bitmap (Assets.getBitmapData ("images/game_bear.png"));
		image.smoothing = true;


		Assets.loadLibrary ("characters", function (_) {
			
			//teddy = Assets.getMovieClip ("characters:teddy");
			teddy = Assets.getMovieClip ("characters:teddy");
			addChild (teddy);
		});


		//addChild (image);
		// Center the image
		image.x -= image.width * 0.5;
		image.y -= image.height * 0.5;
		
		mouseChildren = false;
		buttonMode = true;
		
		//graphics.beginFill (0x000000, 0);
		//graphics.drawRect (-5, -5, 66, 66);
		this.x = 400;
		this.y = 400;
		// XXX: Framerate is to fast, so animation become fast too
		//teddy.addEventListener(Event.ENTER_FRAME, onAnimateTeddy);
		//teddy.gotoAndPlay("front");
		teddy.gotoAndStop(28);
	}
	
	
	
	
	// Event Handlers
	
	public function onMouseMove(event:MouseEvent):Void {
		direction.x = this.x - event.localX;
		direction.y = this.y - event.localY;
		direction.normalize();
		var angle = Math.atan2(direction.y, direction.x) * RADIANS_TO_DEGREES;
		this.rotation = angle - 90;
	}
	
	
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

	private function onAnimateTeddy(dt:Float) {
		lastFrameUpdate += dt;
		if (lastFrameUpdate < frameRate) {
			return;
		}

		var right = cast(teddy.getChildByName("right"), flash.display.MovieClip);
		if (movingRight) {
			teddy.scaleX = 1;
			if (teddy.currentFrame == 40) {
				teddy.gotoAndStop(28);
				right.gotoAndStop(0);
			} else {
				teddy.gotoAndStop(teddy.currentFrame + 1);
				right.gotoAndStop(right.currentFrame + 1);
			}
		} else if (movingLeft) {
			teddy.scaleX = -1;
			if (teddy.currentFrame == 40) {
				teddy.gotoAndStop(28);
				right.gotoAndStop(0);
			} else {
				teddy.gotoAndStop(teddy.currentFrame + 1);
				right.gotoAndStop(right.currentFrame + 1);
			}
		} else {
			teddy.gotoAndStop(28);
			right.gotoAndStop(0);
			
		}
		lastFrameUpdate = 0;
	}
	
	
	public function update (dt:Float):Void {
		/*
		if (movingUp) {
			this.x -= direction.x * SPEED * dt;
			this.y -= direction.y * SPEED * dt;
		}
		*/

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
