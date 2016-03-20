/**
 * Lightning Class
 * AS3 Class to mimic a real lightning or electric discharge
 * 
 * @author		Pierluigi Pesenti
 * @version		0.5
 *
 */

/*
Licensed under the MIT License

Copyright (c) 2008 Pierluigi Pesenti

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

http://blog.oaxoa.com/
*/

package com.oaxoa.fx {

	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.filters.GlowFilter;
	import flash.display.BlendMode;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.BlendMode;
	
	import com.oaxoa.fx.LightningFadeType;
	
	public class Lightning extends Sprite {
		
		private const SMOOTH_COLOR:uint=0x808080;

		private var holder:Sprite;
		
		private var sbd:BitmapData;
		
		private var bbd:BitmapData;
		
		private var soffs:Array;
		
		private var boffs:Array;
		
		private var glow:GlowFilter;
		//
		public var lifeSpan:Number;
		
		private var lifeTimer:Timer;
		//
		public var startX:Number;
		public var startY:Number;
		public var endX:Number;
		public var endY:Number;

		public var len:Number;
		public var multi:Number;
		public var multi2:Number;

		public var _steps:uint;
		public var stepEvery:Number;
		private var seed1:uint;
		private var seed2:uint;
		
		public var smooth:Sprite;
		public var childrenSmooth:Sprite;
		public var childrenArray:Array=[];
		
		public var _smoothPercentage:uint=50;
		public var _childrenSmoothPercentage:uint;
		public var _color:uint;
				
		private var generation:uint;
		private var _childrenMaxGenerations:uint=3;
		private var _childrenProbability:Number=0.025;
		private var _childrenProbabilityDecay:Number=0;
		private var _childrenMaxCount:uint=4;
		private var _childrenMaxCountDecay:Number=.5;
		private var _childrenLengthDecay:Number=0;
		private var _childrenAngleVariation:Number=60;
		private var _childrenLifeSpanMin:Number=0;
		private var _childrenLifeSpanMax:Number=0;
		private var _childrenDetachedEnd:Boolean=false;
		
		private var _maxLength:Number=0;
		private var _maxLengthVary:Number=0;
		public var _isVisible:Boolean=true;
		public var _alphaFade:Boolean=true;
		public var parentInstance:Lightning;
		private var _thickness:Number;
		private var _thicknessDecay:Number;
		private var initialized:Boolean=false;
		
		private var _wavelength:Number=.3;
		private var _amplitude:Number=.5;
		private var _speed:Number=1;
		
		private var calculatedWavelength:Number;
		private var calculatedSpeed:Number;
				
		public var alphaFadeType:String;
		public var thicknessFadeType:String;
		
		private var position:Number=0;
		private var absolutePosition:Number=1;
		
		private var dx:Number;
		private var dy:Number;
		
		private var soff:Number;
		private var soffx:Number;
		private var soffy:Number;
		private var boff:Number;
		private var boffx:Number;
		private var boffy:Number;
		private var angle:Number;
		private var tx:Number;
		private var ty:Number;

		public function Lightning(pcolor:uint=0xffffff, pthickness:Number=2, pgeneration:uint=0) {
			mouseEnabled=false;
			_color=pcolor;
			_thickness=pthickness;
			
			alphaFadeType=LightningFadeType.GENERATION;
			thicknessFadeType=LightningFadeType.NONE;
			
			generation = pgeneration;
			if(generation==0) init();
		}
		private function init():void {
			
			randomizeSeeds();
			
			if(lifeSpan>0) startLifeTimer();
			
			multi2=.03;

			holder=new Sprite();
			holder.mouseEnabled=false;

			startX=50;
			startY=200;
			endX=50;
			endY=600;

			stepEvery=4;
			_steps=50;
			
			sbd=new BitmapData(_steps, 1, false);
			bbd=new BitmapData(_steps, 1, false);
			soffs=[new Point(0, 0), new Point(0, 0)];
			boffs=[new Point(0, 0), new Point(0, 0)];
			
			if(generation==0) {
				smooth = new Sprite();
				childrenSmooth = new Sprite();
				smoothPercentage = 50;
				childrenSmoothPercentage=50;
			} else {
				smooth=childrenSmooth=parentInstance.childrenSmooth;
			}
			
			steps=100;
			childrenLengthDecay=.5;
			
			addChild(holder);
			initialized=true;
		}
		private function randomizeSeeds():void {
			seed1=Math.random()*100;
			seed2=Math.random()*100;
		}
		public function set steps(arg:uint):void {
			if(arg < 2 ) arg=2;
			if(arg  >2880) arg=2880;
			_steps=arg;
			sbd=new BitmapData(_steps, 1, false);
			bbd=new BitmapData(_steps, 1, false);
			if(generation==0) smoothPercentage=smoothPercentage;
		}
		public function get steps():uint {
			return _steps;
		}
		public function startLifeTimer():void {
			lifeTimer=new Timer(lifeSpan*1000, 1);
			lifeTimer.start();
			lifeTimer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		private function onTimer(event:TimerEvent):void {
			kill();
		}
		public function kill():void {
			killAllChildren();
			if(lifeTimer) {
				lifeTimer.removeEventListener(TimerEvent.TIMER, kill);
				lifeTimer.stop();
			}
			if(parentInstance!=null) {
				var count:uint=0;
				var par:Lightning=this.parent as Lightning;
				for each(var obj:Object in par.childrenArray) {
					if(obj.instance==this) {
						par.childrenArray.splice(count, 1);
					}
					count++;
				}
			}
			this.parent.removeChild(this);
			delete this;
		}
		public function killAllChildren():void {
			while(childrenArray.length>0) {
				var child:Lightning=childrenArray[0].instance;
				child.kill();
			}
		}
		public function generateChild(n:uint=1, recursive:Boolean=false):void {
			if(generation<childrenMaxGenerations && childrenArray.length<childrenMaxCount) {
				var targetChildSteps:uint=steps*childrenLengthDecay;
				if(targetChildSteps>=2) {
					for(var i:uint=0; i<n; i++) {
						var startStep:uint=Math.random()*steps;
						var endStep:uint=Math.random()*steps;
						while(endStep==startStep) endStep=Math.random()*steps;
						var childAngle:Number=Math.random()*childrenAngleVariation-childrenAngleVariation/2;
						
						var child:Lightning=new Lightning(color, thickness, generation+1);
						
						child.parentInstance=this;
						child.lifeSpan=Math.random()*(childrenLifeSpanMax-childrenLifeSpanMin)+childrenLifeSpanMin;
						child.position=1-startStep/steps;
						child.absolutePosition=absolutePosition*child.position;
						child.alphaFadeType=alphaFadeType;
						child.thicknessFadeType=thicknessFadeType;
						
						if(alphaFadeType==LightningFadeType.GENERATION) child.alpha=1-(1/(childrenMaxGenerations+1))*child.generation;
						if(thicknessFadeType==LightningFadeType.GENERATION) child.thickness=thickness-(thickness/(childrenMaxGenerations+1))*child.generation;
						child.childrenMaxGenerations=childrenMaxGenerations;
						child.childrenMaxCount=childrenMaxCount*(1-childrenMaxCountDecay);
						child.childrenProbability=childrenProbability*(1-childrenProbabilityDecay);
						child.childrenProbabilityDecay=childrenProbabilityDecay;
						child.childrenLengthDecay=childrenLengthDecay;
						child.childrenDetachedEnd=childrenDetachedEnd;
						
						child.wavelength=wavelength;
						child.amplitude=amplitude;
						child.speed=speed;
						
						child.init();
						
						childrenArray.push({instance:child, startStep:startStep, endStep:endStep, detachedEnd:childrenDetachedEnd, childAngle:childAngle});
						addChild(child);
						
						child.steps=steps*(1-childrenLengthDecay);
						if(recursive) child.generateChild(n, true);
					}
				}
			}
		}
		public function update():void {
			if(initialized) {
				
				dx=endX-startX;
				dy=endY-startY;
				len=Math.sqrt(dx*dx+dy*dy);
	
				soffs[0].x+=(steps/100)*speed;
				soffs[0].y+=(steps/100)*speed;
				sbd.perlinNoise(steps/20, steps/20, 1, seed1, false, true, 7, true, soffs);

				calculatedWavelength=steps*wavelength;
				calculatedSpeed=(calculatedWavelength*.1)*speed;
				boffs[0].x-=calculatedSpeed;
				boffs[0].y+=calculatedSpeed;
				bbd.perlinNoise(calculatedWavelength, calculatedWavelength, 1, seed2, false, true, 7, true, boffs);
				
				if(smoothPercentage>0) {
					var drawMatrix:Matrix=new Matrix();
					drawMatrix.scale(steps/smooth.width,1);
					bbd.draw(smooth, drawMatrix);
				}
				
				if(parentInstance!=null) {
					isVisible=parentInstance.isVisible;
				} else {
					if(maxLength==0) {
						isVisible=true;
					} else {
						var isVisibleProbability:Number;
						
						if(len<=maxLength) {
							isVisibleProbability=1;
						} else if(len>maxLength+maxLengthVary) {
							isVisibleProbability=0;
						} else {
							isVisibleProbability=1-(len-maxLength)/maxLengthVary;
						}
						
						isVisible=Math.random() < isVisibleProbability ? true : false;
					}
				}
				
				var generateChildRandom:Number=Math.random();
				if(generateChildRandom<childrenProbability) generateChild();
				
				if(isVisible) render();
				
				var childObject:Object;
				for each (childObject in childrenArray) {
					childObject.instance.update();
				}
			}
		}
		public function render():void {
			holder.graphics.clear();
			holder.graphics.lineStyle(thickness, _color);

			angle=Math.atan2(endY-startY, endX-startX);
			
			var childObject:Object;
						
			for (var i:uint=0; i<steps; i++) {
				var currentPosition:Number=1/steps*(steps-i)
				var relAlpha:Number=1;
				var relThickness:Number=thickness;

				if(alphaFadeType==LightningFadeType.TIP_TO_END) {						
					relAlpha=absolutePosition*currentPosition;
				}
				if(thicknessFadeType==LightningFadeType.TIP_TO_END) {						
					relThickness=thickness*(absolutePosition*currentPosition);
				}
				
				if(alphaFadeType==LightningFadeType.TIP_TO_END || thicknessFadeType==LightningFadeType.TIP_TO_END) {
					holder.graphics.lineStyle(int(relThickness), _color, relAlpha);
				}
				soff=(sbd.getPixel(i, 0)-0x808080)/0xffffff*len*multi2;
				soffx=Math.sin(angle)*soff;
				soffy=Math.cos(angle)*soff;

				boff=(bbd.getPixel(i, 0)-0x808080)/0xffffff*len*amplitude;
				boffx=Math.sin(angle)*boff;
				boffy=Math.cos(angle)*boff;

				tx=startX+dx/(steps-1)*i+soffx+boffx;
				ty=startY+dy/(steps-1)*i-soffy-boffy;
				
				if (i==0) holder.graphics.moveTo(tx, ty);
				holder.graphics.lineTo(tx, ty);
				
				
				for each (childObject in childrenArray) {
					if(childObject.startStep==i) {
						childObject.instance.startX=tx;
						childObject.instance.startY=ty;
					}
					if(childObject.detachedEnd) {
						var arad:Number=angle+childObject.childAngle/180*Math.PI;
						
						var childLength:Number=len*childrenLengthDecay;
						childObject.instance.endX=childObject.instance.startX+Math.cos(arad)*childLength;
						childObject.instance.endY=childObject.instance.startY+Math.sin(arad)*childLength;
					} else {
						if(childObject.endStep==i) {
							childObject.instance.endX=tx;
							childObject.instance.endY=ty;
						}
					}
				}
			}
		}
		public function killSurplus():void {
			while(childrenArray.length>childrenMaxCount) {
				var child:Lightning=childrenArray[childrenArray.length-1].instance;
				child.kill();
			}
		}
		public function set smoothPercentage(arg:Number):void {
			if(smooth) {
				_smoothPercentage=arg;
				
				var smoothmatrix:Matrix=new Matrix();
				smoothmatrix.createGradientBox(steps, 1);
				var ratioOffset:uint=_smoothPercentage/100*128;			
				
				smooth.graphics.clear();
				smooth.graphics.beginGradientFill("linear", [SMOOTH_COLOR, SMOOTH_COLOR, SMOOTH_COLOR, SMOOTH_COLOR], [1,0,0,1], [0,ratioOffset,255-ratioOffset,255], smoothmatrix);
				smooth.graphics.drawRect(0, 0, steps, 1);
				smooth.graphics.endFill();
			}
		}
		public function set childrenSmoothPercentage(arg:Number):void {
			_childrenSmoothPercentage=arg;
			
			var smoothmatrix:Matrix=new Matrix();
			smoothmatrix.createGradientBox(steps, 1);
			var ratioOffset:uint=_childrenSmoothPercentage/100*128;			
			
			childrenSmooth.graphics.clear();
			childrenSmooth.graphics.beginGradientFill("linear", [SMOOTH_COLOR, SMOOTH_COLOR, SMOOTH_COLOR, SMOOTH_COLOR], [1,0,0,1], [0,ratioOffset,255-ratioOffset,255], smoothmatrix);
			childrenSmooth.graphics.drawRect(0, 0, steps, 1);
			childrenSmooth.graphics.endFill();
		}
		public function get smoothPercentage():Number {
			return _smoothPercentage;
		}
		public function get childrenSmoothPercentage():Number {
			return _childrenSmoothPercentage;
		}
		public function set color(arg:uint):void {
			_color=arg;
			glow.color=arg;
			holder.filters=[glow];
			for each(var child:Object in childrenArray) child.instance.color=arg;
		}
		public function get color():uint {
			return _color;
		}
		public function set childrenProbability(arg:Number):void {
			if(arg>1) { arg=1 } else if(arg<0) arg=0;
			_childrenProbability=arg;
		}
		public function get childrenProbability():Number {
			return _childrenProbability;
		}
		public function set childrenProbabilityDecay(arg:Number):void {
			if(arg>1) { arg=1 } else if(arg<0) arg=0;
			_childrenProbabilityDecay=arg;
		}
		public function get childrenProbabilityDecay():Number {
			return _childrenProbabilityDecay;
		}
		public function set maxLength(arg:Number):void {
			_maxLength=arg;
		}
		public function get maxLength():Number {
			return _maxLength;
		}
		public function set maxLengthVary(arg:Number):void {
			_maxLengthVary=arg;
		}
		public function get maxLengthVary():Number {
			return _maxLengthVary;
		}
		public function set thickness(arg:Number):void {
			if(arg<0) arg=0;
			_thickness=arg;
		}
		public function get thickness():Number {
			return _thickness;
		}
		public function set thicknessDecay(arg:Number):void {
			if(arg>1) { arg=1 } else if(arg<0) arg=0;
			_thicknessDecay=arg;
		}
		public function get thicknessDecay():Number {
			return _thicknessDecay;
		}
		public function set childrenLengthDecay(arg:Number):void {
			if(arg>1) { arg=1 } else if(arg<0) arg=0;
			_childrenLengthDecay=arg;
		}
		public function get childrenLengthDecay():Number {
			return _childrenLengthDecay;
		}
		public function set childrenMaxGenerations(arg:uint):void {
			_childrenMaxGenerations=arg;
			killSurplus();
		}
		public function get childrenMaxGenerations():uint {
			return _childrenMaxGenerations;
		}
		
		public function set childrenMaxCount(arg:uint):void {
			_childrenMaxCount=arg;
			killSurplus();
		}
		public function get childrenMaxCount():uint {
			return _childrenMaxCount;
		}
		public function set childrenMaxCountDecay(arg:Number):void {
			if(arg>1) { arg=1 } else if(arg<0) arg=0;
			_childrenMaxCountDecay=arg;
		}
		public function get childrenMaxCountDecay():Number {
			return _childrenMaxCountDecay;
		}
		public function set childrenAngleVariation(arg:Number):void {
			_childrenAngleVariation=arg;
			for each(var o:Object in childrenArray) {
				o.childAngle=Math.random()*arg-arg/2;
				o.instance.childrenAngleVariation=arg;
			}
		}
		public function get childrenAngleVariation():Number {
			return _childrenAngleVariation;
		}
		public function set childrenLifeSpanMin(arg:Number):void {
			_childrenLifeSpanMin=arg;
		}
		public function get childrenLifeSpanMin():Number {
			return _childrenLifeSpanMin;
		}
		public function set childrenLifeSpanMax(arg:Number):void {
			_childrenLifeSpanMax=arg;
		}
		public function get childrenLifeSpanMax():Number {
			return _childrenLifeSpanMax;
		}
		public function set childrenDetachedEnd(arg:Boolean):void {
			_childrenDetachedEnd=arg;
		}
		public function get childrenDetachedEnd():Boolean {
			return _childrenDetachedEnd;
		}
		public function set wavelength(arg:Number):void {
			_wavelength=arg;
			for each(var o:Object in childrenArray) {
				o.instance.wavelength=arg;
			}
		}
		public function get wavelength():Number {
			return _wavelength;
		}
		public function set amplitude(arg:Number):void {
			_amplitude=arg;
			for each(var o:Object in childrenArray) {
				o.instance.amplitude=arg;
			}
		}
		public function get amplitude():Number {
			return _amplitude;
		}
		public function set speed(arg:Number):void {
			_speed=arg;
			for each(var o:Object in childrenArray) {
				o.instance.speed=arg;
			}
		}
		public function get speed():Number {
			return _speed;
		}
		public function set isVisible(arg:Boolean):void {
			_isVisible=visible=arg;
		}
		public function get isVisible():Boolean {
			return _isVisible;
		}
	}
}






