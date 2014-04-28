package piratepig;

import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.HSlider;
import haxe.ui.toolkit.events.UIEvent;
import flash.Lib;
import flash.display.Bitmap;
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
	
	public function new (stage:Stage) {
		
		super ();
		
		player = new Player();
		stage.addChild(player);

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
			slider.max = 100;
			slider.incrementSize = 0.5;
			slider.addEventListener(UIEvent.CHANGE, function (e) {
				player.speed = cast(slider.pos, Int);
			});
			slider.pos = slider.max * 0.5;
			root.addChild(slider);
		});
#end
	}

	private function onEnterFrame(event:Event) {
		var currentTime:Float = Lib.getTimer ();
        var deltaTime = currentTime - previousTime;
        previousTime = currentTime;

		player.update(deltaTime * 0.001);
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
