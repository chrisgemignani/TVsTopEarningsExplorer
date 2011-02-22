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
		
		[Bindable] public var bin:Object;
		
		/**
		 * the width of the bin the items will
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
				//_t.easing = Easing.easeOutExpo;
				
				if (items)
				{
					var allGroups:Array = new Array();
					var maxSize:Number = Number.NEGATIVE_INFINITY;
					var sizeProp:Property = Property.$(sizeField);
					var groupProp:Property = Property.$(groupbyField);
					
					layoutBin2(bin.bubblexPos, items, _t, bin.width);
				}
				
			}
			
		}
		
		private function layoutBin2(bubblexPos:int, binArray:ArrayCollection, _t:Transitioner, binWidth:Number):void
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
			
		private function randomInRange(low:Number, high:Number):Number
		{
			return Math.floor(Math.random() * (high - low)) + low;
		}
		
	}
}