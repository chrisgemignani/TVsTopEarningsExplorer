package
{
	import mx.core.IToolTip;
	import mx.events.FlexEvent;
	
	import spark.components.SkinnableContainer;
	import models.Actor;

	
	public class ActorToolTip extends SkinnableContainer implements IToolTip
	{
		public function ActorToolTip()
		{
			super();
			addHandler();
		}
		
		public var _text:String;
		
		public function get text():String
		{
			//return null;
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;
		}
		
		private var _actor:Actor;
		
		[Bindable]
		public function get actor():Actor
		{
			return _actor;
		}
		
		[Bindable]
		public function set actor(value:Actor):void
		{
			_actor = value;
			var n:String = _actor.name;
			n = n.replace(/[^a-zA-Z]/,'');
			n = n.replace(/[.'\s]+/,'');
			trace(n);
			//changeState(n.toLowerCase());
			//actorImage = (Math.random() < 0.5) ? ActorToolTip.CharlieSheenImage : ActorToolTip.AdrianGrenierImage; 
			actorImage = this[n + 'Image'];
		}
		
		[Bindable] public var actorImage;
		
		[Embed(source='../resources/images/actors/AdrianGrenier.jpg')] public var AdrianGrenierImage:Class;
		[Embed(source='../resources/images/actors/AlexOLoughlin.jpg')] public var AlexOLoughlinImage:Class;
		[Embed(source='../resources/images/actors/Angie.jpg')] public var AngieImage:Class;
		[Embed(source='../resources/images/actors/AngieHarmon.jpg')] public var AngieHarmonImage:Class;
		[Embed(source='../resources/images/actors/AngusTJones.jpg')] public var AngusTJonesImage:Class;
		[Embed(source='../resources/images/actors/AnnaPaquin.jpg')] public var AnnaPaquinImage:Class;
		[Embed(source='../resources/images/actors/AshleyTisdale.jpg')] public var AshleyTisdaleImage:Class;
		[Embed(source='../resources/images/actors/BettyWhite.jpg')] public var BettyWhiteImage:Class;
		[Embed(source='../resources/images/actors/BlairUnderwood.jpg')] public var BlairUnderwoodImage:Class;
		[Embed(source='../resources/images/actors/CharlieSheen.jpg')] public var CharlieSheenImage:Class;
		[Embed(source='../resources/images/actors/ChrisODonnell.jpg')] public var ChrisODonnellImage:Class;
		[Embed(source='../resources/images/actors/ChristopherMeloni.jpg')] public var ChristopherMeloniImage:Class;
		[Embed(source='../resources/images/actors/ColeHauser.jpg')] public var ColeHauserImage:Class;
		[Embed(source='../resources/images/actors/ColeSprouse.jpg')] public var ColeSprouseImage:Class;
		[Embed(source='../resources/images/actors/DanaDelany.jpg')] public var DanaDelanyImage:Class;
		[Embed(source='../resources/images/actors/DanCastellaneta.jpg')] public var DanCastellanetaImage:Class;
		[Embed(source='../resources/images/actors/DavidBoreanaz.jpg')] public var DavidBoreanazImage:Class;
		[Embed(source='../resources/images/actors/DavidCaruso.jpg')] public var DavidCarusoImage:Class;
		[Embed(source='../resources/images/actors/DavidDuchovny.jpg')] public var DavidDuchovnyImage:Class;
		[Embed(source='../resources/images/actors/DavidSpade.jpg')] public var DavidSpadeImage:Class;
		[Embed(source='../resources/images/actors/DenisLeary.jpg')] public var DenisLearyImage:Class;
		[Embed(source='../resources/images/actors/DylanSprouse.jpg')] public var DylanSprouseImage:Class;
		[Embed(source='../resources/images/actors/EdieFalco.jpg')] public var EdieFalcoImage:Class;
		[Embed(source='../resources/images/actors/EdONeill.jpg')] public var EdONeillImage:Class;
		[Embed(source='../resources/images/actors/EvaLongoria.jpg')] public var EvaLongoriaImage:Class;
		[Embed(source='../resources/images/actors/FelicityHuffman.jpg')] public var FelicityHuffmanImage:Class;
		[Embed(source='../resources/images/actors/GarySinise.jpg')] public var GarySiniseImage:Class;
		[Embed(source='../resources/images/actors/HughLaurie.jpg')] public var HughLaurieImage:Class;
		[Embed(source='../resources/images/actors/IanSomerhalder.jpg')] public var IanSomerhalderImage:Class;
		[Embed(source='../resources/images/actors/JadaPinkettSmith.jpg')] public var JadaPinkettSmithImage:Class;
		[Embed(source='../resources/images/actors/JaneLynch.jpg')] public var JaneLynchImage:Class;
		[Embed(source='../resources/images/actors/JasonLee.jpg')] public var JasonLeeImage:Class;
		[Embed(source='../resources/images/actors/JeffreyDonovan.jpg')] public var JeffreyDonovanImage:Class;
		[Embed(source='../resources/images/actors/JeremyPiven.jpg')] public var JeremyPivenImage:Class;
		[Embed(source='../resources/images/actors/JimmySmits.jpg')] public var JimmySmitsImage:Class;
		[Embed(source='../resources/images/actors/JimParsons.jpg')] public var JimParsonsImage:Class;
		[Embed(source='../resources/images/actors/JoeMantegna.jpg')] public var JoeMantegnaImage:Class;
		[Embed(source='../resources/images/actors/JohnnyGalecki.jpg')] public var JohnnyGaleckiImage:Class;
		[Embed(source='../resources/images/actors/JonCryer.jpg')] public var JonCryerImage:Class;
		[Embed(source='../resources/images/actors/JonHamm.jpg')] public var JonHammImage:Class;
		[Embed(source='../resources/images/actors/JuliannaMargulies.jpg')] public var JuliannaMarguliesImage:Class;
		[Embed(source='../resources/images/actors/JulieKavner.jpg')] public var JulieKavnerImage:Class;
		[Embed(source='../resources/images/actors/KaleyCuoco.jpg')] public var KaleyCuocoImage:Class;
		[Embed(source='../resources/images/actors/KevinDillon.jpg')] public var KevinDillonImage:Class;
		[Embed(source='../resources/images/actors/KyraSedgwick.jpg')] public var KyraSedgwickImage:Class;
		[Embed(source='../resources/images/actors/LaurenceFishburne.jpg')] public var LaurenceFishburneImage:Class;
		[Embed(source='../resources/images/actors/LaurenGraham.jpg')] public var LaurenGrahamImage:Class;
		[Embed(source='../resources/images/actors/LLCoolJ.jpg')] public var LLCoolJImage:Class;
		[Embed(source='../resources/images/actors/MarciaCross.jpg')] public var MarciaCrossImage:Class;
		[Embed(source='../resources/images/actors/MargHelgenberger.jpg')] public var MargHelgenbergerImage:Class;
		[Embed(source='../resources/images/actors/MariskaHargitay.jpg')] public var MariskaHargitayImage:Class;
		[Embed(source='../resources/images/actors/MarkFeuerstein.jpg')] public var MarkFeuersteinImage:Class;
		[Embed(source='../resources/images/actors/MarkHarmon.jpg')] public var MarkHarmonImage:Class;
		[Embed(source='../resources/images/actors/MattBomer.jpg')] public var MattBomerImage:Class;
		[Embed(source='../resources/images/actors/MatthewMorrison.jpg')] public var MatthewMorrisonImage:Class;
		[Embed(source='../resources/images/actors/MichaelWeatherly.jpg')] public var MichaelWeatherlyImage:Class;
		[Embed(source='../resources/images/actors/MirandaCosgrove.jpg')] public var MirandaCosgroveImage:Class;
		[Embed(source='../resources/images/actors/NathanFillion.jpg')] public var NathanFillionImage:Class;
		[Embed(source='../resources/images/actors/PatrickDempsey.jpg')] public var PatrickDempseyImage:Class;
		[Embed(source='../resources/images/actors/PatrickWarburton.jpg')] public var PatrickWarburtonImage:Class;
		[Embed(source='../resources/images/actors/RicoRodriguez.jpg')] public var RicoRodriguezImage:Class;
		[Embed(source='../resources/images/actors/ScottCaan.jpg')] public var ScottCaanImage:Class;
		[Embed(source='../resources/images/actors/SelenaGomez.jpg')] public var SelenaGomezImage:Class;
		[Embed(source='../resources/images/actors/ShaileneWoodley.jpg')] public var ShaileneWoodleyImage:Class;
		[Embed(source='../resources/images/actors/SteveCarell.jpg')] public var SteveCarellImage:Class;
		[Embed(source='../resources/images/actors/TeriHatcher.jpg')] public var TeriHatcherImage:Class;
		[Embed(source='../resources/images/actors/ThomasGibson.jpg')] public var ThomasGibsonImage:Class;
		[Embed(source='../resources/images/actors/TimothyOlyphant.jpg')] public var TimothyOlyphantImage:Class;
		[Embed(source='../resources/images/actors/TinaFey.jpg')] public var TinaFeyImage:Class;
		[Embed(source='../resources/images/actors/TomSelleck.jpg')] public var TomSelleckImage:Class;
		[Embed(source='../resources/images/actors/TyBurrell.jpg')] public var TyBurrellImage:Class;
		[Embed(source='../resources/images/actors/WilliamShatner.jpg')] public var WilliamShatnerImage:Class;
		[Embed(source='../resources/images/actors/ZacharyLevi.jpg')] public var ZacharyLeviImage:Class;
		
		
		public var _actorName:String;
		
		public function get actorName():String
		{
			return _actorName;
		}
		
		public function set actorName(value:String):void
		{
			_actorName = value;
			if (_actorName != ''){
				changeState(_actorName);
			}else {
				changeState('normal');
			}
		}
		
		private var _curState:String;
		
		
		protected function addHandler():void
		{
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		protected function creationCompleteHandler(event:FlexEvent):void
		{
			this.setStyle('skinClass',ActorToolTipSkin);
		}
		
		private function changeState(state:String):void
		{
			_curState = state;
			invalidateSkinState();
		}
		
		override protected function getCurrentSkinState():String
		{
			if(_curState != '')
				return _curState;
			else
				return super.getCurrentSkinState();
		}
	}
}