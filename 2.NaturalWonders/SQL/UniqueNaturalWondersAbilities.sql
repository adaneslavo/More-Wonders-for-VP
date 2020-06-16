--------------------------------------------------------------
-- Dummies for Natural Wonders
-- May 11, 2020: Created, adan_eslavo
--============================================--
-- DUMMY BUILDINGS
--============================================--
-- Salar de Uyuni
INSERT INTO BuildingClasses 
			(Type,									Description,								DefaultBuilding)
VALUES		('BUILDINGCLASS_SALAR_DUMMY',			'TXT_KEY_BUILDING_SALAR_DUMMY',				'BUILDING_SALAR_DUMMY'),
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
			('BUILDINGCLASS_MT_EVEREST_DUMMY',		'TXT_KEY_BUILDING_MT_EVEREST_DUMMY',		'BUILDING_MT_EVEREST_DUMMY');

INSERT INTO Buildings
			(Type,								BuildingClass,							Description,								PrereqTech, Cost, FaithCost, GreatWorkCount , NukeImmune, ConquestProb, SpecialistType,			GreatPeopleRateChange,	EmpireNeedsModifierGlobal,	GlobalSpaceProductionModifier,	NumTradeRouteBonus)
VALUES		('BUILDING_SALAR_DUMMY',			'BUILDINGCLASS_SALAR_DUMMY',			'TXT_KEY_BUILDING_SALAR_DUMMY',				NULL,       -1,   -1,        -1,              1,          0,			NULL,					0,						0,							0,								0),
			('BUILDING_EL_DORADO_DUMMY',		'BUILDINGCLASS_EL_DORADO_DUMMY',		'TXT_KEY_BUILDING_EL_DORADO_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			NULL,					0,						0,							0,								0),
			('BUILDING_POTOSI_DUMMY',			'BUILDINGCLASS_POTOSI_DUMMY',			'TXT_KEY_BUILDING_POTOSI_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			NULL,					0,						0,							0,								2),
			('BUILDING_CRATER_DUMMY',			'BUILDINGCLASS_CRATER_DUMMY',			'TXT_KEY_BUILDING_CRATER_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			NULL,					0,						0,							20,								0),
			('BUILDING_MESA_DUMMY',				'BUILDINGCLASS_MESA_DUMMY',				'TXT_KEY_BUILDING_MESA_DUMMY',				NULL,       -1,   -1,        -1,              1,          0,			NULL,					0,						0,							0,								0),
			('BUILDING_SOLOMONS_MINES_DUMMY',	'BUILDINGCLASS_SOLOMONS_MINES_DUMMY',	'TXT_KEY_BUILDING_SOLOMONS_MINES_DUMMY',	NULL,       -1,   -1,        -1,              1,          0,			NULL,					0,						0,							0,								0),
			('BUILDING_VOLCANO_DUMMY',			'BUILDINGCLASS_VOLCANO_DUMMY',			'TXT_KEY_BUILDING_VOLCANO_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			NULL,					0,						-10,						0,								0),
			('BUILDING_FUJI_1_DUMMY',			'BUILDINGCLASS_FUJI_1_DUMMY',			'TXT_KEY_BUILDING_FUJI_DUMMY',				NULL,       -1,   -1,        -1,              1,          0,			'SPECIALIST_ARTIST',	3,						0,							0,								0),
			('BUILDING_FUJI_2_DUMMY',			'BUILDINGCLASS_FUJI_2_DUMMY',			'TXT_KEY_BUILDING_FUJI_DUMMY',				NULL,       -1,   -1,        -1,              1,          0,			'SPECIALIST_WRITER',	2,						0,							0,								0),
			('BUILDING_FUJI_3_DUMMY',			'BUILDINGCLASS_FUJI_3_DUMMY',			'TXT_KEY_BUILDING_FUJI_DUMMY',				NULL,       -1,   -1,        -1,              1,          0,			'SPECIALIST_MUSICIAN',	1,						0,							0,								0),
			('BUILDING_MT_SINAI_DUMMY',			'BUILDINGCLASS_MT_SINAI_DUMMY',			'TXT_KEY_BUILDING_MT_SINAI_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			NULL,					0,						0,							0,								0),
			('BUILDING_GEYSER_DUMMY',			'BUILDINGCLASS_GEYSER_DUMMY',			'TXT_KEY_BUILDING_GEYSER_DUMMY',			NULL,       -1,   -1,        -1,              1,          0,			'SPECIALIST_SCIENTIST',	1,						0,							0,								0),
			('BUILDING_MT_EVEREST_DUMMY',		'BUILDINGCLASS_MT_EVEREST_DUMMY',		'TXT_KEY_BUILDING_MT_EVEREST_DUMMY',		NULL,       -1,   -1,        -1,              1,          0,			NULL,					0,						0,							0,								0);

INSERT INTO Language_en_US 
			(Tag,										Text) 
VALUES		('TXT_KEY_BUILDING_SALAR_DUMMY',			'Salar de Uyuni'),
			('TXT_KEY_BUILDING_EL_DORADO_DUMMY',		'El Dorado'),
			('TXT_KEY_BUILDING_POTOSI_DUMMY',			'Cerro de Potosi'),
			('TXT_KEY_BUILDING_CRATER_DUMMY',			'The Barringer Crater'),
			('TXT_KEY_BUILDING_MESA_DUMMY',				'The Grand Mesa'),
			('TXT_KEY_BUILDING_SOLOMONS_MINES_DUMMY',	'King Solomon''s Mines'),
			('TXT_KEY_BUILDING_VOLCANO_DUMMY',			'Krakatoa'),
			('TXT_KEY_BUILDING_FUJI_DUMMY',				'Mt. Fuji'),
			('TXT_KEY_BUILDING_MT_SINAI_DUMMY',			'Mt. Sinai'),
			('TXT_KEY_BUILDING_GEYSER_DUMMY',			'Old Faithful'),
			('TXT_KEY_BUILDING_MT_EVEREST_DUMMY',		'Mt. Everest');

INSERT INTO Building_ResourceQuantity
			(BuildingType,					ResourceType,		Quantity) 
VALUES		('BUILDING_SALAR_DUMMY',		'RESOURCE_SALT',	1),
			('BUILDING_EL_DORADO_DUMMY',	'RESOURCE_GOLD',	1),
			('BUILDING_POTOSI_DUMMY',		'RESOURCE_SILVER',	1);

INSERT INTO Building_DomainFreeExperiencesGlobal
			(BuildingType,			DomainType,		Experience)
VALUES		('BUILDING_MESA_DUMMY',	'DOMAIN_LAND',	15);

INSERT INTO Building_GreatWorkYieldChanges
			(BuildingType,				YieldType,					Yield) 
VALUES		('BUILDING_MT_SINAI_DUMMY',	'YIELD_FAITH',				1),
			('BUILDING_MT_SINAI_DUMMY',	'YIELD_GOLDEN_AGE_POINTS',	1);

INSERT INTO Building_ImprovementYieldChangesGlobal
			(BuildingType,						ImprovementType,			YieldType,						Yield) 
VALUES		('BUILDING_SOLOMONS_MINES_DUMMY',	'IMPROVEMENT_MINE',			'YIELD_GOLDEN_AGE_POINTS',		1),
			('BUILDING_MT_SINAI_DUMMY',			'IMPROVEMENT_HOLY_SITE',	'YIELD_FAITH',					1),
			('BUILDING_MT_SINAI_DUMMY',			'IMPROVEMENT_HOLY_SITE',	'YIELD_GOLDEN_AGE_POINTS',		1);

INSERT INTO Building_GlobalYieldModifiers
			(BuildingType,					YieldType,			Yield) 
VALUES		('BUILDING_MT_EVEREST_DUMMY',	'YIELD_TOURISM',	10);
--============================================--
-- PROMOTIONS
--============================================--
INSERT INTO Language_en_US 
			(Tag,										Text) 
VALUES		('TXT_KEY_PROMOTION_KAILASH',				'Holy Mountain'),
			('TXT_KEY_PROMOTION_KAILASH_HELP',			'Double[ICON_MOVES]Movement [COLOR:255:230:85:255]on Hills[ENDCOLOR].'),
			('TXT_KEY_PROMOTION_ULURU',					'Old Tribes'),
			('TXT_KEY_PROMOTION_ULURU_HELP',			'+10 [ICON_INFLUENCE] Influence [COLOR:255:230:85:255]after Diplomatic Mission[ENDCOLOR].'),
			('TXT_KEY_PROMOTION_SOLOMONS_MINES',		'For the King'),
			('TXT_KEY_PROMOTION_SOLOMONS_MINES_HELP',	'+25% [ICON_WORKER] Work Rate');		

INSERT INTO UnitPromotions 
			(Type,							Description,							Help,										Sound,				CannotBeChosen, LostWithUpgrade,	AttackMod,	DiploMissionInfluence,	WorkRateMod,	PortraitIndex,	IconAtlas,						PediaType,			PediaEntry) 
VALUES		('PROMOTION_KAILASH',			'TXT_KEY_PROMOTION_KAILASH',			'TXT_KEY_PROMOTION_KAILASH_HELP',			'AS2D_IF_LEVELUP',	1,				0,					0,			0,						0,				0,				'PROMOTION_MORE_WONDERS_ATLAS',	'PEDIA_CIVILIAN',	'TXT_KEY_PROMOTION_KAILASH'),
			('PROMOTION_ULURU',				'TXT_KEY_PROMOTION_ULURU',				'TXT_KEY_PROMOTION_ULURU_HELP',				'AS2D_IF_LEVELUP',	1,				0,					0,			10,						0,				0,				'PROMOTION_MORE_WONDERS_ATLAS',	'PEDIA_CIVILIAN',	'TXT_KEY_PROMOTION_ULURU'),
			('PROMOTION_SOLOMONS_MINES',	'TXT_KEY_PROMOTION_SOLOMONS_MINES',		'TXT_KEY_PROMOTION_SOLOMONS_MINES_HELP',		'AS2D_IF_LEVELUP',	1,				0,					0,			0,						25,				0,				'PROMOTION_MORE_WONDERS_ATLAS',	'PEDIA_CIVILIAN',	'TXT_KEY_PROMOTION_SOLOMONS_MINES');

INSERT INTO UnitPromotions_Terrains
			(PromotionType,			TerrainType,	DoubleMove)
VALUES		('PROMOTION_KAILASH',	'TERRAIN_HILL',	1);

INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,					UnitCombatType)
VALUES		('PROMOTION_KAILASH',			'UNITCOMBAT_MISSIONARY'),
			('PROMOTION_ULURU',				'UNITCOMBAT_DIPLOMACY'),
			('PROMOTION_SOLOMONS_MINES',	'UNITCOMBAT_WORKER');
--------------------------------------------------------------
--------------------------------------------------------------
