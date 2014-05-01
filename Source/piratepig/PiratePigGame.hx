package piratepig;

import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.HSlider;
import haxe.ui.toolkit.events.UIEvent;
import flash.Lib;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.filters.BlurFilter;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.media.Sound;
import flash.net.Socket;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.ui.Keyboard;
import motion.Actuate;
import motion.easing.Quad;
import openfl.Assets;


class PiratePigGame extends Sprite {
	public var currentScale(default, default):Float;

	private static var tileImages = [ "images/game_bear.png", "images/game_bunny_02.png", "images/game_carrot.png", "images/game_lemon.png", "images/game_panda.png", "images/game_piratePig.png" ];
	
	private var previousTime:Float = 0.0;
	private var player:Player;
	private var gameObjects:Array<DisplayObject> = new Array<DisplayObject>();
	
	public function new (stage:Stage) {
		
		super ();
		
		player = new Player();

		// Add a couple of bushes
		Assets.loadLibrary ("characters", function (_) {
			for (i in 0...10) {
				var bush = Assets.getMovieClip("characters:BushMC");
				bush.x = Math.random() * stage.stageWidth;
				bush.y = Math.random() * stage.stageHeight;

				gameObjects.push(bush);
			}
			gameObjects.push(player);
			gameObjects.sort(sortDisplayObjectsByY);
			for (i in 0...gameObjects.length) {
				addChild(gameObjects[i]);
			}

			stage.addEventListener (KeyboardEvent.KEY_DOWN, player.onKeyDown);
			stage.addEventListener (KeyboardEvent.KEY_UP, player.onKeyUp);
			//stage.addEventListener (MouseEvent.MOUSE_MOVE, player.onMouseMove);
			stage.addEventListener (Event.ENTER_FRAME, onEnterFrame);


#if (debug)
			Macros.addStyleSheet("styles/gradient/gradient.css");
			Toolkit.init();
			Toolkit.openFullscreen(function(root:Root) {
				var slider:HSlider = new HSlider();
				slider.width = 100;
				slider.min = 0;
				slider.max = 300;
				slider.incrementSize = 0.5;
				slider.addEventListener(UIEvent.CHANGE, function (e) {
					player.speed = cast(slider.pos, Int);
				});
				slider.pos = slider.max * 0.5;
				root.addChild(slider);
			});
#end
		});
	}

	private function sortDisplayObjectsByY(a:DisplayObject, b:DisplayObject):Int {
		if (a.y < b.y) return -1;
		if (a.y > b.y) return 1;
		return 0;
	}

	private function onEnterFrame(event:Event) {
		var currentTime:Float = Lib.getTimer ();
        var deltaTime = currentTime - previousTime;
        previousTime = currentTime;

		player.update(deltaTime * 0.001);

		// Sort game objects by Y position before render
		gameObjects.sort(sortDisplayObjectsByY);
		for (i in 0...gameObjects.length) {
			setChildIndex(gameObjects[i], i);
		}
	}

	public function resize (newWidth:Int, newHeight:Int):Void {
		
		var maxWidth = newWidth * 0.90;
		var maxHeight = newHeight * 0.86;
		
		currentScale = 1;
		scaleX = 1;
		scaleY = 1;
		
		
		var currentWidth = width;
		var currentHeight = height;
		if (currentWidth > maxWidth || currentHeight > maxHeight) {
			
			var maxScaleX = maxWidth / currentWidth;
			var maxScaleY = maxHeight / currentHeight;
			
			if (maxScaleX < maxScaleY) {
				
				currentScale = maxScaleX;
				
			} else {
				
				currentScale = maxScaleY;
				
			}
			
			scaleX = currentScale;
			scaleY = currentScale;
			
		}
		
		x = newWidth / 2 - (currentWidth * currentScale) / 2;
		

		player.scaleX = currentScale;
		player.scaleY = currentScale;
	}

}
