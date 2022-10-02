--------------------------------------------------------------
-- Dummies for Natural Wonders
-- May 11, 2020: Created, adan_eslavo
--============================================--
-- PROMOTIONS
--============================================--
INSERT INTO Language_en_US 
			(Tag,										Text) 
VALUES		('TXT_KEY_PROMOTION_KAILASH',				'Mahaprasthanika Parva'),
			('TXT_KEY_PROMOTION_KAILASH_HELP',			'Double[ICON_MOVES]Movement [COLOR:255:230:85:255]on Hills[ENDCOLOR].'),
			('TXT_KEY_PROMOTION_ULURU',					'Old Tribes'),
			('TXT_KEY_PROMOTION_ULURU_HELP',			'+10 [ICON_INFLUENCE] Influence [COLOR:255:230:85:255]after Diplomatic Mission[ENDCOLOR].'),
			('TXT_KEY_PROMOTION_SOLOMONS_MINES',		'For the King!'),
			('TXT_KEY_PROMOTION_SOLOMONS_MINES_HELP',	'+25% [ICON_WORKER] Work Rate.'),	
			('TXT_KEY_PROMOTION_BERMUDA_TRIANGLE',		'Lost in Time and Space'),
			('TXT_KEY_PROMOTION_BERMUDA_TRIANGLE_HELP',	'-3[ICON_MOVES] Movement Points. [COLOR_NEGATIVE_TEXT]Promotion lasts 3 turns[ENDCOLOR].'),
			('TXT_KEY_PROMOTION_DALLOL',				'Explosive Mixture'),
			('TXT_KEY_PROMOTION_DALLOL_HELP',			'+10%[ICON_RANGE_STRENGTH]RCS.');

INSERT INTO UnitPromotions 
			(Type,							Description,							Help,										Sound,				CannotBeChosen, LostWithUpgrade,	RangedAttackModifier,	DiploMissionInfluence,	WorkRateMod,	MovesChange,	ExtraNavalMovement,	PromotionDuration,	PortraitIndex,	IconAtlas,						PediaType,			PediaEntry) 
VALUES		('PROMOTION_KAILASH',			'TXT_KEY_PROMOTION_KAILASH',			'TXT_KEY_PROMOTION_KAILASH_HELP',			'AS2D_IF_LEVELUP',	1,				0,					0,						0,						0,				0,				0,					0,					12,				'promoVP_atlas_03',				'PEDIA_CIVILIAN',	'TXT_KEY_PROMOTION_KAILASH'),
			('PROMOTION_ULURU',				'TXT_KEY_PROMOTION_ULURU',				'TXT_KEY_PROMOTION_ULURU_HELP',				'AS2D_IF_LEVELUP',	1,				0,					0,						10,						0,				0,				0,					0,					8,				'PROMOTION_MORE_WONDERS_ATLAS',	'PEDIA_DIPLO',		'TXT_KEY_PROMOTION_ULURU'),
			('PROMOTION_SOLOMONS_MINES',	'TXT_KEY_PROMOTION_SOLOMONS_MINES',		'TXT_KEY_PROMOTION_SOLOMONS_MINES_HELP',	'AS2D_IF_LEVELUP',	1,				0,					0,						0,						25,				0,				0,					0,					4,				'PROMOTION_MORE_WONDERS_ATLAS',	'PEDIA_CIVILIAN',	'TXT_KEY_PROMOTION_SOLOMONS_MINES'),
			('PROMOTION_BERMUDA_TRIANGLE',	'TXT_KEY_PROMOTION_BERMUDA_TRIANGLE',	'TXT_KEY_PROMOTION_BERMUDA_TRIANGLE_HELP',	'AS2D_IF_LEVELUP',	1,				0,					0,						0,						0,				0,				-3,					3,					9,				'PROMOTION_MORE_WONDERS_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_BERMUDA_TRIANGLE'),
			('PROMOTION_DALLOL',			'TXT_KEY_PROMOTION_DALLOL',				'TXT_KEY_PROMOTION_DALLOL_HELP',			'AS2D_IF_LEVELUP',	1,				0,					10,						0,						0,				0,				0,					0,					10,				'PROMOTION_MORE_WONDERS_ATLAS',	'PEDIA_SIEGE',		'TXT_KEY_PROMOTION_DALLOL');

INSERT INTO UnitPromotions_Terrains
			(PromotionType,			TerrainType,	DoubleMove)
VALUES		('PROMOTION_KAILASH',	'TERRAIN_HILL',	1);

DELETE FROM UnitPromotions_UnitCombats WHERE PromotionType = 'PROMOTION_ALTITUDE_TRAINING';

INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,					UnitCombatType)
VALUES		('PROMOTION_KAILASH',			'UNITCOMBAT_MISSIONARY'),
			('PROMOTION_ULURU',				'UNITCOMBAT_DIPLOMACY'),
			('PROMOTION_SOLOMONS_MINES',	'UNITCOMBAT_WORKER'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_NAVALMELEE'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_NAVALRANGED'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_SUBMARINE'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_CARRIER'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_CARGO'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_WORKBOAT'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_MELEE'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_RECON'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_ARCHER'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_MOUNTED'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_SIEGE'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_GUN'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_ARMOR'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_DIPLOMACY'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_MISSIONARY'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_INQUISITOR'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_SETTLER'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_WORKER'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_SPECIAL_PEOPLE'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_SPACESHIP_PART'),
			('PROMOTION_BERMUDA_TRIANGLE',	'UNITCOMBAT_ARCHAEOLOGIST'),
			('PROMOTION_DALLOL',			'UNITCOMBAT_SIEGE'),
			('PROMOTION_ALTITUDE_TRAINING',	'UNITCOMBAT_RECON');

UPDATE UnitPromotions SET VisibilityChange = 1 WHERE Type = 'PROMOTION_ALTITUDE_TRAINING';

UPDATE Language_en_US SET Text = '+1[ICON_VIEW_CITY]Sight. '||Text WHERE Tag = 'TXT_KEY_PROMOTION_ALTITUDE_TRAINING_HELP';
--============================================--
-- RESOURCES
--============================================--			
INSERT INTO Language_en_US 
			(Tag,										Text) 
VALUES		('TXT_KEY_RESOURCE_SYLVITE',				'Sylvite'),
			('TXT_KEY_RESOURCE_SYLVITE_TEXT',			'TODO'),
			('TXT_KEY_RESOURCE_MONOPOLY_SYLVITE',		'[COLOR_POSITIVE_TEXT]Monopoly Bonus:[ENDCOLOR] Promotion [COLOR_POSITIVE_TEXT]Explosive Mixture[ENDCOLOR] for owned [COLOR:255:230:85:255]Siege[ENDCOLOR] units (tied to dummy building). -5% [ICON_HAPPINESS_3][ICON_HAPPINESS_3] Boredom.'),
			('TXT_KEY_RESOURCE_TROPICAL_FISH',			'Tropical Fish'),
			('TXT_KEY_RESOURCE_TROPICAL_FISH_TEXT',		'TODO');	
---------------------------------------------------------
INSERT INTO Resources 
			(Type,						TechReveal,			TechCityTrade, 		Description,						Civilopedia, 							Help,									ResourceClassType, 		IsMonopoly, 	ArtDefineTag, 						CivilizationType,		OnlyMinorCivs,  Happiness,  ResourceUsage,	IconString, 				PortraitIndex, 	IconAtlas)
VALUES		('RESOURCE_SYLVITE',		null,				null,				'TXT_KEY_RESOURCE_SYLVITE',			'TXT_KEY_RESOURCE_SYLVITE_TEXT',		'TXT_KEY_RESOURCE_MONOPOLY_SYLVITE',	'RESOURCECLASS_LUXURY',	1,				'ART_DEF_RESOURCE_SYLVITE',			null,					0,				2,			2,				'[ICON_RES_SYLVITE]',		1, 				'RESOURCE_MORE_WONDERS_ATLAS'),
			('RESOURCE_TROPICAL_FISH',	'TECH_POTTERY',		null,				'TXT_KEY_RESOURCE_TROPICAL_FISH',	'TXT_KEY_RESOURCE_TROPICAL_FISH_TEXT',	NULL,									'RESOURCECLASS_BONUS',	0,				'ART_DEF_RESOURCE_TROPICAL_FISH',	null,					0,				0,			0,				'[ICON_RES_TROPICAL_FISH]',	2, 				'RESOURCE_MORE_WONDERS_ATLAS');
---------------------------------------------------------
INSERT INTO Resource_YieldChanges
			(ResourceType, 				YieldType, 			Yield)
VALUES		('RESOURCE_TROPICAL_FISH',	'YIELD_FOOD',		1),
			('RESOURCE_TROPICAL_FISH',	'YIELD_CULTURE',	1);

INSERT INTO Improvement_ResourceTypes
			(ImprovementType,				ResourceType, 				ResourceMakesValid, ResourceTrade)
VALUES		('IMPROVEMENT_FISHING_BOATS',	'RESOURCE_TROPICAL_FISH',	1,					1);

INSERT INTO Improvement_ResourceType_Yields
			(ImprovementType,				ResourceType, 				YieldType, 			Yield)
VALUES		('IMPROVEMENT_FISHING_BOATS',	'RESOURCE_TROPICAL_FISH',	'YIELD_FOOD',		2),
			('IMPROVEMENT_FISHING_BOATS',	'RESOURCE_TROPICAL_FISH',	'YIELD_CULTURE',	1);
---------------------------------------------------------
INSERT INTO Resource_Flavors 	
			(ResourceType, 				FlavorType, 			Flavor)
VALUES		('RESOURCE_SYLVITE',		'FLAVOR_PRODUCTION',	20),
			('RESOURCE_SYLVITE',		'FLAVOR_CULTURE',		30),
			('RESOURCE_TROPICAL_FISH',	'FLAVOR_GROWTH',		10),
			('RESOURCE_TROPICAL_FISH',	'FLAVOR_CULTURE',		30);
---------------------------------------------------------
INSERT INTO ArtDefine_StrategicView
			(StrategicViewType, 				TileType, 		Asset)
VALUES 		('ART_DEF_RESOURCE_SYLVITE',		'Resource', 	'sv_Sylvite.dds'),
			('ART_DEF_RESOURCE_TROPICAL_FISH', 	'Resource', 	'sv_Tropical_Fish.dds');

INSERT INTO ArtDefine_LandmarkTypes
			(Type, 								LandmarkType, 	FriendlyName)
VALUES 		('ART_DEF_RESOURCE_SYLVITE', 		'Resource', 	'Sylvite'),
			('ART_DEF_RESOURCE_TROPICAL_FISH', 	'Resource', 	'Tropical Fish');

INSERT INTO ArtDefine_Landmarks
			(Era,	State,	Scale,	ImprovementType,	LayoutHandler,	ResourceType,						Model,					TerrainContour,	Tech) 
SELECT		Era,	State,	Scale,	ImprovementType,	LayoutHandler,	'ART_DEF_RESOURCE_TROPICAL_FISH',	'fish_tropical.fxsxml', TerrainContour,	Tech
FROM ArtDefine_Landmarks WHERE ResourceType = 'ART_DEF_RESOURCE_FISH';
---------------------------------------------------------
INSERT INTO IconFontMapping 
			(IconName, 					IconFontTexture,			IconMapping)
VALUES		('ICON_RES_SYLVITE', 		'MORE_WONDERS_FONT_ATLAS',	2),
			('ICON_RES_TROPICAL_FISH', 	'MORE_WONDERS_FONT_ATLAS',	3);
--============================================--
-- GREAT_WORKS
--============================================--
INSERT INTO GreatWorks
			(Type,						Description,					GreatWorkClassType,	Audio,							Image,						Quote) 
VALUES		('GREAT_WORK_MT_PAEKTU',	'TXT_KEY_GREAT_WORK_MT_PAEKTU',	'GREAT_WORK_ART',	'AS2D_GREAT_ARTIST_ARTWORK',	'Great_Work_Mt_Paektu.dds',	NULL);

INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_GREAT_WORK_MT_PAEKTU',		'Kim Il-sung and Kim Jong-il standing at the peak of Mount Paektu');
--============================================--
-- BUILDINGS
--============================================--
INSERT INTO BuildingClasses 
			(Type,						Description,					DefaultBuilding)
VALUES		('BUILDINGCLASS_MT_PAEKTU',	'TXT_KEY_BUILDING_MT_PAEKTU',	'BUILDING_MT_PAEKTU');

INSERT INTO Buildings
			(Type,					BuildingClass,				Description,					Civilopedia,						Help,								IconAtlas,					PortraitIndex,	PrereqTech, Cost,	FaithCost,	NukeImmune, ConquestProb,	IsDummy,	GreatWorkSlotType,					GreatWorkCount,	FreeGreatWork,			SpecialistType,			GreatPeopleRateChange)
VALUES		('BUILDING_MT_PAEKTU',	'BUILDINGCLASS_MT_PAEKTU',	'TXT_KEY_BUILDING_MT_PAEKTU',	'TXT_KEY_BUILDING_MT_PAEKTU_PEDIA',	'TXT_KEY_BUILDING_MT_PAEKTU_HELP',	'NATURAL_WONDERS_ATLAS',	9,				NULL,       -1,		0,			1,          100,			0,			'GREAT_WORK_SLOT_ART_ARTIFACT',		1,				'GREAT_WORK_MT_PAEKTU',	'SPECIALIST_MUSICIAN',	1);

INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_MT_PAEKTU',			'Altar of the Born under the Mountain'),
			('TXT_KEY_BUILDING_MT_PAEKTU_PEDIA',	'TODO'),
			('TXT_KEY_BUILDING_MT_PAEKTU_HELP',		'+1 [ICON_GREAT_PERSON] Great Musician Point. Has 1 slot for [ICON_GREAT_WORK] Great Work of Art, and starts with [ICON_GREAT_WORK] [COLOR_CULTURE_STORED]Kim Il-sung and Kim Jong-il standing at the peak of Mount Paektu[ENDCOLOR].');

INSERT INTO Building_YieldChanges 
			(BuildingType,			YieldType,					Yield) 
VALUES		('BUILDING_MT_PAEKTU',	'YIELD_FAITH',				3),
			('BUILDING_MT_PAEKTU',	'YIELD_GOLDEN_AGE_POINTS',	3);
--============================================--
-- DUMMY BUILDINGS
--============================================--
INSERT INTO BuildingClasses 
			(Type,									Description,								DefaultBuilding)
VALUES		('BUILDINGCLASS_SALAR_A_DUMMY',			'TXT_KEY_BUILDING_SALAR_A_DUMMY',			'BUILDING_SALAR_A_DUMMY'),
			('BUILDINGCLASS_SALAR_B_DUMMY',			'TXT_KEY_BUILDING_SALAR_B_DUMMY',			'BUILDING_SALAR_B_DUMMY'),
			('BUILDINGCLASS_EL_DORADO_DUMMY',		'TXT_KEY_BUILDING_EL_DORADO_DUMMY',			'BUILDING_EL_DORADO_DUMMY'),
			('BUILDINGCLASS_POTOSI_DUMMY',			'TXT_KEY_BUILDING_POTOSI_DUMMY',			'BUILDING_POTOSI_DUMMY'),
			('BUILDINGCLASS_CRATER_DUMMY',			'TXT_KEY_BUILDING_CRATER_DUMMY',			'BUILDING_CRATER_DUMMY'),
			('BUILDINGCLASS_MESA_DUMMY',			'TXT_KEY_BUILDING_MESA_DUMMY',				'BUILDING_MESA_DUMMY'),
			('BUILDINGCLASS_SOLOMONS_MINES_DUMMY',	'TXT_KEY_BUILDING_SOLOMONS_MINES_DUMMY',	'BUILDING_SOLOMONS_MINES_DUMMY'),
			('BUILDINGCLASS_VOLCANO_DUMMY',			'TXT_KEY_BUILDING_VOLCANO_DUMMY',			'BUILDING_VOLCANO_DUMMY'),
			('BUILDINGCLASS_FUJI_1_DUMMY',			'TXT_KEY_BUILDING_FUJI_DUMMY',				'BUILDING_FUJI_1_DUMMY'),
			('BUILDINGCLASS_FUJI_2_DUMMY',			'TXT_KEY_BUILDING_FUJI_DUMMY',				'BUILDING_FUJI_2_DUMMY'),
			('BUILDINGCLASS_FUJI_3_DUMMY',			'TXT_KEY_BUILDING_FUJI_DUMMY',				'BUILDING_FUJI_3_DUMMY'),
			('BUILDINGCLASS_MT_SINAI_DUMMY',		'TXT_KEY_BUILDING_MT_SINAI_DUMMY',			'BUILDING_MT_SINAI_DUMMY'),
			('BUILDINGCLASS_GEYSER_DUMMY',			'TXT_KEY_BUILDING_GEYSER_DUMMY',			'BUILDING_GEYSER_DUMMY'),
			('BUILDINGCLASS_MT_EVEREST_DUMMY',		'TXT_KEY_BUILDING_MT_EVEREST_DUMMY',		'BUILDING_MT_EVEREST_DUMMY'),
			('BUILDINGCLASS_REEF_DUMMY',			'TXT_KEY_BUILDING_REEF_DUMMY',				'BUILDING_REEF_DUMMY'),
			('BUILDINGCLASS_GIBRALTAR_DUMMY',		'TXT_KEY_BUILDING_GIBRALTAR_DUMMY',			'BUILDING_GIBRALTAR_DUMMY'),
			('BUILDINGCLASS_LAKE_VICTORIA_DUMMY',	'TXT_KEY_BUILDING_LAKE_VICTORIA_DUMMY',		'BUILDING_LAKE_VICTORIA_DUMMY'),
			('BUILDINGCLASS_CAUSEWAY_DUMMY',		'TXT_KEY_BUILDING_CAUSEWAY_DUMMY',			'BUILDING_CAUSEWAY_DUMMY'),
			('BUILDINGCLASS_RETBA_DUMMY',			'TXT_KEY_BUILDING_RETBA_DUMMY',				'BUILDING_RETBA_DUMMY'),
			('BUILDINGCLASS_LUMI_BAY_DUMMY',		'TXT_KEY_BUILDING_LUMI_BAY_DUMMY',			'BUILDING_LUMI_BAY_DUMMY'),
			('BUILDINGCLASS_DALLOL_DUMMY',			'TXT_KEY_BUILDING_DALLOL_DUMMY',			'BUILDING_DALLOL_DUMMY'),
			('BUILDINGCLASS_EYE_OF_SAHARA_1_DUMMY',	'TXT_KEY_BUILDING_EYE_OF_SAHARA_DUMMY',		'BUILDING_EYE_OF_SAHARA_1_DUMMY'),
			('BUILDINGCLASS_EYE_OF_SAHARA_2_DUMMY',	'TXT_KEY_BUILDING_EYE_OF_SAHARA_DUMMY',		'BUILDING_EYE_OF_SAHARA_2_DUMMY'),
			('BUILDINGCLASS_EYE_OF_SAHARA_3_DUMMY',	'TXT_KEY_BUILDING_EYE_OF_SAHARA_DUMMY',		'BUILDING_EYE_OF_SAHARA_3_DUMMY');

INSERT INTO Buildings
			(Type,								BuildingClass,							Description,								PrereqTech, Cost, FaithCost, GreatWorkCount , NukeImmune, ConquestProb, IsDummy)
VALUES		('BUILDING_SALAR_A_DUMMY',			'BUILDINGCLASS_SALAR_A_DUMMY',			'TXT_KEY_BUILDING_SALAR_A_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_SALAR_B_DUMMY',			'BUILDINGCLASS_SALAR_B_DUMMY',			'TXT_KEY_BUILDING_SALAR_B_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_EL_DORADO_DUMMY',		'BUILDINGCLASS_EL_DORADO_DUMMY',		'TXT_KEY_BUILDING_EL_DORADO_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_POTOSI_DUMMY',			'BUILDINGCLASS_POTOSI_DUMMY',			'TXT_KEY_BUILDING_POTOSI_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_CRATER_DUMMY',			'BUILDINGCLASS_CRATER_DUMMY',			'TXT_KEY_BUILDING_CRATER_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_MESA_DUMMY',				'BUILDINGCLASS_MESA_DUMMY',				'TXT_KEY_BUILDING_MESA_DUMMY',				NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_SOLOMONS_MINES_DUMMY',	'BUILDINGCLASS_SOLOMONS_MINES_DUMMY',	'TXT_KEY_BUILDING_SOLOMONS_MINES_DUMMY',	NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_VOLCANO_DUMMY',			'BUILDINGCLASS_VOLCANO_DUMMY',			'TXT_KEY_BUILDING_VOLCANO_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_FUJI_1_DUMMY',			'BUILDINGCLASS_FUJI_1_DUMMY',			'TXT_KEY_BUILDING_FUJI_DUMMY',				NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_FUJI_2_DUMMY',			'BUILDINGCLASS_FUJI_2_DUMMY',			'TXT_KEY_BUILDING_FUJI_DUMMY',				NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_FUJI_3_DUMMY',			'BUILDINGCLASS_FUJI_3_DUMMY',			'TXT_KEY_BUILDING_FUJI_DUMMY',				NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_MT_SINAI_DUMMY',			'BUILDINGCLASS_MT_SINAI_DUMMY',			'TXT_KEY_BUILDING_MT_SINAI_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_GEYSER_DUMMY',			'BUILDINGCLASS_GEYSER_DUMMY',			'TXT_KEY_BUILDING_GEYSER_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_MT_EVEREST_DUMMY',		'BUILDINGCLASS_MT_EVEREST_DUMMY',		'TXT_KEY_BUILDING_MT_EVEREST_DUMMY',		NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_REEF_DUMMY',				'BUILDINGCLASS_REEF_DUMMY',				'TXT_KEY_BUILDING_REEF_DUMMY',				NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_GIBRALTAR_DUMMY',		'BUILDINGCLASS_GIBRALTAR_DUMMY',		'TXT_KEY_BUILDING_GIBRALTAR_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_LAKE_VICTORIA_DUMMY',	'BUILDINGCLASS_LAKE_VICTORIA_DUMMY',	'TXT_KEY_BUILDING_LAKE_VICTORIA_DUMMY',		NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_CAUSEWAY_DUMMY',			'BUILDINGCLASS_CAUSEWAY_DUMMY',			'TXT_KEY_BUILDING_CAUSEWAY_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_RETBA_DUMMY',			'BUILDINGCLASS_RETBA_DUMMY',			'TXT_KEY_BUILDING_RETBA_DUMMY',				NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_LUMI_BAY_DUMMY',			'BUILDINGCLASS_LUMI_BAY_DUMMY',			'TXT_KEY_BUILDING_LUMI_BAY_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_DALLOL_DUMMY',			'BUILDINGCLASS_DALLOL_DUMMY',			'TXT_KEY_BUILDING_DALLOL_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_EYE_OF_SAHARA_1_DUMMY',	'BUILDINGCLASS_EYE_OF_SAHARA_1_DUMMY',	'TXT_KEY_BUILDING_EYE_OF_SAHARA_DUMMY',		NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_EYE_OF_SAHARA_2_DUMMY',	'BUILDINGCLASS_EYE_OF_SAHARA_2_DUMMY',	'TXT_KEY_BUILDING_EYE_OF_SAHARA_DUMMY',		NULL,       -1,   -1,        -1,              1,          0,			1),
			('BUILDING_EYE_OF_SAHARA_3_DUMMY',	'BUILDINGCLASS_EYE_OF_SAHARA_3_DUMMY',	'TXT_KEY_BUILDING_EYE_OF_SAHARA_DUMMY',		NULL,       -1,   -1,        -1,              1,          0,			1);

UPDATE Buildings SET SpecialistType = 'SPECIALIST_ARTIST', GreatPeopleRateChange = 3 WHERE Type = 'BUILDING_FUJI_1_DUMMY';
UPDATE Buildings SET SpecialistType = 'SPECIALIST_WRITER', GreatPeopleRateChange = 2 WHERE Type = 'BUILDING_FUJI_2_DUMMY';
UPDATE Buildings SET SpecialistType = 'SPECIALIST_MUSICIAN', GreatPeopleRateChange = 1 WHERE Type = 'BUILDING_FUJI_3_DUMMY';
UPDATE Buildings SET SpecialistType = 'SPECIALIST_SCIENTIST', GreatPeopleRateChange = 2 WHERE Type = 'BUILDING_GEYSER_DUMMY';
UPDATE Buildings SET EmpireNeedsModifierGlobal = -10 WHERE Type = 'BUILDING_VOLCANO_DUMMY';
UPDATE Buildings SET GlobalSpaceProductionModifier = 20 WHERE Type = 'BUILDING_CRATER_DUMMY';
UPDATE Buildings SET NumTradeRouteBonus = 1 WHERE Type = 'BUILDING_POTOSI_DUMMY';
UPDATE Buildings SET ExtraLeagueVotes = 1 WHERE Type = 'BUILDING_GIBRALTAR_DUMMY';
UPDATE Buildings SET CitySupplyFlatGlobal = 1 WHERE Type = 'BUILDING_MESA_DUMMY';
UPDATE Buildings SET AllowsFoodTradeRoutesGlobal = 1 WHERE Type = 'BUILDING_LAKE_VICTORIA_DUMMY';
UPDATE Buildings SET GlobalLandmarksTourismPercent = 25 WHERE Type = 'BUILDING_CAUSEWAY_DUMMY';
UPDATE Buildings SET UnculturedHappinessChangeGlobal = -5 WHERE Type = 'BUILDING_DALLOL_DUMMY';
UPDATE Buildings SET EnhancedYieldTech = 'TECH_CONSTRUCTION' WHERE Type = 'BUILDING_EYE_OF_SAHARA_1_DUMMY';
UPDATE Buildings SET EnhancedYieldTech = 'TECH_ARCHAEOLOGY' WHERE Type = 'BUILDING_EYE_OF_SAHARA_2_DUMMY';
UPDATE Buildings SET EnhancedYieldTech = 'TECH_SATELLITES' WHERE Type = 'BUILDING_EYE_OF_SAHARA_3_DUMMY';

INSERT INTO Language_en_US 
			(Tag,										Text) 
VALUES		('TXT_KEY_BUILDING_SALAR_A_DUMMY',			'Salar de Uyuni A'),
			('TXT_KEY_BUILDING_SALAR_B_DUMMY',			'Salar de Uyuni B'),
			('TXT_KEY_BUILDING_EL_DORADO_DUMMY',		'El Dorado'),
			('TXT_KEY_BUILDING_POTOSI_DUMMY',			'Cerro de Potosi'),
			('TXT_KEY_BUILDING_CRATER_DUMMY',			'The Barringer Crater'),
			('TXT_KEY_BUILDING_MESA_DUMMY',				'The Grand Mesa'),
			('TXT_KEY_BUILDING_SOLOMONS_MINES_DUMMY',	'King Solomon''s Mines'),
			('TXT_KEY_BUILDING_VOLCANO_DUMMY',			'Krakatoa'),
			('TXT_KEY_BUILDING_FUJI_DUMMY',				'Mt. Fuji'),
			('TXT_KEY_BUILDING_MT_SINAI_DUMMY',			'Mt. Sinai'),
			('TXT_KEY_BUILDING_GEYSER_DUMMY',			'Old Faithful'),
			('TXT_KEY_BUILDING_MT_EVEREST_DUMMY',		'Mt. Everest'),
			('TXT_KEY_BUILDING_REEF_DUMMY',				'Great Barrier Reef'),
			('TXT_KEY_BUILDING_GIBRALTAR_DUMMY',		'Rock of Gibraltar'),
			('TXT_KEY_BUILDING_LAKE_VICTORIA_DUMMY',	'Lake Victoria'),
			('TXT_KEY_BUILDING_CAUSEWAY_DUMMY',			'Giant''s Causeway'),
			('TXT_KEY_BUILDING_RETBA_DUMMY',			'Lake Retba'),
			('TXT_KEY_BUILDING_LUMI_BAY_DUMMY',			'Bioluminescent Bay'),
			('TXT_KEY_BUILDING_DALLOL_DUMMY',			'Dallol'),
			('TXT_KEY_BUILDING_EYE_OF_SAHARA_DUMMY',	'Eye of the Sahara');

INSERT INTO Building_ResourceQuantity
			(BuildingType,					ResourceType,		Quantity) 
VALUES		('BUILDING_EL_DORADO_DUMMY',	'RESOURCE_GOLD',	1),
			('BUILDING_POTOSI_DUMMY',		'RESOURCE_SILVER',	1),
			('BUILDING_DALLOL_DUMMY',		'RESOURCE_SYLVITE',	1);

INSERT INTO Building_GreatWorkYieldChanges
			(BuildingType,				YieldType,					Yield) 
VALUES		('BUILDING_MT_SINAI_DUMMY',	'YIELD_FAITH',				1),
			('BUILDING_MT_SINAI_DUMMY',	'YIELD_GOLDEN_AGE_POINTS',	1);

INSERT INTO Building_ImprovementYieldChangesGlobal
			(BuildingType,						ImprovementType,				YieldType,						Yield) 
VALUES		('BUILDING_SOLOMONS_MINES_DUMMY',	'IMPROVEMENT_MINE',				'YIELD_GOLDEN_AGE_POINTS',		1),
			('BUILDING_MT_SINAI_DUMMY',			'IMPROVEMENT_HOLY_SITE',		'YIELD_FAITH',					1),
			('BUILDING_MT_SINAI_DUMMY',			'IMPROVEMENT_HOLY_SITE',		'YIELD_GOLDEN_AGE_POINTS',		1),
			('BUILDING_REEF_DUMMY',				'IMPROVEMENT_FISHING_BOATS',	'YIELD_FOOD',					1);

INSERT INTO Building_ResourceYieldChangesGlobal
			(BuildingType,				ResourceType,		YieldType,			Yield) 
VALUES		('BUILDING_LUMI_BAY_DUMMY',	'RESOURCE_FISH',	'YIELD_SCIENCE',	1);

INSERT INTO Building_ResourceYieldChangesGlobal (BuildingType,			ResourceType,	YieldType,			Yield)
SELECT DISTINCT									'BUILDING_REEF_DUMMY',	Type,			'YIELD_SCIENCE',	1
FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_LUXURY' and TechCityTrade = 'TECH_SAILING';

INSERT INTO Building_GlobalYieldModifiers
			(BuildingType,						YieldType,			Yield) 
VALUES		('BUILDING_MT_EVEREST_DUMMY',		'YIELD_TOURISM',	10),
			('BUILDING_SALAR_A_DUMMY',			'YIELD_FOOD',		10),
			('BUILDING_SALAR_B_DUMMY',			'YIELD_FOOD',		5),
			('BUILDING_VOLCANO_DUMMY',			'YIELD_SCIENCE',	5),
			('BUILDING_RETBA_DUMMY',			'YIELD_FOOD',		5);

INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType,						YieldType,			Yield) 
VALUES		('BUILDING_EYE_OF_SAHARA_1_DUMMY',	'YIELD_CULTURE',	1),
			('BUILDING_EYE_OF_SAHARA_2_DUMMY',	'YIELD_TOURISM',	5),
			('BUILDING_EYE_OF_SAHARA_3_DUMMY',	'YIELD_TOURISM',	10);
--------------------------------------------------------------
--------------------------------------------------------------
