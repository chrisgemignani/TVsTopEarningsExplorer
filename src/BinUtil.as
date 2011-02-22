package
{
	import mx.collections.ArrayCollection;
	
	import org.juicekit.query.Query;
	import org.juicekit.query.methods.*;
	import org.juicekit.util.Sort;

	public class BinUtil
	{
		private var _actors:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var groupings:Array = ['showType', 'gender', 'networkTop5', 'seasonBin', 'ratingBin'];
		
		[Bindable]
		public var groupingLabels:ArrayCollection = new ArrayCollection(['Show type', 'Gender', 'Network', 'Seasons on air', 'IMBD Rating']);
		
		[Bindable]
		public var colorings:Array = ['gender', 'networkTop5'];
		
		[Bindable]
		public var coloringLabels:ArrayCollection = new ArrayCollection(['Gender', 'Network']);
		
		public var positionOrdering:Object = {
			'seasonBin': ['1-2', '3-6', '7+'],		
			'ratingBin': ['<7.5', '7.5-8.5', '8.5+']		
		};
		
		
		[Bindable]public var allGroupings:Array = new Array();
		
		public function BinUtil(actors:ArrayCollection)
		{
			_actors = actors;
			initializeAllGroupings();
		}
		
		private function initializeAllGroupings():void
		{
			const totalWidth:Number = 800;
			const gap:Number = 10;
			
			function calculateGroup(group:String):void {
				var ttlPay:Number = select({ttlPay: sum('pay')}).eval(_actors.source)[0]['ttlPay'];
				var r:Array = select({
					'group': group,
					'averagePay': average('pay'),
					'pctPay': div(sum('pay'), ttlPay)				
				}).groupby(group).eval(_actors.source);
				
				var numGroups:int = r.length;
				var pos:int = 1;
				r.sort(Sort.$(['-pctPay']));
				
				// Override sorting if the group is in position lookup
				if (positionOrdering.hasOwnProperty(group)) {
					var positions:Array = positionOrdering[group];
					for each (var o:Object in r) {
						// re-establish all positions
						o.pos = positions.indexOf(o.group);
					}
					// resort on positions
					r.sort(Sort.$(['pos']));
				}
				
				var bubblexPos:Number = 0;
				var usableWidth:Number = (totalWidth - (numGroups-1)*gap);
				for each (var o:Object in r) {
					trace(o.group);
					o.width = usableWidth * o.pctPay;
					o.pos = pos;
					o.bubblexPos = bubblexPos;
					bubblexPos += o.width + gap;
					pos += 1;
				}
				allGroupings[group] = r;
				
				// Now calculate the positions for adding Gender as a dimension
				
				var positionLookup:Object = {};
				for each (o in allGroupings[group]) {
					positionLookup[o.group + '|Male'] = o.pos + 0;
					positionLookup[o.group + '|Female'] = o.pos + .1;
				}
				
				r = select({
					'group': group,
					'gender': 'gender',
					'averagePay': average('pay'),
					'pctPay': div(sum('pay'), ttlPay)				
				}).groupby(group, 'gender').eval(_actors.source);

				for each (o in r) {
					o.pos = positionLookup[o.group + '|' + o.gender];
				}
				r.sort(Sort.$(['pos']));
				
				bubblexPos = 0;
				var prevObj:Object;
				for each (o in r) {
					o.width = usableWidth * o.pctPay;
					o.bubblexPos = bubblexPos;
//					if (prevObj != null && o.group != prevObj.group) 
//					if (o.gender == 'Male' && prevObj)
//						o.bubblexPos += gap;
					bubblexPos += o.width;
					prevObj = o;
				}
				allGroupings[group + 'Gender'] = r;
			}


			for each (var group:String in groupings) {
				calculateGroup(group);
			}
		}
		
	}
}