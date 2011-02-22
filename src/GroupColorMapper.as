package
{
	import mx.collections.ArrayCollection;
	
	import org.juicekit.animate.Transitioner;
	import org.juicekit.util.Arrays;
	import org.juicekit.util.Property;
	
	import sparkflare.mappers.MapperBase;
	
	public class GroupColorMapper extends MapperBase
	{
		
		//------------------------------------------------------------
		//
		// Properties
		//
		//------------------------------------------------------------
		
		/**
		 * the property of the data that will be used to
		 * size the bubbles
		 */

		[Bindable] public var groupField:String = 'gender';

		public function GroupColorMapper()
		{
			super();
		}
		
		public var defaultColor:uint = 0x666666;
		public var genderLookup:Object = {'Male': 0x0033cc, 'Female': 0xff6666 };
		public var networkLookup:Object = {'CBS': 0x4684ee, 'NBC': 0x008000, 'Fox': 0x4942cc, 'ABC': 0xff9900, 'Cable': 0xdc3912 };
		
		private function colorLookup(val:String):uint {
			if (groupField == 'gender') 
			{
				return genderLookup[val] ? genderLookup[val] : defaultColor;
			} 
			else if (groupField == 'networkTop5')
			{
				return networkLookup[val] ? networkLookup[val] : defaultColor;
			} 
			else 
			{
				return defaultColor;
			}
		}
		
		override public function operate(items:ArrayCollection, t:Transitioner=null, visualElementProperty:String=null):void
		{
			var row:Object;
			var _t:Transitioner;
			
			if (enabled) {
				_t = (t != null ? t : Transitioner.DEFAULT);
				if (items)
				{
					var groupProp:Property = Property.$('data.'+groupField);
					
					for each (row in items) {
						var group:String = groupProp.getValue(row);
						var clr:uint = colorLookup(group);
						_t.setValue(row, 'entry.color', clr);
					}
				}
				
			}
			
		}

	}
}