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
	
	public class SingleBinBubbleLayout extends MapperBase
	{
		
		//------------------------------------------------------------
		//
		// Properties
		//
		//------------------------------------------------------------
		
		/**
		 * the padding on either side of the bin
		 */
		[Bindable] public var bpadding:int = 0;
		

        [Bindable] public var bin:Object;
		
		/**
		 * the height of the bin the items will
		 * be placed in
		 */
		public var binHeight:int = 600;
		
		
		public function SingleBinBubbleLayout()
		{
			super();
		}
		
		
		
		override public function operate(items:ArrayCollection, t:Transitioner=null, visualElementProperty:String=null):void
		{
			var row:Object;
			var _t:Transitioner;
			
			if (enabled) {
				_t = (t != null ? t : Transitioner.DEFAULT);
				
				if (items)
				{
					layoutBin(bin.bubblexPos, bin.width, items, _t);
				}
				
			}
			
		}
		
		private function layoutBin(bubblexPos:int, binWidth:Number, bubbleArray:ArrayCollection, _t:Transitioner):void
		{
			var bubble:Object;
			var above:Array = [];
			for each (bubble in bubbleArray) 
			{
				var minVal:Number = bubblexPos + bpadding + _t.$(bubble)['size']/2;
				var maxVal:Number = bubblexPos + binWidth - bpadding - _t.$(bubble)['size']/2;
				
				var hasOverlap:Boolean = true;
				var iters:int = 0;
				while (hasOverlap && iters < 10) 
				{
					hasOverlap = false;
					_t.setValue(bubble, 'x', randomInRange(minVal, maxVal));
					
					for each (var otherRow:Object in above) {
						if (overlaps(_t, bubble, otherRow))
						{
							hasOverlap = true;
							break;
						}
					} 
					iters += 1;
				}
				above.push(bubble);
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
			
		private function randomInRange(low:Number, high:Number):Number
		{
			return Math.floor(Math.random() * (high - low)) + low;
		}
		
	}
}