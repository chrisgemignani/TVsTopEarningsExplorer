package
{
	import mx.collections.ArrayCollection;
	
	import org.juicekit.animate.Easing;
	import org.juicekit.animate.Transitioner;
	import org.juicekit.collections.StatsArrayCollection;
	import org.juicekit.util.Arrays;
	import org.juicekit.util.Maths;
	import org.juicekit.util.Property;
	import org.juicekit.util.Stats;
	
	import sparkflare.mappers.MapperBase;
	
	public class BubbleLayout extends MapperBase
	{
		
		//------------------------------------------------------------
		//
		// Properties
		//
		//------------------------------------------------------------
		
		/**
		 * the maxium radius the items can be sized to
		 */
		[Bindable] public var maxRadius:int = 100;
		
		/**
		 * the padding between the bubbles
		 */
		[Bindable] public var bpadding:int = 10;
		
		/**
		 * the property of the data that will be used to
		 * size the bubbles
		 */
		[Bindable] public var sizeField:String;
		
		[Bindable] public var groupbyField:String;
		
		[Bindable] public var binProvider:Array;
		
		/**
		 * the width of the bin the items will
		 * be placed in
		 */
		public var binHeight:int = 600;
		
		
		public function BubbleLayout()
		{
			super();
		}
		
		
		
		override public function operate(items:ArrayCollection, t:Transitioner=null, visualElementProperty:String=null):void
		{
			var row:Object;
			var _t:Transitioner;
			
			if (enabled) {
				_t = (t != null ? t : Transitioner.DEFAULT);
				//_t.easing = Easing.easeOutExpo;
				
				if (items)
				{
					var allGroups:Array = new Array();
					var maxSize:Number = Number.NEGATIVE_INFINITY;
					var sizeProp:Property = Property.$(sizeField);
					var groupProp:Property = Property.$(groupbyField);
					
					for each (row in items) {
						var group:String = groupProp.getValue(row);
						var size:Number = sizeProp.getValue(row);
						
						maxSize = Math.max(maxSize, size);
						
						if(!allGroups[group]) {
							allGroups[group] = new Array();
						}
						allGroups[group].push(row);
					}
					
					var pos:int = 0;
					var bins:Array = new Array;
					if(binProvider) {
						var field:String = groupbyField.replace('data.','');
						bins = binProvider[field];
					}
					for each (var o:Object in bins) {
						var groupings:Array = allGroups[o.group];
						for each (row in groupings) {
							_t.setValue(row, 'size', maxRadius * Math.sqrt(sizeProp.getValue(row) / maxSize));
						}
						layoutBin2(o.bubblexPos, groupings, _t, maxSize, o.width);
						//layoutBin3(o.bubblexPos, groupings, _t, maxSize, o.width);
					}
				}
				
			}
			
		}

		private function layoutBin2(bubblexPos:int, binArray:Array, _t:Transitioner, maxSize:Number, binWidth:Number):void
		{
			var row:Object
			var above:Array = [];
			for each (row in binArray) 
			{
				var minVal:Number = bubblexPos + bpadding + _t.$(row)['size']/2;
				var maxVal:Number = bubblexPos + binWidth - bpadding - _t.$(row)['size']/2;
				
				var hasOverlap:Boolean = true;
				var iters:int = 0;
				while (hasOverlap && iters < 10) 
				{
					hasOverlap = false;
					_t.setValue(row, 'x', minVal + Math.random()*(maxVal - minVal));
					
					for each (var otherRow:Object in above) {
						if (overlaps(_t, row, otherRow))
						{
							hasOverlap = true;
							break;
						}
					} 
					iters += 1;
				}
				above.push(row);
			}
		}
		
		private function overlaps(_t:Transitioner, thisRow:Object, otherRow:Object):Boolean {
			var thisx:Number = _t.$(thisRow)['x']; 
			var thisy:Number = _t.$(thisRow)['y']; 
			var otherx:Number = _t.$(otherRow)['x']; 
			var othery:Number = _t.$(otherRow)['y']; 
			var dist:Number = Math.sqrt( (thisx - otherx)*(thisx - otherx) + (thisy - othery)*(thisy - othery) );
			return (dist + 5) < (_t.$(thisRow)['size'] + _t.$(otherRow)['size'])/2;
		}

		private function dist(_t:Transitioner, thisRow:Object, otherRow:Object):Number {
			var thisx:Number = _t.$(thisRow)['x']; 
			var thisy:Number = _t.$(thisRow)['y']; 
			var otherx:Number = _t.$(otherRow)['x']; 
			var othery:Number = _t.$(otherRow)['y']; 
			return Math.sqrt( (thisx - otherx)*(thisx - otherx) + (thisy - othery)*(thisy - othery) );
		}
		
		private function layoutBin3(bubblexPos:int, binArray:Array, _t:Transitioner, maxSize:Number, binWidth:int):void
		{
			var row:Object;
			var percent:Number = 0;
			var totalPercent:Number = 0;
			var thisY:Number = 0;
			var prevY:Number = Number.NaN;
			var thisLevel:Array = [];
			var totalSizes:Number = 0;
			var allLevels:Array = [];
			var lvl:int = 0;
			var i:int = 0;
			for each (row in binArray) {
				thisY = _t.$(row)['y'];
				percent = Math.random();
				if(thisY == prevY) {
					thisLevel[lvl-1].push({'r': _t.$(row)['size'], 'pct': percent, 'lvl': lvl-1, 'index': i});
					allLevels[lvl-1]['totalPercent'] += percent;
					allLevels[lvl-1]['totalSizes'] += _t.$(row)['size'];
					allLevels[lvl-1]['num'] += 1;
				}else {
					thisLevel[lvl] = [];
					thisLevel[lvl].push({'r': _t.$(row)['size'], 'pct': percent, 'lvl': lvl, 'index': i});
					allLevels[lvl] = {'totalPercent': percent, 'totalSizes': _t.$(row)['size'], 'num': 1}
					allLevels[lvl]['totalPercent'] += Math.random();
					lvl++;
				}
				prevY = thisY;
				i++;
			}
			
			var xJitter:Number;
			var x:int;
			var c:int = 1;
			for each(var level:Array in thisLevel) {
				for (var index:String in level)
				{
					var o:Object = level[index];
					var minVal:Number = bubblexPos + bpadding + o.r/2;
					var maxVal:Number = bubblexPos + binWidth - bpadding - o.r/2;
					row = binArray[o.index];
						
					if(level.length == 1) {
						x = randomInRange(minVal, maxVal);
						xJitter = 0;
					} else {
						var totalXJitter:Number = binWidth - allLevels[o.lvl]['totalSizes'] - ((level.length+1) * bpadding);
						if (totalXJitter > 0) {
							xJitter = Math.floor((o.pct / allLevels[o.lvl]['totalPercent']) * totalXJitter);
						}else {
							xJitter = 0;
						}
						
						if (int(index) > 1) {
							x += o.r + bpadding; 
							if (x >= binWidth) {
								x = randomInRange(minVal, maxVal);
								xJitter = 0;
							}
						} else {
							x = bubblexPos + bpadding + o.r/2;
						}
					}
					_t.setValue(row, 'x', x+xJitter);	
				}
			}

		}

		/*
		private function layoutBin(bubblexPos:int, binArray:Array, _t:Transitioner, maxSize:Number, binWidth:int):void
		{
			if(binArray.length == 0) {
				return;
			}
			
			// Calculate size of the bubbles
			var r:int;
			var totalSizes:Number = 0;
			var percent:Number = 0;
			var totalPercent:Number = 0;
			var row:Object;
			var binMap:Array = new Array();
			var sizeProp:Property = Property.$(sizeField);
			
			for each (row in binArray) {
				trace(sizeProp.getValue(row));
				r = maxRadius * Math.sqrt(sizeProp.getValue(row) / maxSize);
				percent = Math.random();
				binMap.push({'r': r, 'pct': percent});
				totalSizes += r;
				totalPercent += percent;
			}
			totalPercent += Math.random();
			
			//binMap.sortOn('r', Array.DESCENDING | Array.NUMERIC);
			
			// Amount it can vary in xyexcluding {bpadding}px margins on top and bottom
			// And the inter-circle gaps
			var totalYJitter:Number = binHeight - totalSizes - ((binArray.length+1) * bpadding);
			
			//layout bubbles
			var x:int; var y:int;
			//x = binPosition * binWidth + 10;
			x = bubblexPos + 10;
			y = 10;
			var o:Object;
			var thisY:Number = 0;
			var prevY:Number = Number.NaN;
			for (var index:String in binMap) {
				row = binArray[index];
				o = binMap[index];
				
				//the yJitter for each bubble is calculated as percent of the totalYJitter
				var yJitter:Number = Math.floor((o.pct / totalPercent) * totalYJitter);
				
				thisY = _t.$(row)['y'];
				
				//_t.setValue(row, 'y', _t.$(row)['y'] + Math.random()*20 - 10);
				//_t.setValue(row, 'y', y + yJitter);
				
				// Amount it can vary in x excluding {bpadding}px margins on left and right
				
//				var xJitter:Number = (binWidth - 10) - o.r - (2*bpadding);
//				_t.setValue(row, 'x', x + randomInRange(0, xJitter));
				_t.setValue(row, 'x', x);
				
				_t.setValue(row, 'size', o.r);
				
				//y += o.r + bpadding + yJitter;
				if (thisY == prevY) {
					x += o.r + bpadding;
				}else {
					//x = binPosition * binWidth + 10;
					x = bubblexPos + 10;
				}
				
				prevY = thisY;
			}
		}
		*/
		
		private function randomInRange(low:Number, high:Number):Number
		{
			return Math.floor(Math.random() * (high - low)) + low;
		}
		
	}
}