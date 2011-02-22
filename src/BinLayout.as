package
{
	import mx.collections.ArrayCollection;
	
	import org.juicekit.animate.Transitioner;
	
	import sparkflare.mappers.MapperBase;
	
	public class BinLayout extends MapperBase
	{
		public var totalWidth:int = 880;
		
		[Bindable] public var binPadding:int = 10;
		
		public function BinLayout()
		{
			super();
		}
		
		override public function operate(items:ArrayCollection, t:Transitioner=null, visualElementProperty:String=null):void
		{
			var row:Object;
			var _t:Transitioner;
			
			if (enabled) {
				_t = (t != null ? t : Transitioner.DEFAULT);
				if (items) {
					var x:int = 0;
					var w:int = 0;
					for each (row in items)
					{
						w = row.data.width;
						x = row.data.bubblexPos;
						_t.setValue(row, 'x', x);
						_t.setValue(row, 'w', w);
						//x += (w + binPadding);
					}
				}
			}
			
		}
		
	}
}