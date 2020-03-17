----------------------------------------------------
-- Main file for all Wonders
-- Dec 9, 2017: Created, Infixo
-- Jan 6, 2020: Improved, adan_eslavo
--============================================--
-- Promotion Icons Atlas
--============================================--
INSERT INTO IconTextureAtlases	
			(Atlas,								IconSize,	Filename,								IconsPerRow,	IconsPerColumn) 
VALUES		('PROMOTION_MORE_WONDERS_ATLAS',	256,		'PromotionMoreWondersIcons_256.dds',	'4',			'1'),
			('PROMOTION_MORE_WONDERS_ATLAS',	64,			'PromotionMoreWondersIcons_64.dds',		'4',			'1'),
			('PROMOTION_MORE_WONDERS_ATLAS',	45,			'PromotionMoreWondersIcons_45.dds',		'4',			'1'),
			('PROMOTION_MORE_WONDERS_ATLAS',	32,			'PromotionMoreWondersIcons_32.dds',		'4',			'1'),
			('PROMOTION_MORE_WONDERS_ATLAS',	16,			'PromotionMoreWondersIcons_16.dds',		'4',			'1');
--============================================--
-- HELP
--============================================--
-- Water - city must be built NEXT TO a COAST tile or LAKE tile (MinAreaSize=10 is Sea, MinAreaSize=1 is Lake)
-- River - city must be built NEXT TO a RIVER
-- FreshWater - city must be built next to a RIVER or adjacent to a LAKE or OASIS tile
-- Mountain - city must be built NEXT TO a MOUNTAIN tile
-- NearbyMountainRequired - city must be built WITHIN 2 TILES OF a MOUNTAIN tile, Mountain must be within cultural borders
-- Hill - city must be built ON a HILL tile
-- Flat - city MUST NOT be built ON a HILL tile
-- HolyCity
-- (VP) IsNoWater - restricts Fresh Water (River, Lake)
-- (VP) IsNoRiver
-- (VP) AnyWater - requires any type of water (Lake, Coast, River)
-- (VP) CapitalOnly
-- (VP) ResourceType - allows for Building to be unlocked by a specific resource being owned (can be strategic or luxury)
-- (VP) RequiresRail - rail connection
--============================================--
-- NEOLITHIC ERA
--============================================--
-- ALTAMIRA CAVE (NEW)
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_ALTAMIRA';
	UPDATE Buildings SET Cost = 115, PrereqTech = 'TECH_AGRICULTURE', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_ANCIENT' WHERE Type = 'BUILDING_ALTAMIRA';
	UPDATE Buildings SET NearbyMountainRequired = 1 WHERE Type = 'BUILDING_ALTAMIRA';
	
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType,			ResourceType) 
	VALUES		('BUILDING_ALTAMIRA',	'RESOURCE_BISON'),
				('BUILDING_ALTAMIRA',	'RESOURCE_DEER');
	---------------------------------------------------------	
	UPDATE Buildings SET Defense = 500, GreatWorkSlotType = 'GREAT_WORK_SLOT_ART_ARTIFACT', GreatWorkCount = 1, EnhancedYieldTech = 'TECH_ARCHAEOLOGY' WHERE Type = 'BUILDING_ALTAMIRA';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,			Yield) 
	VALUES		('BUILDING_ALTAMIRA',	'YIELD_CULTURE',	1);

	INSERT INTO Building_ResourceYieldChanges 
				(BuildingType,			ResourceType,		YieldType,			Yield) 
	VALUES		('BUILDING_ALTAMIRA',	'RESOURCE_BISON',	'YIELD_FOOD',		1),
				('BUILDING_ALTAMIRA',	'RESOURCE_DEER',	'YIELD_FOOD',		1),
				('BUILDING_ALTAMIRA',	'RESOURCE_BISON',	'YIELD_CULTURE',	1),
				('BUILDING_ALTAMIRA',	'RESOURCE_DEER',	'YIELD_CULTURE',	1);
				
	INSERT INTO Building_TechEnhancedYieldChanges
				(BuildingType,			YieldType,			Yield) 
	VALUES		('BUILDING_ALTAMIRA',	'YIELD_CULTURE',	3);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor) 
	VALUES		('BUILDING_ALTAMIRA',	'FLAVOR_CITY_DEFENSE',	10),
				('BUILDING_ALTAMIRA',	'FLAVOR_CULTURE',		50),
				('BUILDING_ALTAMIRA',	'FLAVOR_GROWTH',		30);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- GGANTIJA (NEW)
	UPDATE Buildings SET Cost = 115, PrereqTech = 'TECH_AGRICULTURE',	NumPoliciesNeeded = 0, MaxStartEra = 'ERA_ANCIENT' WHERE Type = 'BUILDING_GGANTIJA';
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_GGANTIJA';
	UPDATE Buildings SET Hill = 1, NearbyTerrainRequired = 'TERRAIN_GRASS' WHERE Type = 'BUILDING_GGANTIJA';
	
	-- + Farm(2) (lua)
	---------------------------------------------------------	
	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,		Yield)
	VALUES		('BUILDING_GGANTIJA',	'YIELD_FAITH',	2);

	INSERT INTO Building_ImprovementYieldChangesGlobal 
				(BuildingType,			ImprovementType,	YieldType,		Yield) 
	VALUES		('BUILDING_GGANTIJA',	'IMPROVEMENT_FARM',	'YIELD_FOOD',	1);

	INSERT INTO Building_InstantYield
				(BuildingType,			YieldType,		Yield) 
	VALUES		('BUILDING_GGANTIJA',	'YIELD_FOOD',	50);
	
	INSERT INTO Building_YieldFromYieldPercent
				(BuildingType,			YieldIn,		YieldOut,		Value) 
	VALUES		('BUILDING_GGANTIJA',	'YIELD_FAITH',	'YIELD_FOOD',	10);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors
				(BuildingType,			FlavorType,			Flavor)
	VALUES		('BUILDING_GGANTIJA',	'FLAVOR_RELIGION',	10),
				('BUILDING_GGANTIJA',	'FLAVOR_GROWTH',	60);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- GOEBEKLI TEPE (NEW)
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_GOEBEKLI_TEPE';
	UPDATE Buildings SET Cost = 115, PrereqTech = 'TECH_AGRICULTURE', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_ANCIENT' WHERE Type = 'BUILDING_GOEBEKLI_TEPE';
	UPDATE Buildings SET NearbyMountainRequired = 1, IsNoWater = 1 WHERE Type = 'BUILDING_GOEBEKLI_TEPE';
	
	-- + IsNoCoast (lua)
	---------------------------------------------------------	
	INSERT INTO Building_YieldChanges
				(BuildingType,				YieldType,			Yield) 
	VALUES		('BUILDING_GOEBEKLI_TEPE',	'YIELD_CULTURE',	1),
				('BUILDING_GOEBEKLI_TEPE',	'YIELD_SCIENCE',	1),
				('BUILDING_GOEBEKLI_TEPE',	'YIELD_FAITH',		1);

	INSERT INTO Building_ResourceYieldChangesGlobal
				(BuildingType,				ResourceType,		YieldType,			Yield) 
	VALUES		('BUILDING_GOEBEKLI_TEPE',	'RESOURCE_STONE',	'YIELD_SCIENCE',	1);

	INSERT INTO Building_TerrainYieldChanges 
				(BuildingType,				TerrainType,		YieldType,			Yield) 
	VALUES		('BUILDING_GOEBEKLI_TEPE',	'TERRAIN_MOUNTAIN', 'YIELD_FAITH',		1),
				('BUILDING_GOEBEKLI_TEPE',	'TERRAIN_MOUNTAIN', 'YIELD_SCIENCE',	1);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,				FlavorType,			Flavor) 
	VALUES		('BUILDING_GOEBEKLI_TEPE',	'FLAVOR_CULTURE',	10),
				('BUILDING_GOEBEKLI_TEPE',	'FLAVOR_SCIENCE',	40),
				('BUILDING_GOEBEKLI_TEPE',	'FLAVOR_RELIGION',	40);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- KUK (NEW)
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_KUK';
	UPDATE Buildings SET Cost = 115, PrereqTech = 'TECH_AGRICULTURE', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_ANCIENT' WHERE Type = 'BUILDING_KUK';
	UPDATE Buildings SET Hill = 1, ProhibitedCityTerrain = 'TERRAIN_TUNDRA' WHERE Type = 'BUILDING_KUK';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,		FeatureType) 
	VALUES		('BUILDING_KUK',	'FEATURE_MARSH');
	---------------------------------------------------------	
	UPDATE Buildings SET FoodKept = 10 WHERE Type = 'BUILDING_KUK';
	
	INSERT INTO Building_YieldChanges
				(BuildingType,		YieldType,			Yield) 
	VALUES		('BUILDING_KUK',	'YIELD_FOOD',		1),
				('BUILDING_KUK',	'YIELD_SCIENCE',	1);

	INSERT INTO Building_GrowthExtraYield
				(BuildingType,		YieldType,				Yield) 
	VALUES		('BUILDING_KUK',	'YIELD_PRODUCTION',		5);
	
	INSERT INTO Building_FeatureYieldChanges 
				(BuildingType,			FeatureType,			YieldType,				Yield) 
	VALUES		('BUILDING_KUK_DUMMY',	'FEATURE_MARSH',		'YIELD_PRODUCTION',		1),
				('BUILDING_KUK_DUMMY',	'FEATURE_MARSH',		'YIELD_SCIENCE',		1);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,		FlavorType,				Flavor) 
	VALUES		('BUILDING_KUK',	'FLAVOR_GROWTH',		40),
				('BUILDING_KUK',	'FLAVOR_SCIENCE',		30),
				('BUILDING_KUK',	'FLAVOR_PRODUCTION',	40);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- MAJORVILLE MEDICINE WHEEL (NEW)
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_MAJORVILLE';
	UPDATE Buildings SET Cost = 115, PrereqTech = 'TECH_AGRICULTURE', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_ANCIENT' WHERE Type = 'BUILDING_MAJORVILLE';
	UPDATE Buildings SET Hill = 1, NearbyTerrainRequired = 'TERRAIN_TUNDRA' WHERE Type = 'BUILDING_MAJORVILLE';
	
	-- + IsNoCoast (lua)
	---------------------------------------------------------	
	INSERT INTO Building_YieldChanges
				(BuildingType,			YieldType,			Yield) 
	VALUES		('BUILDING_MAJORVILLE',	'YIELD_FAITH',		1),
				('BUILDING_MAJORVILLE',	'YIELD_SCIENCE',	1);
	
	INSERT INTO Building_TerrainYieldChanges 
				(BuildingType,			TerrainType,		YieldType,		Yield) 
	VALUES		('BUILDING_MAJORVILLE',	'TERRAIN_TUNDRA',	'YIELD_FAITH',	1);

	INSERT INTO Building_ImprovementYieldChangesGlobal 
				(BuildingType,			ImprovementType,	YieldType,		Yield) 
	VALUES		('BUILDING_MAJORVILLE',	'IMPROVEMENT_CAMP',	'YIELD_FOOD',	1);

	INSERT INTO Building_ResourceYieldChangesGlobal 
				(BuildingType,			ResourceType,		YieldType,			Yield) 
	VALUES		('BUILDING_MAJORVILLE', 'RESOURCE_BISON',	'YIELD_CULTURE',	1);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,				FlavorType,				Flavor) 
	VALUES		('BUILDING_MAJORVILLE',	'FLAVOR_SCIENCE',		10),
				('BUILDING_MAJORVILLE',	'FLAVOR_RELIGION',		30),
				('BUILDING_MAJORVILLE',	'FLAVOR_CULTURE',		30),
				('BUILDING_MAJORVILLE',	'FLAVOR_GROWTH',		30);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- MOHENJO-DARO (NEW)
	UPDATE Buildings SET Cost = 115, PrereqTech = 'TECH_AGRICULTURE', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_ANCIENT' WHERE Type = 'BUILDING_MOHENJO_DARO';
	UPDATE Buildings SET WonderSplashAnchor = 'C,B' WHERE Type = 'BUILDING_MOHENJO_DARO';
	UPDATE Buildings SET River = 1, NearbyTerrainRequired = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_MOHENJO_DARO';

	-- +IsNoCoast (lua)
	---------------------------------------------------------	
	UPDATE Buildings SET FreeBuildingThisCity = 'BUILDINGCLASS_WELL' WHERE Type = 'BUILDING_MOHENJO_DARO';
	
	INSERT INTO Building_YieldChanges
				(BuildingType,				YieldType,			Yield) 
	VALUES		('BUILDING_MOHENJO_DARO',	'YIELD_CULTURE',	2),
				('BUILDING_MOHENJO_DARO',	'YIELD_FAITH',		1),
				('BUILDING_MOHENJO_DARO',	'YIELD_FOOD',		1);

	INSERT INTO Building_RiverPlotYieldChanges
				(BuildingType,				YieldType,		Yield) 
	VALUES		('BUILDING_MOHENJO_DARO',	'YIELD_FOOD',	1);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,				FlavorType,				Flavor) 
	VALUES		('BUILDING_MOHENJO_DARO',	'FLAVOR_CULTURE',		20),
				('BUILDING_MOHENJO_DARO',	'FLAVOR_RELIGION',		30),
				('BUILDING_MOHENJO_DARO',	'FLAVOR_GROWTH',		50);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- SKARA BRAE (NEW)
	UPDATE Buildings SET Cost = 115, PrereqTech = 'TECH_AGRICULTURE', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_ANCIENT' WHERE Type = 'BUILDING_SKARA_BRAE';
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_SKARA_BRAE';
	UPDATE Buildings SET Flat = 1, Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_SKARA_BRAE';
	
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType, ResourceType) 
	VALUES		('BUILDING_SKARA_BRAE', 'RESOURCE_FISH'),
				('BUILDING_SKARA_BRAE', 'RESOURCE_COW'),
				('BUILDING_SKARA_BRAE', 'RESOURCE_WHEAT'),
				('BUILDING_SKARA_BRAE', 'RESOURCE_SHEEP');
	---------------------------------------------------------	
	INSERT INTO Building_YieldChanges
				(BuildingType,			YieldType,			Yield) 
	VALUES		('BUILDING_SKARA_BRAE', 'YIELD_PRODUCTION',	1),
				('BUILDING_SKARA_BRAE', 'YIELD_FOOD',		1);
	
	INSERT INTO Building_ResourceYieldChangesGlobal 
				(BuildingType,			ResourceType,		YieldType,		Yield) 
	VALUES		('BUILDING_SKARA_BRAE', 'RESOURCE_FISH',	'YIELD_FOOD',	1),
				('BUILDING_SKARA_BRAE', 'RESOURCE_COW',		'YIELD_FOOD',	1),
				('BUILDING_SKARA_BRAE', 'RESOURCE_WHEAT',	'YIELD_FOOD',	1),
				('BUILDING_SKARA_BRAE', 'RESOURCE_SHEEP',	'YIELD_FOOD',	1);
	
	INSERT INTO Building_ImprovementYieldChangesGlobal 
				(BuildingType,			ImprovementType,			YieldType,			Yield) 
	VALUES		('BUILDING_SKARA_BRAE',	'IMPROVEMENT_TRADING_POST',	'YIELD_PRODUCTION',	1),
				('BUILDING_SKARA_BRAE',	'IMPROVEMENT_TRADING_POST',	'YIELD_GOLD',		1);
---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,					Flavor) 
	VALUES		('BUILDING_SKARA_BRAE', 'FLAVOR_PRODUCTION',		20),
				('BUILDING_SKARA_BRAE', 'FLAVOR_GROWTH',			60),
				('BUILDING_SKARA_BRAE', 'FLAVOR_GOLD',				20),
				('BUILDING_SKARA_BRAE', 'FLAVOR_TILE_IMPROVEMENT',	20);
--============================================--
-- ANCIENT ERA
--============================================--
-- KARNAK (NEW)
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_KARNAK';
	UPDATE Buildings SET Cost = 150, PrereqTech = 'TECH_POTTERY',	NumPoliciesNeeded = 0, MaxStartEra = 'ERA_CLASSICAL' WHERE Type = 'BUILDING_KARNAK';
	UPDATE Buildings SET Flat = 1 WHERE Type = 'BUILDING_KARNAK';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,			FeatureType) 
	VALUES		('BUILDING_KARNAK',		'FEATURE_OASIS'),
				('BUILDING_KARNAK',		'FEATURE_FLOOD_PLAINS');
	---------------------------------------------------------	
	UPDATE Buildings SET FreeBuildingThisCity = 'BUILDINGCLASS_MONUMENT', EnhancedYieldTech = 'TECH_ARCHAEOLOGY', TechEnhancedTourism = 4 WHERE Type = 'BUILDING_KARNAK';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,		YieldType,			Yield) 
	VALUES		('BUILDING_KARNAK', 'YIELD_FOOD',		1),
				('BUILDING_KARNAK', 'YIELD_FAITH',		1),
				('BUILDING_KARNAK', 'YIELD_CULTURE',	1);
	
	INSERT INTO Building_YieldPerXFeatureTimes100 
				(BuildingType,		FeatureType,			YieldType,				Yield) 
	VALUES		('BUILDING_KARNAK', 'FEATURE_FLOOD_PLAINS', 'YIELD_PRODUCTION',		50),
				('BUILDING_KARNAK', 'FEATURE_FLOOD_PLAINS', 'YIELD_FAITH',			50);

	INSERT INTO Building_FeatureYieldChanges 
				(BuildingType,		FeatureType,			YieldType,				Yield) 
	VALUES		('BUILDING_KARNAK', 'FEATURE_OASIS',		'YIELD_PRODUCTION',		1),
				('BUILDING_KARNAK', 'FEATURE_OASIS',		'YIELD_FAITH',			1);
	
	INSERT INTO Building_BuildingClassYieldChanges 
				(BuildingType,		BuildingClassType,			YieldType,			YieldChange) 
	VALUES		('BUILDING_KARNAK',	'BUILDINGCLASS_MONUMENT',	'YIELD_CULTURE',	1);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,		FlavorType,				Flavor) 
	VALUES		('BUILDING_KARNAK', 'FLAVOR_CULTURE',		40),
				('BUILDING_KARNAK', 'FLAVOR_RELIGION',		40),
				('BUILDING_KARNAK', 'FLAVOR_GROWTH',		40);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- STONEHENGE
	UPDATE Buildings SET WonderSplashAnchor = 'L,B' WHERE Type = 'BUILDING_STONEHENGE';
	UPDATE Buildings SET NearbyTerrainRequired = 'TERRAIN_GRASS' WHERE Type = 'BUILDING_STONEHENGE';
	UPDATE Buildings SET Flat = 1 WHERE Type = 'BUILDING_STONEHENGE';

	-- +IsNoCoast (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- NAZCA LINES (NEW)
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_NAZCA';
	UPDATE Buildings SET Cost = 150, PrereqTech = 'TECH_TRAPPING',	NumPoliciesNeeded = 0, MaxStartEra = 'ERA_CLASSICAL' WHERE Type = 'BUILDING_NAZCA';
	UPDATE Buildings SET Hill = 1, NearbyTerrainRequired = 'TERRAIN_PLAINS' WHERE Type = 'BUILDING_NAZCA';
	
	-- + Camp(1) (lua)
	---------------------------------------------------------	
	UPDATE Buildings SET EnhancedYieldTech = 'TECH_FLIGHT', TechEnhancedTourism = 4, SpecialistType = 'SPECIALIST_SCIENTIST', GreatPeopleRateChange = 1 WHERE Type = 'BUILDING_NAZCA';
	
	INSERT INTO Building_TerrainYieldChanges 
				(BuildingType,		TerrainType,		YieldType,		Yield) 
	VALUES		('BUILDING_NAZCA',	'TERRAIN_PLAINS',	'YIELD_FOOD',	2);
	
	INSERT INTO Building_PlotYieldChanges 
				(BuildingType,		PlotType,		YieldType,		Yield) 
	VALUES		('BUILDING_NAZCA',	'PLOT_HILLS',	'YIELD_FAITH',	1);
	
	INSERT INTO Building_ImprovementYieldChanges 
				(BuildingType,		ImprovementType,	YieldType,			Yield) 
	VALUES		('BUILDING_NAZCA',	'IMPROVEMENT_CAMP',	'YIELD_SCIENCE',	1);

	INSERT INTO Building_TechEnhancedYieldChanges
				(BuildingType,		YieldType,			Yield) 
	VALUES		('BUILDING_NAZCA', 'YIELD_SCIENCE',		4);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,		FlavorType,			Flavor) 
	VALUES		('BUILDING_NAZCA',	'FLAVOR_GROWTH',	60),
				('BUILDING_NAZCA',	'FLAVOR_RELIGION',	60),
				('BUILDING_NAZCA',	'FLAVOR_SCIENCE',	10),
				('BUILDING_NAZCA',	'FLAVOR_CULTURE',	10);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- PYRAMIDS
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_PYRAMID';
	UPDATE Buildings SET River = 1, Flat = 1, ProhibitedCityTerrain = 'TERRAIN_TUNDRA' WHERE Type = 'BUILDING_PYRAMID';
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- WIELICZKA (NEW)
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_WIELICZKA';
	UPDATE Buildings SET Cost = 150, PrereqTech = 'TECH_MINING', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_CLASSICAL' WHERE Type = 'BUILDING_WIELICZKA';
	UPDATE Buildings SET Hill = 1 WHERE Type = 'BUILDING_WIELICZKA';
	
	-- + Mine(2) lua
	---------------------------------------------------------	
	UPDATE Buildings SET ResourceQuantityToPlace = 1 WHERE Type = 'BUILDING_WIELICZKA';

	INSERT INTO Building_ResourceYieldChanges 
				(BuildingType,			ResourceType,		YieldType,			Yield) 
	VALUES		('BUILDING_WIELICZKA',	'RESOURCE_SALT',	'YIELD_PRODUCTION',	1),
				('BUILDING_WIELICZKA',	'RESOURCE_SALT',	'YIELD_GOLD',	1);
	
	INSERT INTO Building_ResourcePlotsToPlace
				(BuildingType,			ResourceType,		NumPlots) 
	VALUES		('BUILDING_WIELICZKA',	'RESOURCE_SALT',	2);

	INSERT INTO Building_GlobalYieldModifiers 
				(BuildingType,			YieldType,		Yield) 
	VALUES		('BUILDING_WIELICZKA',	'YIELD_FOOD',	5);
	
	INSERT INTO Building_ImprovementYieldChanges 
				(BuildingType,			ImprovementType,	YieldType,		Yield) 
	VALUES		('BUILDING_WIELICZKA',	'IMPROVEMENT_MINE',	'YIELD_FOOD',	1);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor) 
	VALUES		('BUILDING_WIELICZKA',	'FLAVOR_GROWTH',		50),
				('BUILDING_WIELICZKA',	'FLAVOR_PRODUCTION',	10),
				('BUILDING_WIELICZKA',	'FLAVOR_GOLD',			20),
				('BUILDING_WIELICZKA',	'FLAVOR_HAPPINESS',		20);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- PETRA
	UPDATE Buildings SET WonderSplashAnchor = 'C,T' WHERE Type = 'BUILDING_PETRA';
	UPDATE Buildings SET Mountain = 1, NearbyTerrainRequired = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_PETRA';
	
	-- + IsNoCoast (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- TEMPLE OF ARTEMIS
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_TEMPLE_ARTEMIS';
	UPDATE Buildings SET FreshWater = 1, ProhibitedCityTerrain = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_TEMPLE_ARTEMIS';
	
	-- + Camp(1) (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- MAUSOLEUM OF HALICARNASSUS
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_MAUSOLEUM_HALICARNASSUS';
	UPDATE Buildings SET Water = 1, MinAreaSize = 10, Hill = 1 WHERE Type = 'BUILDING_MAUSOLEUM_HALICARNASSUS';
	
	-- + Quarry(1) (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- STATUE OF ZEUS
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_STATUE_ZEUS';
	
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType,				ResourceType) 
	VALUES		('BUILDING_STATUE_ZEUS',	'RESOURCE_MARBLE'),
				('BUILDING_STATUE_ZEUS',	'RESOURCE_STONE');
	
	-- + Afraid/Guarded/Hostile/War (lua)
--============================================--
-- CLASSICAL ERA
--============================================--
-- GREAT LIGHTHOUSE
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_GREAT_LIGHTHOUSE';
	UPDATE Buildings SET Water = 1, MinAreaSize = 10, River = 1 WHERE Type = 'BUILDING_GREAT_LIGHTHOUSE';
	
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType,						ResourceType) 
	VALUES		('BUILDING_GREAT_LIGHTHOUSE',		'RESOURCE_STONE');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- GREAT LIBRARY
	UPDATE Buildings SET WonderSplashAnchor = 'L,B' WHERE Type = 'BUILDING_GREAT_LIBRARY';
	UPDATE Buildings SET Hill = 1, Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_GREAT_LIBRARY';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,				FeatureType) 
	VALUES		('BUILDING_GREAT_LIBRARY',	'FEATURE_FOREST'),
				('BUILDING_GREAT_LIBRARY',	'FEATURE_JUNGLE');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- HANGING GARDENS
	UPDATE Buildings SET WonderSplashAnchor = 'C,T' WHERE Type = 'BUILDING_HANGING_GARDEN';
	UPDATE Buildings SET Flat = 1, FreshWater = 1 WHERE Type = 'BUILDING_HANGING_GARDEN';
	
	-- + IsNoCoast (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- FORUM ROMANUM
	UPDATE Buildings SET WonderSplashAnchor = 'L,T', PrereqTech = 'TECH_WRITING' WHERE Type = 'BUILDING_FORUM';
	UPDATE Buildings SET River = 1 WHERE Type = 'BUILDING_FORUM';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,		FeatureType) 
	VALUES		('BUILDING_FORUM',	'FEATURE_MARSH');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- MALWIYA MINARET (NEW)
	UPDATE Buildings SET Cost = 200, PrereqTech = 'TECH_MATHEMATICS', NumPoliciesNeeded = 4, MaxStartEra = 'ERA_MEDIEVAL' WHERE Type = 'BUILDING_MALWIYA';
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_MALWIYA';
	
	UPDATE Buildings SET Flat = 1 WHERE Type = 'BUILDING_MALWIYA';
	
	INSERT INTO Building_ClassesNeededInCity 
				(BuildingType,			BuildingClassType) 
	VALUES		('BUILDING_MALWIYA',	'BUILDINGCLASS_STONE_WORKS');
	---------------------------------------------------------
	UPDATE Buildings SET SpecialistType = 'SPECIALIST_ENGINEER', GreatPeopleRateChange = 2 WHERE Type = 'BUILDING_MALWIYA';

	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,			Yield) 
	VALUES		('BUILDING_MALWIYA',	'YIELD_FAITH',		3);

	INSERT INTO Building_ImprovementYieldChangesGlobal 
				(BuildingType,			ImprovementType,			YieldType,			Yield) 
	VALUES		('BUILDING_MALWIYA',	'IMPROVEMENT_MANUFACTORY',	'YIELD_FAITH',		3),
				('BUILDING_MALWIYA',	'IMPROVEMENT_QUARRY',		'YIELD_FAITH',		1),
				('BUILDING_MALWIYA',	'IMPROVEMENT_QUARRY',		'YIELD_PRODUCTION', 1);

	INSERT INTO Building_BuildingClassYieldChanges 
				(BuildingType,			BuildingClassType,				YieldType,			YieldChange) 
	VALUES		('BUILDING_MALWIYA',	'BUILDINGCLASS_STONE_WORKS',	'YIELD_PRODUCTION', 2);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,					Flavor) 
	VALUES		('BUILDING_MALWIYA',	'FLAVOR_GREAT_PEOPLE',		30),
				('BUILDING_MALWIYA',	'FLAVOR_PRODUCTION',		50),
				('BUILDING_MALWIYA',	'FLAVOR_RELIGION',			60),
				('BUILDING_MALWIYA',	'FLAVOR_TILE_IMPROVEMENT',	30);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- TERRACOTA ARMY
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_TERRACOTTA_ARMY';
	UPDATE Buildings SET IsNoWater = 1 WHERE Type = 'BUILDING_TERRACOTTA_ARMY';
	
	-- + IsNoCoast (lua)
	-- + Mine/Quarry(1) (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- BUDDHAS OF BAMYAN (NEW)
	UPDATE Buildings SET Cost = 200, PrereqTech = 'TECH_CONSTRUCTION', NumPoliciesNeeded = 4, MaxStartEra = 'ERA_MEDIEVAL' WHERE Type = 'BUILDING_BAMYAN';
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_BAMYAN';
	
	-- + Peace (lua)
	-- + Mountains(2) (lua)
	---------------------------------------------------------
	UPDATE Buildings SET ReligiousPressureModifier = 100, EnhancedYieldTech = 'TECH_ROCKETRY', DoFToVotes = 1 WHERE Type = 'BUILDING_BAMYAN';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,		YieldType,					Yield) 
	VALUES		('BUILDING_BAMYAN', 'YIELD_CULTURE',			1),
				('BUILDING_BAMYAN', 'YIELD_FAITH',				2);
	
	INSERT INTO Building_YieldPerFriend
				(BuildingType,		YieldType,		Yield) 
	VALUES		('BUILDING_BAMYAN', 'YIELD_FAITH',	2);
	
	INSERT INTO Building_YieldPerAlly
				(BuildingType,		YieldType,					Yield) 
	VALUES		('BUILDING_BAMYAN', 'YIELD_GOLDEN_AGE_POINTS',	3);

	INSERT INTO Building_TechEnhancedYieldChanges
				(BuildingType,		YieldType,					Yield) 
	VALUES		('BUILDING_BAMYAN', 'YIELD_CULTURE',			2),
				('BUILDING_BAMYAN', 'YIELD_GOLDEN_AGE_POINTS',	2);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,		FlavorType,				Flavor) 
	VALUES		('BUILDING_BAMYAN', 'FLAVOR_CULTURE',		30),
				('BUILDING_BAMYAN', 'FLAVOR_RELIGION',		60),
				('BUILDING_BAMYAN', 'FLAVOR_HAPPINESS',		40);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- GATE OF THE SUN (NEW)
	UPDATE Buildings SET Cost = 200, PrereqTech = 'TECH_CONSTRUCTION', NumPoliciesNeeded = 4, MaxStartEra = 'ERA_MEDIEVAL' WHERE Type = 'BUILDING_GATE_OF_SUN';
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_GATE_OF_SUN';

	UPDATE Buildings SET FreshWater = 1, Water = 1, MinAreaSize = 1, NearbyMountainRequired = 1 WHERE Type = 'BUILDING_GATE_OF_SUN';
	---------------------------------------------------------
	UPDATE Buildings SET GreatWorkSlotType = 'GREAT_WORK_SLOT_LITERATURE', GreatWorkCount = 1 WHERE Type = 'BUILDING_GATE_OF_SUN';
	
	INSERT INTO Building_YieldModifiers
				(BuildingType,					YieldType,			Yield) 
	VALUES		('BUILDING_GATE_OF_SUN_DUMMY',	'YIELD_SCIENCE',	5);

	INSERT INTO Building_YieldChanges 
				(BuildingType,				YieldType,			Yield) 
	VALUES		('BUILDING_GATE_OF_SUN',	'YIELD_CULTURE',	1),
				('BUILDING_GATE_OF_SUN',	'YIELD_SCIENCE',	1);

	INSERT INTO Building_TerrainYieldChanges 
				(BuildingType,				TerrainType,		YieldType,			Yield) 
	VALUES		('BUILDING_GATE_OF_SUN',	'TERRAIN_MOUNTAIN',	'YIELD_CULTURE',	1);
	
	INSERT INTO Building_LakePlotYieldChanges 
				(BuildingType,				YieldType,			Yield)
	VALUES		('BUILDING_GATE_OF_SUN',	'YIELD_CULTURE',	1);	
	
	INSERT INTO Building_GoldenAgeYieldMod 
				(BuildingType,				YieldType,			Yield)
	VALUES		('BUILDING_GATE_OF_SUN',	'YIELD_SCIENCE',	5);	
	
	INSERT INTO Building_BuildingClassYieldChanges 
				(BuildingType,				BuildingClassType,		YieldType,			YieldChange) 
	VALUES		('BUILDING_GATE_OF_SUN',	'BUILDINGCLASS_WALLS',	'YIELD_SCIENCE',	1);

	-- + science_per_city_with_walls (lua)
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,				FlavorType,				Flavor) 
	VALUES		('BUILDING_GATE_OF_SUN',	'FLAVOR_CULTURE',		30),
				('BUILDING_GATE_OF_SUN',	'FLAVOR_SCIENCE',		60);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- PARTHENON
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_PARTHENON';
	UPDATE Buildings SET Hill = 1, IsNoWater = 1, ProhibitedCityTerrain = 'TERRAIN_GRASS' WHERE Type = 'BUILDING_PARTHENON';
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- EL GHRIBA SYNAGOGUE (NEW)
	UPDATE Buildings SET Cost = 250, PrereqTech = 'TECH_DRAMA', NumPoliciesNeeded = 5, MaxStartEra = 'ERA_MEDIEVAL' WHERE Type = 'BUILDING_EL_GHRIBA';
	UPDATE Buildings SET WonderSplashAnchor = 'C,B' WHERE Type = 'BUILDING_EL_GHRIBA';

	UPDATE Buildings SET ProhibitedCityTerrain = 'TERRAIN_TUNDRA' WHERE Type = 'BUILDING_EL_GHRIBA';
	---------------------------------------------------------
	UPDATE Buildings SET FreeBuildingThisCity = 'BUILDINGCLASS_SYNAGOGUE', GreatWorkSlotType = 'GREAT_WORK_SLOT_ART_ARTIFACT', GreatWorkCount = 1, FreeGreatWork = 'GREAT_WORK_THE_ARK' WHERE Type = 'BUILDING_EL_GHRIBA';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,			Yield) 
	VALUES		('BUILDING_EL_GHRIBA',	'YIELD_CULTURE',	1),
				('BUILDING_EL_GHRIBA',	'YIELD_GOLD',		1),
				('BUILDING_EL_GHRIBA',	'YIELD_FAITH',		4);
	
	INSERT INTO Building_YieldFromFaithPurchase
				(BuildingType,			YieldType,			Yield) 
	VALUES		('BUILDING_EL_GHRIBA',	'YIELD_GOLD',		50);
	
	INSERT INTO GreatWorks
				(Type,					Description,					GreatWorkClassType,	Audio,							Image,									Quote) 
	VALUES		('GREAT_WORK_THE_ARK',	'TXT_KEY_GREAT_WORK_THE_ARK',	'GREAT_WORK_ART',	'AS2D_GREAT_ARTIST_ARTWORK',	'Great_Work_Ark_of_the_Covenant.dds',	'TXT_KEY_GREAT_WORK_THE_ARK_QUOTE');
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,			Flavor) 
	VALUES		('BUILDING_EL_GHRIBA',	'FLAVOR_CULTURE',	30),
				('BUILDING_EL_GHRIBA',	'FLAVOR_RELIGION',	50),
				('BUILDING_EL_GHRIBA',	'FLAVOR_GOLD',		30);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- ORACLE
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_ORACLE';
	UPDATE Buildings SET Hill = 1, NearbyMountainRequired = 1, ProhibitedCityTerrain = 'TERRAIN_GRASS' WHERE Type = 'BUILDING_ORACLE';
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- ETCHMIADZIN CATHEDRAL (NEW)
	UPDATE Buildings SET Cost = 250, PrereqTech = 'TECH_PHILOSOPHY', NumPoliciesNeeded = 5, MaxStartEra = 'ERA_MEDIEVAL' WHERE Type = 'BUILDING_ETCHMIADZIN';
	UPDATE Buildings SET WonderSplashAnchor = 'L,B' WHERE Type = 'BUILDING_ETCHMIADZIN';

	UPDATE Buildings SET NearbyTerrainRequired = 'TERRAIN_GRASS' WHERE Type = 'BUILDING_ETCHMIADZIN';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,				FeatureType) 
	VALUES		('BUILDING_ETCHMIADZIN',	'FEATURE_FOREST');
	
	-- + IsNoCoast (lua)
	---------------------------------------------------------
	UPDATE Buildings SET GreatWorkSlotType = 'GREAT_WORK_SLOT_ART_ARTIFACT', GreatWorkCount = 1, FreeGreatWork = 'GREAT_WORK_HOLY_LANCE'  WHERE Type = 'BUILDING_ETCHMIADZIN';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,				YieldType,					Yield) 
	VALUES		('BUILDING_ETCHMIADZIN',	'YIELD_GOLDEN_AGE_POINTS',	2),
				('BUILDING_ETCHMIADZIN',	'YIELD_FAITH',				2);
	
	INSERT INTO Building_YieldFromYieldPercent
				(BuildingType,				YieldIn,		YieldOut,					Value) 
	VALUES		('BUILDING_ETCHMIADZIN',	'YIELD_FAITH',	'YIELD_CULTURE',			10),
				('BUILDING_ETCHMIADZIN',	'YIELD_FAITH',	'YIELD_GOLDEN_AGE_POINTS',	10);
	
	INSERT INTO Building_GreatWorkYieldChanges
				(BuildingType,				YieldType,		Yield) 
	VALUES		('BUILDING_ETCHMIADZIN',	'YIELD_FAITH',	1);
	
	INSERT INTO GreatWorks
				(Type,						Description,						GreatWorkClassType,	Audio,							Image,							Quote) 
	VALUES		('GREAT_WORK_HOLY_LANCE',	'TXT_KEY_GREAT_WORK_HOLY_LANCE',	'GREAT_WORK_ART',	'AS2D_GREAT_ARTIST_ARTWORK',	'Great_Work_Holy_Lance.dds',	'TXT_KEY_GREAT_WORK_HOLY_LANCE_QUOTE');
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,				FlavorType,			Flavor) 
	VALUES		('BUILDING_ETCHMIADZIN',	'FLAVOR_CULTURE',	50),
				('BUILDING_ETCHMIADZIN',	'FLAVOR_RELIGION',	60),
				('BUILDING_ETCHMIADZIN',	'FLAVOR_HAPPINESS',	20);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- ANGKOR WAT
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_ANGKOR_WAT';
	UPDATE Buildings SET Flat = 1, FreshWater = 1, Water = 1, MinAreaSize = 1 WHERE Type = 'BUILDING_ANGKOR_WAT';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,				FeatureType) 
	VALUES		('BUILDING_ANGKOR_WAT',		'FEATURE_JUNGLE');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- GREAT WALL
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_GREAT_WALL';
	UPDATE Buildings SET Hill = 1, River = 1 WHERE Type = 'BUILDING_GREAT_WALL';
	
	-- + Deceptive/Hostile/War (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- CHAND BAORI (NEW)
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_CHAND_BAORI';
	UPDATE Buildings SET Cost = 250, PrereqTech = 'TECH_ENGINEERING', NumPoliciesNeeded = 5, MaxStartEra = 'ERA_MEDIEVAL' WHERE Type = 'BUILDING_CHAND_BAORI';
	
	UPDATE Buildings SET IsNoWater = 1, NearbyTerrainRequired = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_CHAND_BAORI';
	
	INSERT INTO Building_ClassesNeededInCity 
				(BuildingType,				BuildingClassType) 
	VALUES		('BUILDING_CHAND_BAORI',	'BUILDINGCLASS_WELL');
	---------------------------------------------------------
	UPDATE Buildings SET NoUnhappfromXSpecialists = 3, GreatPeopleRateModifier = 10, FreeGreatPeople = 1 WHERE Type = 'BUILDING_CHAND_BAORI';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,				YieldType,			Yield) 
	VALUES		('BUILDING_CHAND_BAORI',	'YIELD_FOOD',		2),
				('BUILDING_CHAND_BAORI',	'YIELD_GOLD',		1),
				('BUILDING_CHAND_BAORI',	'YIELD_CULTURE',	2);
	
	INSERT INTO Building_TerrainYieldChanges 
				(BuildingType,				TerrainType,		YieldType,		Yield) 
	VALUES		('BUILDING_CHAND_BAORI',	'TERRAIN_DESERT',	'YIELD_FOOD',	1);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,				FlavorType,				Flavor) 
	VALUES		('BUILDING_CHAND_BAORI',	'FLAVOR_GROWTH',		40),
				('BUILDING_CHAND_BAORI',	'FLAVOR_CULTURE',		20),
				('BUILDING_CHAND_BAORI',	'FLAVOR_GREAT_PEOPLE',	30),
				('BUILDING_CHAND_BAORI',	'FLAVOR_HAPPINESS',		20),
				('BUILDING_CHAND_BAORI',	'FLAVOR_GOLD',			10);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- COLOSSUS
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_COLOSSUS';
	UPDATE Buildings SET Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_COLOSSUS';
	
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType,			ResourceType) 
	VALUES		('BUILDING_COLOSSUS',	'RESOURCE_IRON'),
				('BUILDING_COLOSSUS',	'RESOURCE_COPPER');
--============================================--
-- MEDIEVAL ERA
--============================================--
-- UNIVERSITY OF SANKORE
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_MOSQUE_OF_DJENNE';
	UPDATE Buildings SET NearbyTerrainRequired = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_MOSQUE_OF_DJENNE';
	
	INSERT INTO Building_ClassesNeededInCity 
				(BuildingType,				BuildingClassType) 
	VALUES		('BUILDING_MOSQUE_OF_DJENNE',	'BUILDINGCLASS_LIBRARY');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- PROPHET'S MOSQUE (NEW)
	UPDATE Buildings SET Cost = 400, PrereqTech = 'TECH_EDUCATION', NumPoliciesNeeded = 7, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_NABAWI';
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_NABAWI';
	
	UPDATE Buildings SET IsNoWater = 1 WHERE Type = 'BUILDING_NABAWI';
	
	-- + IsNoCoast (lua)
	---------------------------------------------------------
	UPDATE Buildings SET FreeBuildingThisCity = 'BUILDINGCLASS_MOSQUE', GreatWorkSlotType = 'GREAT_WORK_SLOT_LITERATURE', GreatWorkCount = 2, ThemingBonusHelp = 'TXT_KEY_THEMING_BONUS_NABAWI_HELP' WHERE Type = 'BUILDING_NABAWI';

	INSERT INTO Building_YieldChanges 
				(BuildingType,		YieldType,			Yield)
	VALUES		('BUILDING_NABAWI', 'YIELD_CULTURE',	2),
				('BUILDING_NABAWI', 'YIELD_FAITH',		5);

	INSERT INTO Building_SpecificGreatPersonRateModifier
				(BuildingType,		SpecialistType,			Modifier)
	VALUES		('BUILDING_NABAWI', 'SPECIALIST_WRITER',	20);

	INSERT INTO Building_GlobalYieldModifiers
				(BuildingType,		YieldType,		Yield)
	VALUES		('BUILDING_NABAWI', 'YIELD_FAITH',	10);

	INSERT INTO Building_ThemingBonuses
				(BuildingType,		Description,					Bonus,	RequiresOwner,	AIPriority)
	VALUES		('BUILDING_NABAWI', 'TXT_KEY_THEMING_BONUS_NABAWI', 8,		1,				5);

	INSERT INTO Building_ThemingYieldBonus
				(BuildingType,		YieldType,					Yield)
	VALUES		('BUILDING_NABAWI', 'YIELD_GOLDEN_AGE_POINTS',	4),
				('BUILDING_NABAWI', 'YIELD_FAITH',				4);
	---------------------------------------------------------
	INSERT INTO Building_Flavors
				(BuildingType,		FlavorType,				Flavor)
	VALUES		('BUILDING_NABAWI', 'FLAVOR_CULTURE',		30),
				('BUILDING_NABAWI', 'FLAVOR_RELIGION',		70),
				('BUILDING_NABAWI', 'FLAVOR_GREAT_PEOPLE',	20);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- HAGIA SOPHIA
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_HAGIA_SOPHIA';
	UPDATE Buildings SET Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_HAGIA_SOPHIA';
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- BOROBUDUR
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_BOROBUDUR';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,			FeatureType) 
	VALUES		('BUILDING_BOROBUDUR',	'FEATURE_JUNGLE');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- LAVAUX (NEW)
	UPDATE Buildings SET Cost = 400, PrereqTech = 'TECH_THEOLOGY', NumPoliciesNeeded = 7, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_LAVAUX';
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_LAVAUX';
	
	UPDATE Buildings SET Hill = 1, FreshWater = 1, Water = 1, MinAreaSize = 1, NearbyTerrainRequired = 'TERRAIN_GRASS' WHERE Type = 'BUILDING_LAVAUX';
	---------------------------------------------------------
	UPDATE Buildings SET EmpireNeedsModifierGlobal = -10 WHERE Type = 'BUILDING_LAVAUX';
	UPDATE Buildings SET ResourceQuantityToPlace = 1 WHERE Type = 'BUILDING_LAVAUX';

	INSERT INTO Building_YieldChanges 
				(BuildingType,		YieldType,		Yield)
	VALUES		('BUILDING_LAVAUX', 'YIELD_FOOD',	2),
				('BUILDING_LAVAUX', 'YIELD_GOLD',	1);

	INSERT INTO Building_LakePlotYieldChanges 
				(BuildingType,		YieldType,		Yield)
	VALUES		('BUILDING_LAVAUX',	'YIELD_FOOD',	1);	
	
	INSERT INTO Building_ResourceYieldChanges 
				(BuildingType,		ResourceType,		YieldType,		Yield) 
	VALUES		('BUILDING_LAVAUX',	'RESOURCE_WINE',	'YIELD_FOOD',	1),
				('BUILDING_LAVAUX',	'RESOURCE_WINE',	'YIELD_GOLD',	1),
				('BUILDING_LAVAUX',	'RESOURCE_WINE',	'YIELD_FAITH',	1);

	INSERT INTO Building_ResourcePlotsToPlace
				(BuildingType,		ResourceType,		NumPlots) 
	VALUES		('BUILDING_LAVAUX',	'RESOURCE_WINE',	2);
	---------------------------------------------------------
	INSERT INTO Building_Flavors
				(BuildingType,		FlavorType,				Flavor)
	VALUES		('BUILDING_LAVAUX', 'FLAVOR_GROWTH',		50),
				('BUILDING_LAVAUX', 'FLAVOR_GOLD',			40),
				('BUILDING_LAVAUX', 'FLAVOR_HAPPINESS',		60),
				('BUILDING_LAVAUX', 'FLAVOR_RELIGION',		10);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- ALHAMBRA
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_ALHAMBRA';
	UPDATE Buildings SET Hill = 1 WHERE Type = 'BUILDING_ALHAMBRA';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,			FeatureType) 
	VALUES		('BUILDING_ALHAMBRA',	'FEATURE_FOREST');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- WARTBURG (NEW)
	UPDATE Buildings SET Cost = 400, PrereqTech = 'TECH_CHIVALRY', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_WARTBURG';
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_WARTBURG';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,			FeatureType) 
	VALUES		('BUILDING_WARTBURG',	'FEATURE_FOREST');
	
	INSERT INTO Building_ClassesNeededInCity 
				(BuildingType,			BuildingClassType) 
	VALUES		('BUILDING_WARTBURG',	'BUILDINGCLASS_WRITERS_GUILD');
	---------------------------------------------------------
	UPDATE Buildings SET Defense = 1000, SpecialistType = 'SPECIALIST_WRITER', GreatPeopleRateChange = 2, GreatWorkSlotType = 'GREAT_WORK_SLOT_LITERATURE', GreatWorkCount = 3, ThemingBonusHelp = 'TXT_KEY_THEMING_BONUS_WARTBURG_HELP' WHERE Type = 'BUILDING_WARTBURG';

	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,					Yield) 
	VALUES		('BUILDING_WARTBURG',	'YIELD_CULTURE',			1),
				('BUILDING_WARTBURG',	'YIELD_GOLDEN_AGE_POINTS',	1);
	
	INSERT INTO Building_SpecificGreatPersonRateModifier 
				(BuildingType,			SpecialistType,			Modifier)
	VALUES		('BUILDING_WARTBURG',	'SPECIALIST_WRITER',	30);

	INSERT INTO Building_BuildingClassYieldChanges 
				(BuildingType,			BuildingClassType,				YieldType,		YieldChange) 
	VALUES		('BUILDING_WARTBURG',	'BUILDINGCLASS_WRITERS_GUILD',	'YIELD_FAITH',	1);

	INSERT INTO Building_ThemingBonuses 
				(BuildingType,			Description,						Bonus,	RequiresOwner,	AIPriority)
	VALUES		('BUILDING_WARTBURG',	'TXT_KEY_THEMING_BONUS_WARTBURG',	8,		1,				5);

	INSERT INTO Building_DomainFreeExperiencePerGreatWork
				(BuildingType,			DomainType,		Experience)
	VALUES		('BUILDING_WARTBURG',	'DOMAIN_LAND',	10);

	INSERT INTO Building_ThemingYieldBonus 
				(BuildingType,			YieldType,					Yield) 
	VALUES		('BUILDING_WARTBURG',	'YIELD_CULTURE',			3),
				('BUILDING_WARTBURG',	'YIELD_FAITH',				3),
				('BUILDING_WARTBURG',	'YIELD_GOLDEN_AGE_POINTS',	3);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor)
	VALUES		('BUILDING_WARTBURG',	'FLAVOR_CULTURE',		30),
				('BUILDING_WARTBURG',	'FLAVOR_GREAT_PEOPLE',	60),
				('BUILDING_WARTBURG',	'FLAVOR_RELIGION',		30);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- MACHU PICCHU
	UPDATE Buildings SET WonderSplashAnchor = 'L,T' WHERE Type = 'BUILDING_MACHU_PICHU';
	UPDATE Buildings SET Hill = 1, NearbyMountainRequired = 0 WHERE Type = 'BUILDING_MACHU_PICHU';
	
	-- + Mountains(2) (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- GREAT ZIMBABWE (NEW)
	UPDATE Buildings SET Cost = 400, PrereqTech = 'TECH_PHYSICS', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_GREAT_ZIMBABWE';
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_GREAT_ZIMBABWE';
	
	-- + IsNoCoast (lua)
	-- + Mine/Camp(3) (lua)
	---------------------------------------------------------
	UPDATE Buildings SET Defense = 1000, GlobalPlotBuyCostModifier = -30, NumTradeRouteBonus = 1 WHERE Type = 'BUILDING_GREAT_ZIMBABWE';

	INSERT INTO Building_YieldChanges 
				(BuildingType,						YieldType,					Yield)
	VALUES		('BUILDING_GREAT_ZIMBABWE',			'YIELD_FAITH',				1),
				('BUILDING_GREAT_ZIMBABWE',			'YIELD_GOLD',				1),
				('BUILDING_GREAT_ZIMBABWE',			'YIELD_CULTURE',			1),
				('BUILDING_GREAT_ZIMBABWE_DUMMY',	'YIELD_GOLDEN_AGE_POINTS',	2);
	
	INSERT INTO Building_DomainFreeExperiencesGlobal
				(BuildingType,						DomainType,		Experience)
	VALUES		('BUILDING_GREAT_ZIMBABWE_DUMMY',	'DOMAIN_LAND',	2),
				('BUILDING_GREAT_ZIMBABWE_DUMMY',	'DOMAIN_AIR',	2),
				('BUILDING_GREAT_ZIMBABWE_DUMMY',	'DOMAIN_SEA',	2);
	---------------------------------------------------------
	INSERT INTO Building_Flavors
				(BuildingType,				FlavorType,				Flavor)
	VALUES		('BUILDING_GREAT_ZIMBABWE',	'FLAVOR_GOLD',			50),
				('BUILDING_GREAT_ZIMBABWE',	'FLAVOR_RELIGION',		10),
				('BUILDING_GREAT_ZIMBABWE',	'FLAVOR_CULTURE',		10),
				('BUILDING_GREAT_ZIMBABWE',	'FLAVOR_EXPANSION',		40);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- AHU TONGARIKI (NEW)
	UPDATE Buildings SET Cost = 400, PrereqTech = 'TECH_PHYSICS', NumPoliciesNeeded = 7, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_AHU';
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_AHU';
	UPDATE Buildings SET Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_AHU';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,		FeatureType) 
	VALUES		('BUILDING_AHU',	'FEATURE_FOREST'),
				('BUILDING_AHU',	'FEATURE_JUNGLE');
	
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType,		ResourceType) 
	VALUES		('BUILDING_AHU',	'RESOURCE_STONE');
	---------------------------------------------------------
	UPDATE Buildings SET WorkerSpeedModifier = 20 WHERE Type = 'BUILDING_AHU';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,		YieldType,		Yield)
	VALUES		('BUILDING_AHU',	'YIELD_FAITH',	3),
				('BUILDING_AHU',	'YIELD_FOOD',	1);
	
	INSERT INTO Building_GlobalYieldModifiers
				(BuildingType,		YieldType,		Yield)
	VALUES		('BUILDING_AHU',	'YIELD_FAITH',	10);

	INSERT INTO Building_ResourceQuantity
				(BuildingType,		ResourceType,		Quantity) 
	VALUES		('BUILDING_AHU',	'RESOURCE_TERN',	1);
	
	INSERT INTO Building_ImprovementYieldChangesGlobal
				(BuildingType,		ImprovementType,		YieldType,			Yield) 
	VALUES		('BUILDING_AHU',	'IMPROVEMENT_QUARRY',	'YIELD_CULTURE',	1);

	INSERT INTO Building_TerrainYieldChanges 
				(BuildingType,		TerrainType,		YieldType,		Yield) 
	VALUES		('BUILDING_AHU',	'TERRAIN_COAST',	'YIELD_FAITH',	1);
	
	INSERT INTO Building_FeatureYieldChanges
				(BuildingType,		FeatureType,		YieldType,				Yield) 
	VALUES		('BUILDING_AHU',	'FEATURE_FOREST',	'YIELD_PRODUCTION',		1),
				('BUILDING_AHU',	'FEATURE_JUNGLE',	'YIELD_PRODUCTION',		1);
	---------------------------------------------------------
	INSERT INTO Building_Flavors
				(BuildingType,		FlavorType,				Flavor)
	VALUES		('BUILDING_AHU',	'FLAVOR_CULTURE',		20),
				('BUILDING_AHU',	'FLAVOR_PRODUCTION',	50),
				('BUILDING_AHU',	'FLAVOR_RELIGION',		30),
				('BUILDING_AHU',	'FLAVOR_HAPPINESS',		20);
	---------------------------------------------------------
	INSERT INTO Resources 
				(Type,				TechReveal,		TechCityTrade, 		Description,				Civilopedia, 					Help,								ResourceClassType, 		IsMonopoly, 	ArtDefineTag, 							CivilizationType,		OnlyMinorCivs,  Happiness,  ResourceUsage,	IconString, 		PortraitIndex, 	IconAtlas)
	VALUES		('RESOURCE_TERN',	null,			null,				'TXT_KEY_RESOURCE_TERN',	'TXT_KEY_RESOURCE_TERN_TEXT',	'TXT_KEY_RESOURCE_MONOPOLY_TERN',	'RESOURCECLASS_LUXURY',	1,				'ART_DEF_RESOURCE_MORE_WONDERS_TERN',	null,					0,				2,			2,				'[ICON_RES_TERN]',	0, 				'RESOURCE_MORE_WONDERS_ATLAS');

	INSERT INTO Resource_Flavors 	
				(ResourceType, 		FlavorType, 			Flavor)
	VALUES		('RESOURCE_TERN',	'FLAVOR_GROWTH',		10),
				('RESOURCE_TERN',	'FLAVOR_RELIGION',		50);
	---------------------------------------------------------
	INSERT INTO IconTextureAtlases 
				(Atlas, 							IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
	VALUES		('RESOURCE_MORE_WONDERS_ATLAS', 	256, 		'ResourceMoreWondersIcon_256.dds',		1, 				1),
				('RESOURCE_MORE_WONDERS_ATLAS', 	128, 		'ResourceMoreWondersIcon_128.dds',		1, 				1),
				('RESOURCE_MORE_WONDERS_ATLAS', 	80, 		'ResourceMoreWondersIcon_80.dds',		1, 				1),
				('RESOURCE_MORE_WONDERS_ATLAS', 	64, 		'ResourceMoreWondersIcon_64.dds',		1, 				1),
				('RESOURCE_MORE_WONDERS_ATLAS', 	45, 		'ResourceMoreWondersIcon_45.dds',		1, 				1),
				('RESOURCE_MORE_WONDERS_ATLAS', 	32, 		'ResourceMoreWondersIcon_32.dds',		1,				1);	
	---------------------------------------------------------
	INSERT INTO ArtDefine_StrategicView
				(StrategicViewType, 					TileType, 		Asset)
	VALUES 		('ART_DEF_RESOURCE_MORE_WONDERS_TERN', 	'Resource', 	'ResourceMoreWondersIcon_256f.dds');

	INSERT INTO ArtDefine_LandmarkTypes
				(Type, 									LandmarkType, 	FriendlyName)
	VALUES 		('ART_DEF_RESOURCE_MORE_WONDERS_TERN', 	'Resource', 	'MORE_WONDERS_TERN');
	---------------------------------------------------------
	INSERT INTO IconFontTextures 
				(IconFontTexture, 							IconFontTextureFile)
	VALUES		('RESOURCE_MORE_WONDERS_TEXTURE_ATLAS', 	'TernFontIcon_022');

	INSERT INTO IconFontMapping 
				(IconName, 			IconFontTexture,						IconMapping)
	VALUES		('ICON_RES_TERN', 	'RESOURCE_MORE_WONDERS_TEXTURE_ATLAS',	1);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- FALUN MINE (NEW)
	UPDATE Buildings SET Cost = 400, PrereqTech = 'TECH_STEEL', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_FALUN';
	UPDATE Buildings SET WonderSplashAnchor = 'L,B' WHERE Type = 'BUILDING_FALUN';
	
	-- + Mine(4) (lua)
	---------------------------------------------------------
	UPDATE Buildings SET ResourceQuantityToPlace = 1 WHERE Type = 'BUILDING_FALUN';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,		YieldType,					Yield)
	VALUES		('BUILDING_FALUN',	'YIELD_PRODUCTION',			1),
				('BUILDING_FALUN',	'YIELD_GOLDEN_AGE_POINTS',	1);

	INSERT INTO Building_ResourceYieldChanges
				(BuildingType,		ResourceType,		YieldType,					Yield) 
	VALUES		('BUILDING_FALUN',	'RESOURCE_COPPER',	'YIELD_GOLDEN_AGE_POINTS',	1),
				('BUILDING_FALUN',	'RESOURCE_COPPER',	'YIELD_GOLD',				1);

	INSERT INTO Building_ImprovementYieldChanges
				(BuildingType,		ImprovementType,	YieldType,		Yield) 
	VALUES		('BUILDING_FALUN',	'IMPROVEMENT_MINE',	'YIELD_GOLD',	1);

	INSERT INTO Building_ResourcePlotsToPlace
				(BuildingType,		ResourceType,		NumPlots) 
	VALUES		('BUILDING_FALUN',	'RESOURCE_COPPER',	2);
	
	INSERT INTO Building_FreeUnits 
				(BuildingType,		UnitType,				NumUnits) 
	VALUES		('BUILDING_FALUN',	'UNIT_GREAT_GENERAL',	1);
	
	INSERT INTO Building_GreatPersonProgressFromConstruction
				(BuildingType,		GreatPersonType,		EraType,			Value) 
	VALUES		('BUILDING_FALUN',	'GREATPERSON_ENGINEER',	'ERA_CLASSICAL',	2);
	---------------------------------------------------------
	INSERT INTO Building_Flavors
				(BuildingType,		FlavorType,				Flavor)
	VALUES		('BUILDING_FALUN',	'FLAVOR_GOLD',			40),
				('BUILDING_FALUN',	'FLAVOR_PRODUCTION',	10),
				('BUILDING_FALUN',	'FLAVOR_HAPPINESS',		50),
				('BUILDING_FALUN',	'FLAVOR_GREAT_PEOPLE',	40);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- FORGE OF DAMASCUS (NEW)
	UPDATE Buildings SET Cost = 400, PrereqTech = 'TECH_STEEL', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_DAMASCUS';
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_DAMASCUS';
	
	UPDATE Buildings SET FreshWater = 1 WHERE Type = 'BUILDING_DAMASCUS';
	
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType,			ResourceType) 
	VALUES		('BUILDING_DAMASCUS',	'RESOURCE_IRON');
	
	-- + LumberMill(1) (lua)
	---------------------------------------------------------
	UPDATE Buildings SET FreeBuildingThisCity = 'BUILDINGCLASS_FORGE', FreePromotion = 'PROMOTION_DAMASCUS', SpecialistType = 'SPECIALIST_SCIENTIST', GreatPeopleRateChange = 1, EnhancedYieldTech = 'TECH_METALLURGY' WHERE Type = 'BUILDING_DAMASCUS';

	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,			Yield)
	VALUES		('BUILDING_DAMASCUS',	'YIELD_PRODUCTION',	2),
				('BUILDING_DAMASCUS',	'YIELD_SCIENCE',	2);

	INSERT INTO Building_TechEnhancedYieldChanges
				(BuildingType,			YieldType,			Yield)
	VALUES		('BUILDING_DAMASCUS',	'YIELD_PRODUCTION', 3);

	INSERT INTO Building_ResourceYieldChangesGlobal
				(BuildingType,			ResourceType,		YieldType,			Yield) 
	VALUES		('BUILDING_DAMASCUS',	'RESOURCE_IRON',	'YIELD_PRODUCTION', 1),
				('BUILDING_DAMASCUS',	'RESOURCE_IRON',	'YIELD_SCIENCE',	1);

	INSERT INTO UnitPromotions 
				(Type,					Description,					Help,								Sound,				CannotBeChosen, LostWithUpgrade,	AttackMod,	PortraitIndex,	IconAtlas,						PediaType,		PediaEntry) 
	VALUES		('PROMOTION_DAMASCUS',	'TXT_KEY_PROMOTION_DAMASCUS',	'TXT_KEY_PROMOTION_DAMASCUS_HELP',	'AS2D_IF_LEVELUP',	1,				1,					20,			0,				'PROMOTION_MORE_WONDERS_ATLAS',	'PEDIA_SHARED', 'TXT_KEY_PROMOTION_DAMASCUS');

	INSERT INTO UnitPromotions_UnitCombats
				(PromotionType,			UnitCombatType)
	VALUES		('PROMOTION_DAMASCUS',	'UNITCOMBAT_MELEE'),
				('PROMOTION_DAMASCUS',	'UNITCOMBAT_MOUNTED');
	---------------------------------------------------------
	INSERT INTO Building_Flavors
				(BuildingType,			FlavorType,				Flavor)
	VALUES		('BUILDING_DAMASCUS',	'FLAVOR_DEFENSE',		10),
				('BUILDING_DAMASCUS',	'FLAVOR_OFFENSE',		40),
				('BUILDING_DAMASCUS',	'FLAVOR_PRODUCTION',	50),
				('BUILDING_DAMASCUS',	'FLAVOR_SCIENCE',		30);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- FORBIDDEN PALACE
	UPDATE Buildings SET WonderSplashAnchor = 'L,B' WHERE Type = 'BUILDING_FORBIDDEN_PALACE';
	UPDATE Buildings SET Capital = 1 WHERE Type = 'BUILDING_FORBIDDEN_PALACE';
	
	INSERT INTO Building_ClassesNeededInCity 
				(BuildingType,					BuildingClassType) 
	VALUES		('BUILDING_FORBIDDEN_PALACE',	'BUILDINGCLASS_WALLS');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- CATHEDRAL OF ST. BASIL
	UPDATE Buildings SET WonderSplashAnchor = 'C,C', WonderSplashImage = 'Wonder_Kremlin_splash.dds' WHERE Type = 'BUILDING_KREMLIN';
	UPDATE Buildings SET ProhibitedCityTerrain = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_KREMLIN';
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- GOLDEN DAGON PAGODA (NEW)
	UPDATE Buildings SET Cost = 500, PrereqTech = 'TECH_GUILDS', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_SHWEDAGON';
	UPDATE Buildings SET WonderSplashAnchor = 'L,B' WHERE Type = 'BUILDING_SHWEDAGON';
	
	UPDATE Buildings SET Hill = 1, FreshWater = 1 WHERE Type = 'BUILDING_SHWEDAGON';
	---------------------------------------------------------
	UPDATE Buildings SET GreatWorkSlotType = 'GREAT_WORK_SLOT_ART_ARTIFACT', GreatWorkCount = 4, ThemingBonusHelp = 'TXT_KEY_THEMING_BONUS_SHWEDAGON_HELP', SpecialistType = 'SPECIALIST_ARTIST', GreatPeopleRateChange = 1 WHERE Type = 'BUILDING_SHWEDAGON';

	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,			Yield) 
	VALUES		('BUILDING_SHWEDAGON',	'YIELD_GOLD',		2),
				('BUILDING_SHWEDAGON',	'YIELD_CULTURE',	2);
	
	INSERT INTO Building_SpecificGreatPersonRateModifier 
				(BuildingType,			SpecialistType,			Modifier)
	VALUES		('BUILDING_SHWEDAGON',	'SPECIALIST_ARTIST',	33);

	INSERT INTO Building_SpecialistYieldChanges
				(BuildingType,			SpecialistType,			YieldType,			Yield) 
	VALUES		('BUILDING_SHWEDAGON',	'SPECIALIST_ARTIST',	'YIELD_FAITH',		2);

	INSERT INTO Building_ThemingBonuses 
				(BuildingType,			Description,						Bonus,	MustBeArtifact,	RequiresOwner,	AIPriority)
	VALUES		('BUILDING_SHWEDAGON',	'TXT_KEY_THEMING_BONUS_SHWEDAGON',	16,		1,				1,				5);

	INSERT INTO Building_GreatWorkYieldChanges
				(BuildingType,			YieldType,		Yield) 
	VALUES		('BUILDING_SHWEDAGON',	'YIELD_GOLD',	1);
	
	INSERT INTO Building_ThemingYieldBonus 
				(BuildingType,			YieldType,			Yield) 
	VALUES		('BUILDING_SHWEDAGON',	'YIELD_CULTURE',	3),
				('BUILDING_SHWEDAGON',	'YIELD_FAITH',		3),
				('BUILDING_SHWEDAGON',	'YIELD_GOLD',		3),
				('BUILDING_SHWEDAGON',	'YIELD_TOURISM',	3);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor)
	VALUES		('BUILDING_SHWEDAGON',	'FLAVOR_CULTURE',		50),
				('BUILDING_SHWEDAGON',	'FLAVOR_GREAT_PEOPLE',	40),
				('BUILDING_SHWEDAGON',	'FLAVOR_GOLD',			20),
				('BUILDING_SHWEDAGON',	'FLAVOR_RELIGION',		40);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- MONT SAINT-MICHEL (NEW)
	UPDATE Buildings SET Cost = 500, PrereqTech = 'TECH_GUILDS', NumPoliciesNeeded = 8, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_MICHEL';
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_MICHEL';
	
	-- + OneTileCity (lua)
	---------------------------------------------------------
	UPDATE Buildings SET FreeBuildingThisCity = 'BUILDINGCLASS_MONASTERY', ExtraCityHitPoints = 200, Defense = 1000, EnhancedYieldTech = 'TECH_ELECTRICITY', TechEnhancedTourism = 3 WHERE Type = 'BUILDING_MICHEL';

	INSERT INTO Building_TechEnhancedYieldChanges
				(BuildingType,		YieldType,		Yield) 
	VALUES		('BUILDING_MICHEL',	'YIELD_GOLD',	3);

	INSERT INTO Building_YieldChanges 
				(BuildingType,		YieldType,					Yield) 
	VALUES		('BUILDING_MICHEL',	'YIELD_GOLD',				2),
				('BUILDING_MICHEL',	'YIELD_GOLDEN_AGE_POINTS',	2);
	
	INSERT INTO Building_YieldChangesPerPop 
				(BuildingType,		YieldType,		Yield) 
	VALUES		('BUILDING_MICHEL', 'YIELD_FAITH',	40);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,		FlavorType,				Flavor) 
	VALUES		('BUILDING_MICHEL', 'FLAVOR_GOLD',			40),
				('BUILDING_MICHEL', 'FLAVOR_HAPPINESS',		20),
				('BUILDING_MICHEL', 'FLAVOR_RELIGION',		30),
				('BUILDING_MICHEL', 'FLAVOR_CITY_DEFENSE',	10),
				('BUILDING_MICHEL', 'FLAVOR_CULTURE',		10);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- ITSUKUSHIMA SHRINE (NEW)
	UPDATE Buildings SET Cost = 500, PrereqTech = 'TECH_COMPASS', NumPoliciesNeeded = 8, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_ITSUKUSHIMA';
	UPDATE Buildings SET WonderSplashAnchor = 'R,C' WHERE Type = 'BUILDING_ITSUKUSHIMA';
	
	UPDATE Buildings SET Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_ITSUKUSHIMA';

	INSERT INTO Building_LocalResourceOrs 
				(BuildingType,				ResourceType) 
	VALUES		('BUILDING_ITSUKUSHIMA',	'RESOURCE_CORAL'),
				('BUILDING_ITSUKUSHIMA',	'RESOURCE_CRAB'),
				('BUILDING_ITSUKUSHIMA',	'RESOURCE_PEARLS'),
				('BUILDING_ITSUKUSHIMA',	'RESOURCE_WHALE');
	---------------------------------------------------------
	UPDATE Buildings SET PlotCultureCostModifier = -50 WHERE Type = 'BUILDING_ITSUKUSHIMA_DUMMY';

	INSERT INTO Building_YieldChanges 
				(BuildingType,				YieldType,			Yield)
	VALUES		('BUILDING_ITSUKUSHIMA',	'YIELD_CULTURE',	2);

	INSERT INTO Building_ResourceYieldChanges 
				(BuildingType,				ResourceType,		YieldType,		Yield) 
	VALUES		('BUILDING_ITSUKUSHIMA',	'RESOURCE_CORAL',	'YIELD_FAITH',	2),
				('BUILDING_ITSUKUSHIMA',	'RESOURCE_CRAB',	'YIELD_FAITH',	2),
				('BUILDING_ITSUKUSHIMA',	'RESOURCE_PEARLS',	'YIELD_FAITH',	2),
				('BUILDING_ITSUKUSHIMA',	'RESOURCE_WHALE',	'YIELD_FAITH',	2);

	INSERT INTO Building_ImprovementYieldChangesGlobal 
				(BuildingType,				ImprovementType,				YieldType,		Yield) 
	VALUES		('BUILDING_ITSUKUSHIMA',	'IMPROVEMENT_FISHING_BOATS',	'YIELD_CULTURE',	1);

	INSERT INTO Building_SeaPlotYieldChanges 
				(BuildingType,				YieldType,		Yield) 
	VALUES		('BUILDING_ITSUKUSHIMA',	'YIELD_FAITH',	1);
	
	INSERT INTO Building_FeatureYieldChanges
				(BuildingType,					FeatureType,		YieldType,			Yield) 
	VALUES		('BUILDING_ITSUKUSHIMA_DUMMY',	'FEATURE_ATOLL',	'YIELD_CULTURE',	1),
				('BUILDING_ITSUKUSHIMA_DUMMY',	'FEATURE_ATOLL',	'YIELD_FOOD',		1),
				('BUILDING_ITSUKUSHIMA_DUMMY',	'FEATURE_ATOLL',	'YIELD_FAITH',		1);

	-- + increased_border_growth_in_coastal_cities (lua)
	-- + boost_in_coastal_cities_to_atolls (lua)
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,				FlavorType,					Flavor) 
	VALUES		('BUILDING_ITSUKUSHIMA',	'FLAVOR_CULTURE',			60),
				('BUILDING_ITSUKUSHIMA',	'FLAVOR_RELIGION',			60),
				('BUILDING_ITSUKUSHIMA',	'FLAVOR_TILE_IMPROVEMENT',	20),
				('BUILDING_ITSUKUSHIMA',	'FLAVOR_EXPANSION',			10),
				('BUILDING_ITSUKUSHIMA',	'FLAVOR_GROWTH',			10);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- QALHAT (NEW)
	UPDATE Buildings SET Cost = 500, PrereqTech = 'TECH_COMPASS', NumPoliciesNeeded = 8, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_QALHAT';
	UPDATE Buildings SET WonderSplashAnchor = 'R,C' WHERE Type = 'BUILDING_QALHAT';
	
	UPDATE Buildings SET Hill = 1, Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_QALHAT';
	
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType,		ResourceType) 
	VALUES		('BUILDING_QALHAT',	'RESOURCE_HORSE');
	---------------------------------------------------------
	UPDATE Buildings SET NumTradeRouteBonus = 1, TradeRouteSeaGoldBonus = 100, TradeRouteSeaDistanceModifier = 100 WHERE Type = 'BUILDING_QALHAT';

	INSERT INTO Building_YieldChanges 
				(BuildingType,				YieldType,			Yield)
	VALUES		('BUILDING_QALHAT',			'YIELD_GOLD',		3),
				('BUILDING_QALHAT_DUMMY',	'YIELD_CULTURE',	2);

	INSERT INTO Building_ResourceYieldChanges
				(BuildingType,		ResourceType,		YieldType,		Yield) 
	VALUES		('BUILDING_QALHAT',	'RESOURCE_HORSE',	'YIELD_GOLD',	2);

	INSERT INTO Building_UnitCombatProductionModifiers 	
				(BuildingType,		UnitCombatType,		Modifier) 
	VALUES		('BUILDING_QALHAT', 'UNITCOMBAT_CARGO',	50);

	-- + culture_for_each_sea_trade_route_to_other_major_civ (lua)
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,		FlavorType,					Flavor) 
	VALUES		('BUILDING_QALHAT',	'FLAVOR_CULTURE',			30),
				('BUILDING_QALHAT',	'FLAVOR_GOLD',				50),
				('BUILDING_QALHAT',	'FLAVOR_I_SEA_TRADE_ROUTE',	60),
				('BUILDING_QALHAT',	'FLAVOR_PRODUCTION',		10);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- NOTRE DAME
	UPDATE Buildings SET NumPoliciesNeeded = 0 WHERE Type = 'BUILDING_NOTRE_DAME';
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_NOTRE_DAME';
	UPDATE Buildings SET River = 1, Flat = 1 WHERE Type = 'BUILDING_NOTRE_DAME';
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- KRAK DES CHEVALIERS (NEW)
	UPDATE Buildings SET Cost = 500, PrereqTech = 'TECH_MACHINERY', NumPoliciesNeeded = 8, MaxStartEra = 'ERA_RENAISSANCE' WHERE Type = 'BUILDING_CHEVALIERS';
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_CHEVALIERS';
	
	UPDATE Buildings SET Hill = 1, IsNoWater = 1 WHERE Type = 'BUILDING_CHEVALIERS';
	
	-- + IsNoCoast (lua)
	---------------------------------------------------------
	UPDATE Buildings SET Defense = 3000, CitySupplyFlat = 1, FoodKept = 10 WHERE Type = 'BUILDING_CHEVALIERS';
	UPDATE Buildings SET Defense = 500, CitySupplyFlat = 1 WHERE Type = 'BUILDING_CHEVALIERS_DUMMY';

	INSERT INTO Building_YieldChanges 
				(BuildingType,					YieldType,			Yield)
	VALUES		('BUILDING_CHEVALIERS',			'YIELD_FOOD',		1),
				('BUILDING_CHEVALIERS',			'YIELD_PRODUCTION', 1),
				('BUILDING_CHEVALIERS',			'YIELD_FAITH',		1),
				('BUILDING_CHEVALIERS_DUMMY',	'YIELD_FAITH',		1);

	INSERT INTO Building_UnitCombatProductionModifiers 	
				(BuildingType,			UnitCombatType,			Modifier) 
	VALUES		('BUILDING_CHEVALIERS', 'UNITCOMBAT_MOUNTED',	20),
				('BUILDING_CHEVALIERS', 'UNITCOMBAT_SIEGE',		20);

	INSERT INTO Building_FreeUnits 
				(BuildingType,			UnitType,				NumUnits)
	VALUES		('BUILDING_CHEVALIERS', 'UNIT_GREAT_GENERAL',	1);

	-- + bonuses_in_non-coastal_cities (lua)
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor)
	VALUES		('BUILDING_CHEVALIERS', 'FLAVOR_CITY_DEFENSE',	60),
				('BUILDING_CHEVALIERS', 'FLAVOR_OFFENSE',		30),
				('BUILDING_CHEVALIERS', 'FLAVOR_RELIGION',		20),
				('BUILDING_CHEVALIERS', 'FLAVOR_PRODUCTION',	20),
				('BUILDING_CHEVALIERS', 'FLAVOR_GROWTH',		10);
--============================================--
-- RENAISSANCE ERA
--============================================--
-- AIT BENHADDOU (NEW)
	UPDATE Buildings SET Cost = 800, PrereqTech = 'TECH_BANKING', NumPoliciesNeeded = 10, MaxStartEra = 'ERA_INDUSTRIAL' WHERE Type = 'BUILDING_BENHADDOU';
	UPDATE Buildings SET WonderSplashAnchor = 'L,T' WHERE Type = 'BUILDING_BENHADDOU';
	
	UPDATE Buildings SET Hill = 1, IsNoWater = 1, NearbyTerrainRequired = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_BENHADDOU';

	-- + IsNoCoast (lua)
	---------------------------------------------------------
	UPDATE Buildings SET NumTradeRouteBonus = 1, EnhancedYieldTech = 'TECH_RADIO', TechEnhancedTourism = 4 WHERE Type = 'BUILDING_BENHADDOU';

	INSERT INTO Building_YieldChanges 
				(BuildingType,				YieldType,			Yield)
	VALUES		('BUILDING_BENHADDOU',		'YIELD_FOOD',		2),
				('BUILDING_BENHADDOU',		'YIELD_GOLD',		2),
				('BUILDING_BENHADDOU',		'YIELD_CULTURE',	2);

	INSERT INTO Building_RiverPlotYieldChanges
				(BuildingType,			YieldType,		Yield) 
	VALUES		('BUILDING_BENHADDOU',	'YIELD_FOOD',	1);
	
	INSERT INTO Building_ImprovementYieldChanges
				(BuildingType,			ImprovementType,			YieldType,			Yield) 
	VALUES		('BUILDING_BENHADDOU',	'IMPROVEMENT_TRADING_POST',	'YIELD_TOURISM',	3),
				('BUILDING_BENHADDOU',	'IMPROVEMENT_TRADING_POST',	'YIELD_GOLD',		3);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor)
	VALUES		('BUILDING_BENHADDOU',	'FLAVOR_CULTURE',		60),
				('BUILDING_BENHADDOU',	'FLAVOR_GROWTH',		30),
				('BUILDING_BENHADDOU',	'FLAVOR_GOLD',			30);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- KILWA KISIWANI (NEW)
	UPDATE Buildings SET Cost = 800, PrereqTech = 'TECH_BANKING', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_INDUSTRIAL' WHERE Type = 'BUILDING_KILWA_KISIWANI';
	UPDATE Buildings SET WonderSplashAnchor = 'C,B' WHERE Type = 'BUILDING_KILWA_KISIWANI';
	
	UPDATE Buildings SET Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_KILWA_KISIWANI';

	-- + Mine/Camp(3) (lua)
	---------------------------------------------------------
	UPDATE Buildings SET NumTradeRouteBonus = 2 WHERE Type = 'BUILDING_KILWA_KISIWANI';

	INSERT INTO Building_YieldChanges 
				(BuildingType,				YieldType,			Yield)
	VALUES		('BUILDING_KILWA_KISIWANI',	'YIELD_GOLD',		2);

	INSERT INTO Building_ResourceQuantity
				(BuildingType,				ResourceType,			Quantity) 
	VALUES		('BUILDING_KILWA_KISIWANI',	'RESOURCE_PORCELAIN',	1),
				('BUILDING_KILWA_KISIWANI',	'RESOURCE_JEWELRY',		1);

	INSERT INTO Building_ResourceYieldChanges	(BuildingType,						ResourceType,		YieldType,		Yield) 
	SELECT DISTINCT								'BUILDING_KILWA_KISIWANI_DUMMY',	Type,				'YIELD_GOLD',	1
	FROM Resources WHERE ResourceUsage = 2;

	INSERT INTO Building_ResourceYieldChanges	(BuildingType,						ResourceType,		YieldType,			Yield) 
	SELECT DISTINCT								'BUILDING_KILWA_KISIWANI_DUMMY',	Type,				'YIELD_PRODUCTION',	1
	FROM Resources WHERE ResourceUsage = 1;
	-- +production_gold_to_local_luxuries_strategics (lua)
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,				FlavorType,				Flavor)
	VALUES		('BUILDING_KILWA_KISIWANI',	'FLAVOR_GOLD',			60),
				('BUILDING_KILWA_KISIWANI',	'FLAVOR_PRODUCTION',	20),
				('BUILDING_KILWA_KISIWANI',	'FLAVOR_HAPPINESS',		40);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- GLOBE THETER
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_GLOBE_THEATER';
	UPDATE Buildings SET River = 1 WHERE Type = 'BUILDING_GLOBE_THEATER';
	
	INSERT INTO Building_ClassesNeededInCity 
				(BuildingType,				BuildingClassType) 
	VALUES		('BUILDING_GLOBE_THEATER',	'BUILDINGCLASS_BATH'),
				('BUILDING_GLOBE_THEATER',	'BUILDINGCLASS_AMPHITHEATER');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- ST. PETER'S BASILICA (NEW)
	UPDATE Buildings SET Cost = 800, PrereqTech = 'TECH_PRINTING_PRESS', NumPoliciesNeeded = 10, MaxStartEra = 'ERA_INDUSTRIAL' WHERE Type = 'BUILDING_ST_PETERS';
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_ST_PETERS';
	
	UPDATE Buildings SET Flat = 1 WHERE Type = 'BUILDING_ST_PETERS';
	---------------------------------------------------------
	UPDATE Buildings SET FreeBuildingThisCity = 'BUILDINGCLASS_CATHEDRAL', ExtraLeagueVotes = 1 WHERE Type = 'BUILDING_ST_PETERS';

	INSERT INTO Building_YieldChanges 
				(BuildingType,					YieldType,			Yield)
	VALUES		('BUILDING_ST_PETERS',			'YIELD_FAITH',		4),
				('BUILDING_ST_PETERS',			'YIELD_CULTURE',	1);

	INSERT INTO Building_FreeUnits 
				(BuildingType,			UnitType,				NumUnits)
	VALUES		('BUILDING_ST_PETERS', 'UNIT_INQUISITOR',		3);

	INSERT INTO Building_BuildingClassHappiness (BuildingType,				BuildingClassType,	Happiness)
	SELECT DISTINCT								'BUILDING_ST_PETERS_DUMMY',	BuildingClass,		1
	FROM Buildings WHERE Cost = -1 and FaithCost > 0 AND WonderSplashImage IS NULL;
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor)
	VALUES		('BUILDING_ST_PETERS',	'FLAVOR_RELIGION',		60),
				('BUILDING_ST_PETERS',	'FLAVOR_PRODUCTION',	20),
				('BUILDING_ST_PETERS',	'FLAVOR_HAPPINESS',		40),
				('BUILDING_ST_PETERS',	'FLAVOR_DIPLOMACY',		10);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- CHICHEN ITZA
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_CHICHEN_ITZA';
	UPDATE Buildings SET Flat = 1, NearbyTerrainRequired = 'TERRAIN_PLAINS' WHERE Type = 'BUILDING_CHICHEN_ITZA';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,				FeatureType) 
	VALUES		('BUILDING_CHICHEN_ITZA',	'FEATURE_FOREST');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- GOLDEN PAVILION (NEW)
	UPDATE Buildings SET Cost = 800, PrereqTech = 'TECH_ASTRONOMY', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_INDUSTRIAL' WHERE Type = 'BUILDING_KINKAKU_JI';
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_KINKAKU_JI';
	
	UPDATE Buildings SET FreshWater = 1 WHERE Type = 'BUILDING_KINKAKU_JI';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,				FeatureType) 
	VALUES		('BUILDING_KINKAKU_JI',		'FEATURE_FOREST'),
				('BUILDING_KINKAKU_JI',		'FEATURE_JUNGLE');
	---------------------------------------------------------
	UPDATE Buildings SET GreatWorkSlotType = 'GREAT_WORK_SLOT_LITERATURE', GreatWorkCount = 1 WHERE Type = 'BUILDING_KINKAKU_JI';

	INSERT INTO Building_YieldChanges 
				(BuildingType,					YieldType,			Yield)
	VALUES		('BUILDING_KINKAKU_JI',			'YIELD_FAITH',		2),
				('BUILDING_KINKAKU_JI',			'YIELD_CULTURE',	2);

	INSERT INTO Building_LakePlotYieldChanges 
				(BuildingType,			YieldType,			Yield)
	VALUES		('BUILDING_KINKAKU_JI',	'YIELD_CULTURE',	1),
				('BUILDING_KINKAKU_JI',	'YIELD_FAITH',		1),
				('BUILDING_KINKAKU_JI',	'YIELD_FOOD',		1);
	
	INSERT INTO Building_FeatureYieldChanges
				(BuildingType,			FeatureType,			YieldType,				Yield) 
	VALUES		('BUILDING_KINKAKU_JI',	'FEATURE_FOREST',		'YIELD_CULTURE',		1),
				('BUILDING_KINKAKU_JI',	'FEATURE_FOREST',		'YIELD_FAITH',			1),
				('BUILDING_KINKAKU_JI',	'FEATURE_FOREST',		'YIELD_FOOD',			1),
				('BUILDING_KINKAKU_JI',	'FEATURE_JUNGLE',		'YIELD_CULTURE',		1),
				('BUILDING_KINKAKU_JI',	'FEATURE_JUNGLE',		'YIELD_FAITH',			1),
				('BUILDING_KINKAKU_JI',	'FEATURE_JUNGLE',		'YIELD_FOOD',			1);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor)
	VALUES		('BUILDING_KINKAKU_JI',	'FLAVOR_RELIGION',		50),
				('BUILDING_KINKAKU_JI',	'FLAVOR_CULTURE',		50),
				('BUILDING_KINKAKU_JI',	'FLAVOR_GROWTH',		30);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- MARAE ARAHURAHU (NEW)
	UPDATE Buildings SET Cost = 800, PrereqTech = 'TECH_ASTRONOMY', NumPoliciesNeeded = 10, MaxStartEra = 'ERA_INDUSTRIAL' WHERE Type = 'BUILDING_MARAE';
	UPDATE Buildings SET WonderSplashAnchor = 'L,B' WHERE Type = 'BUILDING_MARAE';
	
	UPDATE Buildings SET Water = 1, MinAreaSize = 10, NearbyTerrainRequired = 'TERRAIN_GRASS' WHERE Type = 'BUILDING_MARAE';
	
	INSERT INTO Building_ClassesNeededInCity 
				(BuildingType,		BuildingClassType) 
	VALUES		('BUILDING_MARAE',	'BUILDINGCLASS_GARDEN');
	---------------------------------------------------------
	UPDATE Buildings SET FreePromotion = 'PROMOTION_MARAE', GreatWorkSlotType = 'GREAT_WORK_SLOT_MUSIC', GreatWorkCount = 1, SpecialistType = 'SPECIALIST_MUSICIAN', GreatPeopleRateChange = 2 WHERE Type = 'BUILDING_MARAE';
	UPDATE Buildings SET FreePromotion = 'PROMOTION_ARAHURAHU' WHERE Type = 'BUILDING_MARAE_DUMMY';

	INSERT INTO Building_DomainFreeExperiencePerGreatWork
				(BuildingType,		DomainType,		Experience)
	VALUES		('BUILDING_MARAE',	'DOMAIN_LAND',	10),
				('BUILDING_MARAE',	'DOMAIN_SEA',	10);

	INSERT INTO UnitPromotions 
				(Type,					Description,					Help,								Sound,				CannotBeChosen, LostWithUpgrade,	AttackMod,	PortraitIndex,	IconAtlas,						PediaType,		PediaEntry) 
	VALUES		('PROMOTION_MARAE',		'TXT_KEY_PROMOTION_MARAE',		'TXT_KEY_PROMOTION_MARAE_HELP',		'AS2D_IF_LEVELUP',	1,				1,					10,			2,				'PROMOTION_MORE_WONDERS_ATLAS',	'PEDIA_RANGED', 'TXT_KEY_PROMOTION_MARAE'),
				('PROMOTION_ARAHURAHU',	'TXT_KEY_PROMOTION_ARAHURAHU',	'TXT_KEY_PROMOTION_ARAHURAHU_HELP',	'AS2D_IF_LEVELUP',	1,				1,					0,			3,				'PROMOTION_MORE_WONDERS_ATLAS',	'PEDIA_SHARED', 'TXT_KEY_PROMOTION_ARAHURAHU');

	INSERT INTO UnitPromotions_UnitCombats
				(PromotionType,			UnitCombatType)
	VALUES		('PROMOTION_MARAE',		'UNITCOMBAT_ARCHER'),
				('PROMOTION_MARAE',		'UNITCOMBAT_GUN'),
				('PROMOTION_ARAHURAHU',	'UNITCOMBAT_ARCHER'),
				('PROMOTION_ARAHURAHU',	'UNITCOMBAT_GUN'),
				('PROMOTION_ARAHURAHU',	'UNITCOMBAT_ARMOR'),
				('PROMOTION_ARAHURAHU',	'UNITCOMBAT_MELEE'),
				('PROMOTION_ARAHURAHU',	'UNITCOMBAT_MOUNTED'),
				('PROMOTION_ARAHURAHU',	'UNITCOMBAT_RECON'),
				('PROMOTION_ARAHURAHU',	'UNITCOMBAT_SIEGE');

	INSERT INTO UnitPromotions_YieldFromKills
				(PromotionType,			YieldType,			Yield)
	VALUES		('PROMOTION_ARAHURAHU',	'YIELD_CULTURE',	15);
	
	INSERT INTO Building_YieldFromDeath
				(BuildingType,		YieldType,		Yield)
	VALUES		('BUILDING_MARAE',	'YIELD_FAITH',	15);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor)
	VALUES		('BUILDING_MARAE',		'FLAVOR_RELIGION',		30),
				('BUILDING_MARAE',		'FLAVOR_CULTURE',		60),
				('BUILDING_MARAE',		'FLAVOR_OFFENSE',		30);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- HIMEJI CASTLE
	UPDATE Buildings SET WonderSplashAnchor = 'C,T' WHERE Type = 'BUILDING_HIMEJI_CASTLE';
	UPDATE Buildings SET Hill = 1, Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_HIMEJI_CASTLE';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,				FeatureType) 
	VALUES		('BUILDING_HIMEJI_CASTLE',	'FEATURE_FOREST');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- OLD BRIDGE (NEW)
	UPDATE Buildings SET Cost = 800, PrereqTech = 'TECH_GUNPOWDER', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_INDUSTRIAL' WHERE Type = 'BUILDING_OLD_BRIDGE';
	UPDATE Buildings SET WonderSplashAnchor = 'L,C' WHERE Type = 'BUILDING_OLD_BRIDGE';
	
	UPDATE Buildings SET River = 1, Hill = 1 WHERE Type = 'BUILDING_OLD_BRIDGE';

	-- + Peace (lua)
	---------------------------------------------------------
	UPDATE Buildings SET Happiness = 1, SpecialistType = 'SPECIALIST_CIVIL_SERVANT', GreatPeopleRateChange = 2, ExtraLeagueVotes = 2 WHERE Type = 'BUILDING_OLD_BRIDGE';

	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,			Yield)
	VALUES		('BUILDING_OLD_BRIDGE',	'YIELD_CULTURE',	1);
	
	INSERT INTO Building_FreeUnits 
				(BuildingType,				UnitType,				NumUnits)
	VALUES		('BUILDING_OLD_BRIDGE',		'UNIT_GREAT_DIPLOMAT',	1);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor)
	VALUES		('BUILDING_OLD_BRIDGE',	'FLAVOR_CULTURE',		10),
				('BUILDING_OLD_BRIDGE',	'FLAVOR_GREAT_PEOPLE',	30),
				('BUILDING_OLD_BRIDGE',	'FLAVOR_DIPLOMACY',		60),
				('BUILDING_OLD_BRIDGE',	'FLAVOR_HAPPINESS',		30);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- LEANING TOWER OF PISA
	UPDATE Buildings SET WonderSplashAnchor = 'L,T' WHERE Type = 'BUILDING_LEANING_TOWER';
	UPDATE Buildings SET Flat = 1, AnyWater = 1 WHERE Type = 'BUILDING_LEANING_TOWER';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,				FeatureType) 
	VALUES		('BUILDING_LEANING_TOWER',	'FEATURE_MARSH');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- MEENAKSHI TEMPLE (NEW)
	UPDATE Buildings SET Cost = 800, PrereqTech = 'TECH_CHEMISTRY', NumPoliciesNeeded = 10, MaxStartEra = 'ERA_INDUSTRIAL' WHERE Type = 'BUILDING_MEENAKSHI';
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_MEENAKSHI';
	
	UPDATE Buildings SET FreshWater = 1 WHERE Type = 'BUILDING_MEENAKSHI';
	---------------------------------------------------------
	UPDATE Buildings SET FreeBuildingThisCity = 'BUILDINGCLASS_MANDIR' WHERE Type = 'BUILDING_MEENAKSHI';

	INSERT INTO Building_YieldChanges 
				(BuildingType,					YieldType,			Yield)
	VALUES		('BUILDING_MEENAKSHI',			'YIELD_FOOD',		4),
				('BUILDING_MEENAKSHI',			'YIELD_CULTURE',	2);

	INSERT INTO Building_YieldChangesPerPopInEmpire
				(BuildingType,			YieldType,			Yield)
	VALUES		('BUILDING_MEENAKSHI',	'YIELD_FAITH',		25);

	INSERT INTO Building_LakePlotYieldChanges 
				(BuildingType,			YieldType,			Yield)
	VALUES		('BUILDING_MEENAKSHI',	'YIELD_FAITH',	1);	
	
	INSERT INTO Building_RiverPlotYieldChanges
				(BuildingType,			YieldType,		Yield) 
	VALUES		('BUILDING_MEENAKSHI',	'YIELD_FAITH',	1);
	
	INSERT INTO Building_YieldFromFaithPurchase
				(BuildingType,			YieldType,		Yield) 
	VALUES		('BUILDING_MEENAKSHI',	'YIELD_FOOD',	100);
	
	INSERT INTO Building_GreatWorkYieldChanges
				(BuildingType,			YieldType,		Yield) 
	VALUES		('BUILDING_MEENAKSHI',	'YIELD_FOOD',	1);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor)
	VALUES		('BUILDING_MEENAKSHI',	'FLAVOR_GROWTH',		60),
				('BUILDING_MEENAKSHI',	'FLAVOR_RELIGION',		60),
				('BUILDING_MEENAKSHI',	'FLAVOR_CULTURE',		10);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- PORCELAIN TOWER
	UPDATE Buildings SET WonderSplashAnchor = 'L,T' WHERE Type = 'BUILDING_PORCELAIN_TOWER';
	UPDATE Buildings SET River = 1 WHERE Type = 'BUILDING_PORCELAIN_TOWER';
	
	-- + CS_Ally(2) (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- TAJ MAHAL
	UPDATE Buildings SET WonderSplashImage = 'Wonder_Taj_Mahal_splash.dds' WHERE Type = 'BUILDING_TAJ_MAHAL';
	UPDATE Buildings SET WonderSplashAnchor = 'C,C' WHERE Type = 'BUILDING_TAJ_MAHAL';
	UPDATE Buildings SET Flat = 1, River = 1 WHERE Type = 'BUILDING_TAJ_MAHAL';
	
	-- + IsNoCoast (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- UFFIZI
	UPDATE Buildings SET WonderSplashAnchor = 'L,B' WHERE Type = 'BUILDING_UFFIZI';
	UPDATE Buildings SET River = 1 WHERE Type = 'BUILDING_UFFIZI';

	-- + GW_of_Art(2) (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- PETERHOF (NEW)
	UPDATE Buildings SET Cost = 900, PrereqTech = 'TECH_ECONOMICS', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_INDUSTRIAL' WHERE Type = 'BUILDING_PETERHOF';
	UPDATE Buildings SET WonderSplashAnchor = 'L,T' WHERE Type = 'BUILDING_PETERHOF';
	
	UPDATE Buildings SET Flat = 1, Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_PETERHOF';
	---------------------------------------------------------
	UPDATE Buildings SET WLTKDTurns = 20, GreatPeopleRateModifier = 10 WHERE Type = 'BUILDING_PETERHOF';

	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,					Yield)
	VALUES		('BUILDING_PETERHOF',	'YIELD_GOLDEN_AGE_POINTS',	6);

	INSERT INTO Building_WLTKDYieldMod
				(BuildingType,			YieldType,					Yield)
	VALUES		('BUILDING_PETERHOF',	'YIELD_GOLDEN_AGE_POINTS',	15),
				('BUILDING_PETERHOF',	'YIELD_GOLD',				15),
				('BUILDING_PETERHOF',	'YIELD_PRODUCTION',			15);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor)
	VALUES		('BUILDING_PETERHOF',	'FLAVOR_GOLD',			40),
				('BUILDING_PETERHOF',	'FLAVOR_PRODUCTION',	40),
				('BUILDING_PETERHOF',	'FLAVOR_HAPPINESS',		40),
				('BUILDING_PETERHOF',	'FLAVOR_GREAT_PEOPLE',	20);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- BAKKEN (NEW)
	UPDATE Buildings SET Cost = 900, PrereqTech = 'TECH_ECONOMICS', NumPoliciesNeeded = 11, MaxStartEra = 'ERA_INDUSTRIAL' WHERE Type = 'BUILDING_BAKKEN';
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_BAKKEN';
	
	UPDATE Buildings SET Hill = 1 WHERE Type = 'BUILDING_BAKKEN';
	---------------------------------------------------------
	UPDATE Buildings SET Happiness = 3, WLTKDTurns = 10 WHERE Type = 'BUILDING_BAKKEN';

	INSERT INTO Building_YieldChanges 
				(BuildingType,		YieldType,			Yield)
	VALUES		('BUILDING_BAKKEN',	'YIELD_GOLD',		2),
				('BUILDING_BAKKEN',	'YIELD_CULTURE',	1),
				('BUILDING_BAKKEN',	'YIELD_TOURISM',	3);
	
	INSERT INTO Building_WLTKDYieldMod
				(BuildingType,			YieldType,			Yield)
	VALUES		('BUILDING_BAKKEN',		'YIELD_TOURISM',	33);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,		FlavorType,				Flavor)
	VALUES		('BUILDING_BAKKEN',	'FLAVOR_CULTURE',		10),
				('BUILDING_BAKKEN',	'FLAVOR_HAPPINESS',		80),
				('BUILDING_BAKKEN',	'FLAVOR_GOLD',			20);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- SISTINE CHAPEL
	UPDATE Buildings SET WonderSplashAnchor = 'R,T' WHERE Type = 'BUILDING_SISTINE_CHAPEL';
	
	INSERT INTO Building_ClassesNeededInCity 
				(BuildingType,				BuildingClassType) 
	VALUES		('BUILDING_SISTINE_CHAPEL',	'BUILDINGCLASS_ARTISTS_GUILD');
	
	-- + Founded_Religion (lua)
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- SUMMER PALACE
	UPDATE Buildings SET WonderSplashAnchor = 'C,T' WHERE Type = 'BUILDING_SUMMER_PALACE';
	UPDATE Buildings SET Water = 1, MinAreaSize = 1, Hill = 1 WHERE Type = 'BUILDING_SUMMER_PALACE';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,				FeatureType) 
	VALUES		('BUILDING_SUMMER_PALACE',	'FEATURE_FOREST');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- HOUSE OF TRADE OF THE INDIES (NEW)
	UPDATE Buildings SET Cost = 900, PrereqTech = 'TECH_NAVIGATION', NumPoliciesNeeded = 11, MaxStartEra = 'ERA_INDUSTRIAL' WHERE Type = 'BUILDING_HOUSE_OF_TRADE';
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_HOUSE_OF_TRADE';
	
	UPDATE Buildings SET Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_HOUSE_OF_TRADE';

	-- + CSAlly(2) (lua)
	---------------------------------------------------------
	UPDATE Buildings SET NumTradeRouteBonus = 2, SpecialistType = 'SPECIALIST_MERCHANT', GreatPeopleRateChange = 2 WHERE Type = 'BUILDING_HOUSE_OF_TRADE';

	INSERT INTO Building_YieldChanges 
				(BuildingType,				YieldType,		Yield)
	VALUES		('BUILDING_HOUSE_OF_TRADE',	'YIELD_GOLD',	3);
	
	INSERT INTO Building_FreeUnits 
				(BuildingType,					UnitType,				NumUnits)
	VALUES		('BUILDING_HOUSE_OF_TRADE',		'UNIT_GREAT_ADMIRAL',	1);
	
	INSERT INTO Building_UnitCombatProductionModifiers 	
				(BuildingType,				UnitCombatType,				Modifier) 
	VALUES		('BUILDING_HOUSE_OF_TRADE',	'UNITCOMBAT_NAVALMELEE',	10),
				('BUILDING_HOUSE_OF_TRADE',	'UNITCOMBAT_NAVALRANGED',	10),
				('BUILDING_HOUSE_OF_TRADE',	'UNITCOMBAT_SUBMARINE',		10),
				('BUILDING_HOUSE_OF_TRADE',	'UNITCOMBAT_CARRIER',		10),
				('BUILDING_HOUSE_OF_TRADE',	'UNITCOMBAT_CARGO',			10);	
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,				FlavorType,				Flavor)
	VALUES		('BUILDING_HOUSE_OF_TRADE',	'FLAVOR_GOLD',			60),
				('BUILDING_HOUSE_OF_TRADE',	'FLAVOR_GREAT_PEOPLE',	30),
				('BUILDING_HOUSE_OF_TRADE',	'FLAVOR_NAVAL',			20),
				('BUILDING_HOUSE_OF_TRADE',	'FLAVOR_PRODUCTION',	10);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- SOLOVIETSKY MONASTERY (NEW)
	UPDATE Buildings SET Cost = 900, PrereqTech = 'TECH_NAVIGATION', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_INDUSTRIAL' WHERE Type = 'BUILDING_SOLOVIETSKY';
	UPDATE Buildings SET WonderSplashAnchor = 'R,C' WHERE Type = 'BUILDING_SOLOVIETSKY';
	
	UPDATE Buildings SET Water = 1, MinAreaSize = 10, NearbyTerrainRequired = 'TERRAIN_TUNDRA' WHERE Type = 'BUILDING_SOLOVIETSKY';
	---------------------------------------------------------
	UPDATE Buildings SET ExtraCityHitPoints = 50, Defense = 1000, CitySupplyFlat = 1 WHERE Type = 'BUILDING_SOLOVIETSKY';

	INSERT INTO Building_YieldChanges 
				(BuildingType,				YieldType,					Yield)
	VALUES		('BUILDING_SOLOVIETSKY',	'YIELD_PRODUCTION',			1),
				('BUILDING_SOLOVIETSKY',	'YIELD_GOLDEN_AGE_POINTS',	1),
				('BUILDING_SOLOVIETSKY',	'YIELD_FAITH',				1);

	INSERT INTO Building_TerrainYieldChanges
				(BuildingType,				TerrainType,			YieldType,				Yield) 
	VALUES		('BUILDING_SOLOVIETSKY',	'TERRAIN_TUNDRA',		'YIELD_PRODUCTION',		1),
				('BUILDING_SOLOVIETSKY',	'TERRAIN_TUNDRA',		'YIELD_FAITH',			1);

	INSERT INTO Building_UnitCombatProductionModifiers 	
				(BuildingType,				UnitCombatType,				Modifier) 
	VALUES		('BUILDING_SOLOVIETSKY',	'UNITCOMBAT_NAVALMELEE',	15),
				('BUILDING_SOLOVIETSKY',	'UNITCOMBAT_NAVALRANGED',	15),
				('BUILDING_SOLOVIETSKY',	'UNITCOMBAT_SUBMARINE',		15),
				('BUILDING_SOLOVIETSKY',	'UNITCOMBAT_CARRIER',		15);
	---------------------------------------------------------
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,					Flavor)
	VALUES		('BUILDING_SOLOVIETSKY',	'FLAVOR_PRODUCTION',	60),
				('BUILDING_SOLOVIETSKY',	'FLAVOR_RELIGION',		30),
				('BUILDING_SOLOVIETSKY',	'FLAVOR_OFFENSE',		10),
				('BUILDING_SOLOVIETSKY',	'FLAVOR_CITY_DEFENSE',	30),
				('BUILDING_SOLOVIETSKY',	'FLAVOR_NAVAL',			30);
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- RED FORT
	UPDATE Buildings SET WonderSplashAnchor = 'R,B' WHERE Type = 'BUILDING_RED_FORT';
	UPDATE Buildings SET River = 1 WHERE Type = 'BUILDING_RED_FORT';
	
	-- + IsNoCoast (lua)
--============================================--
-- RELIGIOUS WONDERS (MUST BE BUILT IN HOLY CITY)
--============================================--
-- El Ghriba				- Judaism			- Late Classical
-- Hagia Sophia				- Orthodox/Islam	- Early Medieval
-- Borobudur				- Buddhism			- Early Medieval
-- Al Masjid an-Nabawi		- Islam				- Early Medieval
-- Cathedral of St. Basil	- Orthodox			- Late Medieval
-- St Peter's Basilica		- Catholic			- Early Renaissance
-- Meenakshi Temple			- Hindu				- Early Renaissance
---------------------------------------------------------
UPDATE Buildings SET HolyCity = 1, MutuallyExclusiveGroup = 260 WHERE Type IN
('BUILDING_EL_GHRIBA', 'BUILDING_NABAWI', 'BUILDING_HAGIA_SOPHIA', 'BUILDING_BOROBUDUR', 'BUILDING_KREMLIN', 'BUILDING_ST_PETERS', 'BUILDING_MEENAKSHI');
--============================================--
-- POLICY FINISHERS
--============================================--
-- MutuallyExclusiveGroup indicator works only on the city level, so you cannot build a Wonder in the city where the other exists
-- but you can build it in another city. To achieve true 'mutually exclusive' situation we need a dummy building that will be placed
-- in all your cities and block the construction of the 2nd Wonder.
---------------------------------------------------------
UPDATE Buildings SET MutuallyExclusiveGroup = 261, PolicyType = 'POLICY_TRADITION_FINISHER' 	WHERE Type IN ('BUILDING_MOSQUE_OF_DJENNE',		'BUILDING_NOTRE_DAME',			'BUILDING_SHWEDAGON');
UPDATE Buildings SET MutuallyExclusiveGroup = 262, PolicyType = 'POLICY_LIBERTY_FINISHER' 		WHERE Type IN ('BUILDING_FORBIDDEN_PALACE',		'BUILDING_WARTBURG',			'BUILDING_FALUN');
UPDATE Buildings SET MutuallyExclusiveGroup = 263, PolicyType = 'POLICY_HONOR_FINISHER' 		WHERE Type IN ('BUILDING_ALHAMBRA',				'BUILDING_DAMASCUS',			'BUILDING_GREAT_ZIMBABWE');
UPDATE Buildings SET MutuallyExclusiveGroup = 264, PolicyType = 'POLICY_PIETY_FINISHER' 		WHERE Type IN ('BUILDING_RED_FORT',				'BUILDING_KINKAKU_JI',			'BUILDING_SOLOVIETSKY');
UPDATE Buildings SET MutuallyExclusiveGroup = 265, PolicyType = 'POLICY_PATRONAGE_FINISHER'		WHERE Type IN ('BUILDING_BIG_BEN', 				'BUILDING_KILWA_KISIWANI',		'BUILDING_OLD_BRIDGE');
UPDATE Buildings SET MutuallyExclusiveGroup = 266, PolicyType = 'POLICY_AESTHETICS_FINISHER'	WHERE Type IN ('BUILDING_LOUVRE'/*, 				'BUILDING_MONTE_CARLO',				'BUILDING_MUSEUM_ISLAND'*/);
UPDATE Buildings SET MutuallyExclusiveGroup = 267, PolicyType = 'POLICY_COMMERCE_FINISHER' 		WHERE Type IN ('BUILDING_BROADWAY'/*, 			'BUILDING_RUHR_VALLEY',			'BUILDING_BANFF'*/);
UPDATE Buildings SET MutuallyExclusiveGroup = 268, PolicyType = 'POLICY_EXPLORATION_FINISHER'	WHERE Type IN ('BUILDING_PENTAGON', 			'BUILDING_PETERHOF'/*,			'BUILDING_THULE'*/);
UPDATE Buildings SET MutuallyExclusiveGroup = 269, PolicyType = 'POLICY_RATIONALISM_FINISHER'	WHERE Type IN ('BUILDING_BLETCHLEY_PARK'/*,		'BUILDING_KEW_GARDEN',				'BUILDING_ARECIBO'*/);

UPDATE Language_en_US SET Text = REPLACE(Text, 'building the [COLOR_POSITIVE_TEXT]University of Sankore[ENDCOLOR].', 	'Wonders: [COLOR_CYAN]University of Sankore[ENDCOLOR], [COLOR_CYAN]Golden Dagon Pagoda[ENDCOLOR] and [COLOR_CYAN]Notre Dame[ENDCOLOR] (only [COLOR_NEGATIVE_TEXT]one[ENDCOLOR] of those newly unlocked Wonders can be built in Empire).') 	WHERE Tag = 'TXT_KEY_POLICY_BRANCH_TRADITION_HELP';
UPDATE Language_en_US SET Text = REPLACE(Text, 'building the [COLOR_POSITIVE_TEXT]Forbidden Palace[ENDCOLOR].', 		'Wonders: [COLOR_CYAN]Forbidden Palace[ENDCOLOR], [COLOR_CYAN]Wartburg[ENDCOLOR] and [COLOR_CYAN]Falun Mine[ENDCOLOR] (only [COLOR_NEGATIVE_TEXT]one[ENDCOLOR] of those newly unlocked Wonders can be built in Empire).') 					WHERE Tag = 'TXT_KEY_POLICY_BRANCH_LIBERTY_HELP';
UPDATE Language_en_US SET Text = REPLACE(Text, 'building [COLOR_POSITIVE_TEXT]Alhambra[ENDCOLOR].', 					'Wonders: [COLOR_CYAN]Alhambra[ENDCOLOR], [COLOR_CYAN]Forge of Damascus[ENDCOLOR] and [COLOR_CYAN]Great Zimbabwe[ENDCOLOR] (only [COLOR_NEGATIVE_TEXT]one[ENDCOLOR] of those newly unlocked Wonders can be built in Empire).') 				WHERE Tag = 'TXT_KEY_POLICY_BRANCH_HONOR_HELP';
UPDATE Language_en_US SET Text = REPLACE(Text, 'building the [COLOR_POSITIVE_TEXT]Red Fort[ENDCOLOR].', 				'Wonders: [COLOR_CYAN]Red Fort[ENDCOLOR], [COLOR_CYAN]Golden Pavilion[ENDCOLOR] and [COLOR_CYAN]Solovietsky Monastery[ENDCOLOR] (only [COLOR_NEGATIVE_TEXT]one[ENDCOLOR] of those newly unlocked Wonders can be built in Empire).') 		WHERE Tag = 'TXT_KEY_POLICY_BRANCH_PIETY_HELP';
UPDATE Language_en_US SET Text = REPLACE(Text, 'building the [COLOR_POSITIVE_TEXT]Palace of Westminster[ENDCOLOR].', 	'Wonders: [COLOR_CYAN]Palace of Westminster[ENDCOLOR], [COLOR_CYAN]Kilwa Kisiwani[ENDCOLOR] and [COLOR_CYAN]Old Bridge[ENDCOLOR] (only [COLOR_NEGATIVE_TEXT]one[ENDCOLOR] of those newly unlocked Wonders can be built in Empire).') 		WHERE Tag = 'TXT_KEY_POLICY_BRANCH_PATRONAGE_HELP';
UPDATE Language_en_US SET Text = REPLACE(Text, 'building the [COLOR_POSITIVE_TEXT]Louvre[ENDCOLOR].', 					'Wonders: [COLOR_CYAN]Louvre[ENDCOLOR], [COLOR_CYAN]Monte Carlo Cassino[ENDCOLOR] and [COLOR_CYAN]Museum Island[ENDCOLOR] (only [COLOR_NEGATIVE_TEXT]one[ENDCOLOR] of those newly unlocked Wonders can be built in Empire).') 							WHERE Tag = 'TXT_KEY_POLICY_BRANCH_AESTHETICS_HELP';
UPDATE Language_en_US SET Text = REPLACE(Text, 'building [COLOR_POSITIVE_TEXT]Broadway[ENDCOLOR].', 					'Wonders: [COLOR_CYAN]Broadway[ENDCOLOR], [COLOR_CYAN]Ruhr Valley[ENDCOLOR] and [COLOR_CYAN]Banff Spring Hotel[ENDCOLOR] (only [COLOR_NEGATIVE_TEXT]one[ENDCOLOR] of those newly unlocked Wonders can be built in Empire).') 			WHERE Tag = 'TXT_KEY_POLICY_BRANCH_COMMERCE_HELP';
UPDATE Language_en_US SET Text = REPLACE(Text, 'building the [COLOR_POSITIVE_TEXT]Pentagon[ENDCOLOR].', 				'Wonders: [COLOR_CYAN]Pentagon[ENDCOLOR], [COLOR_CYAN]Peterhof Palace[ENDCOLOR] and [COLOR_CYAN]Thule Air Base[ENDCOLOR] (only [COLOR_NEGATIVE_TEXT]one[ENDCOLOR] of those newly unlocked Wonders can be built in Empire).') 				WHERE Tag = 'TXT_KEY_POLICY_BRANCH_EXPLORATION_HELP';
UPDATE Language_en_US SET Text = REPLACE(Text, 'building [COLOR_POSITIVE_TEXT]Bletchley Park[ENDCOLOR].', 				'Wonders: [COLOR_CYAN]Bletchley Park[ENDCOLOR], [COLOR_CYAN]Kew Garden[ENDCOLOR] and [COLOR_CYAN]Arecibo Observatory[ENDCOLOR] (only [COLOR_NEGATIVE_TEXT]one[ENDCOLOR] of those newly unlocked Wonders can be built in Empire).') 			WHERE Tag = 'TXT_KEY_POLICY_BRANCH_RATIONALISM_HELP';
--============================================--
-- VP FIXES
--============================================--
--============================================--
-- FREE ART HELP TEXTS
--============================================--
UPDATE Language_en_US SET Text = REPLACE(Text, 'Contains a pre-built [ICON_GREAT_WORK] Great Work of Art. ', 'Starts with [ICON_GREAT_WORK] [COLOR_CULTURE_STORED]The Crown Jewels[ENDCOLOR].[NEWLINE][NEWLINE]') WHERE Tag ='TXT_KEY_BUILDING_WHITE_TOWER_HELP';
UPDATE Language_en_US SET Text = REPLACE(Text, 'comes with both a [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] [ICON_GREAT_WORK] Great Work', 'starts with [COLOR_CULTURE_STORED] [COLOR_MAGENTA]Flood Tablet[ENDCOLOR]') WHERE Tag ='TXT_KEY_BUILDING_ROYAL_LIBRARY_HELP';
--============================================--
-- Hide all INACTIVE Wonders - override any previous settings
-- Warning! They will still be visible in Civilopedia!
--============================================--
UPDATE Buildings
SET Cost = -1, FaithCost = -1, PrereqTech = NULL, GreatWorkCount = -1
WHERE Type IN (SELECT 'BUILDING_'||WType FROM MWfVPConfig WHERE WActive = 0);
--------------------------------------------------------------
--------------------------------------------------------------
