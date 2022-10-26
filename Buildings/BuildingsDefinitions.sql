--============================================--
-- ICONS ATLASES
--============================================--
INSERT INTO IconTextureAtlases 
			(Atlas, 							IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES		('BUILDING_MORE_WONDERS_ATLAS', 	256, 		'More_Wonders_Buildings_256.dds',		8, 				1),
			('BUILDING_MORE_WONDERS_ATLAS', 	128, 		'More_Wonders_Buildings_128.dds',		8, 				1),
			('BUILDING_MORE_WONDERS_ATLAS', 	80, 		'More_Wonders_Buildings_80.dds',		8, 				1),
			('BUILDING_MORE_WONDERS_ATLAS', 	64, 		'More_Wonders_Buildings_64.dds',		8, 				1),
			('BUILDING_MORE_WONDERS_ATLAS', 	45, 		'More_Wonders_Buildings_45.dds',		8, 				1);	
--============================================--
-- PROMOTIONS
--============================================--
INSERT INTO Language_en_US 
			(Tag,								Text) 
VALUES		('TXT_KEY_PROMOTION_FLETCHER',		'Yerba de la Fleche'),
			('TXT_KEY_PROMOTION_FLETCHER_HELP',	'5% [COLOR:255:230:85:255]Kill Chance after Ranged Attack[ENDCOLOR].');

INSERT INTO UnitPromotions 
			(Type,						Description,						Help,									Sound,				CannotBeChosen, LostWithUpgrade,	PortraitIndex,	IconAtlas,						PediaType,			PediaEntry) 
VALUES		('PROMOTION_FLETCHER',		'TXT_KEY_PROMOTION_FLETCHER',		'TXT_KEY_PROMOTION_FLETCHER_HELP',		'AS2D_IF_LEVELUP',	1,				1,					19,				'PROMOTION_MORE_WONDERS_ATLAS',	'PEDIA_RANGED',		'TXT_KEY_PROMOTION_FLETCHER');

INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,				UnitCombatType)
VALUES		('PROMOTION_FLETCHER',		'UNITCOMBAT_ARCHER');
--============================================--
-- BUILDINGS
--============================================--
INSERT INTO BuildingClasses 
			(Type,							Description,					DefaultBuilding)
VALUES		('BUILDINGCLASS_FLETCHER',		'TXT_KEY_BUILDING_FLETCHER',	'BUILDING_FLETCHER'),
			('BUILDINGCLASS_GOURMET',		'TXT_KEY_BUILDING_GOURMET',		'BUILDING_GOURMET');

INSERT INTO Buildings
			(Type,					BuildingClass,				Description,					Civilopedia,							Help,								IconAtlas,						PortraitIndex,	PrereqTech,			Cost,	FaithCost,	NukeImmune, ConquestProb,	IsDummy)
VALUES		('BUILDING_FLETCHER',	'BUILDINGCLASS_FLETCHER',	'TXT_KEY_BUILDING_FLETCHER',	'TXT_KEY_BUILDING_FLETCHER_PEDIA',		'TXT_KEY_BUILDING_FLETCHER_HELP',	'BUILDING_MORE_WONDERS_ATLAS',	0,				'TECH_SAILING',		110,	0,			0,          66,				0),
			('BUILDING_GOURMET',	'BUILDINGCLASS_GOURMET',	'TXT_KEY_BUILDING_GOURMET',		'TXT_KEY_BUILDING_GOURMET_PEDIA',		'TXT_KEY_BUILDING_GOURMET_HELP',	'BUILDING_MORE_WONDERS_ATLAS',	1,				'TECH_FERTILIZER',	1250,	0,			0,          66,				0);

UPDATE Buildings SET TrainedFreePromotion = 'PROMOTION_FLETCHER' WHERE Type = 'BUILDING_FLETCHER';
UPDATE Buildings SET GreatWorkSlotType = 'GREAT_WORK_SLOT_MUSIC', GreatWorkCount = 1 WHERE Type = 'BUILDING_GOURMET';

INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_FLETCHER',			'Fletcher'),
			('TXT_KEY_BUILDING_FLETCHER_PEDIA',		'TODO'),
			('TXT_KEY_BUILDING_FLETCHER_HELP',		'[COLOR_POSITIVE_TEXT]Yerba de la Fleche[ENDCOLOR] promotion for Archery units produced in this City. +10% [ICON_PRODUCTION] Production towards Archery units in this City.[NEWLINE][NEWLINE]Nearby [ICON_RES_BISON] Tropical Fish: +2 [ICON_PRODUCTION] Production.'),
			('TXT_KEY_BUILDING_GOURMET',			'Gourmet Restaurant'),
			('TXT_KEY_BUILDING_GOURMET_PEDIA',		'TODO'),
			('TXT_KEY_BUILDING_GOURMET_HELP',		'5% of the City''s [ICON_FOOD] Food is converted into [ICON_TOURISM] Tourism every turn. Contains 1 slot for a [ICON_GREAT_WORK] Great Work of Music.[NEWLINE][NEWLINE]Nearby [ICON_RES_CRAB] Crab: +1 [ICON_FOOD] Food.[NEWLINE]Nearby [ICON_RES_GOLD] Gold: +1 [ICON_FOOD] Food.[NEWLINE]Nearby [ICON_RES_SPICES] Cinnamon: +1 [ICON_FOOD] Food.[NEWLINE]Nearby [ICON_RES_TROPICAL_FISH] Tropical Fish: +1 [ICON_FOOD] Food.');

INSERT INTO Building_LocalResourceOrs
			(BuildingType,			ResourceType) 
VALUES		('BUILDING_FLETCHER',	'RESOURCE_TROPICAL_FISH'),
			('BUILDING_GOURMET',	'RESOURCE_TROPICAL_FISH'),
			('BUILDING_GOURMET',	'RESOURCE_CRAB'),
			('BUILDING_GOURMET',	'RESOURCE_GOLD'),
			('BUILDING_GOURMET',	'RESOURCE_SPICES');

INSERT INTO Building_YieldChanges 
			(BuildingType,			YieldType,			Yield) 
VALUES		('BUILDING_FLETCHER',	'YIELD_FOOD',		2),
			('BUILDING_GOURMET',	'YIELD_FOOD',		3),
			('BUILDING_GOURMET',	'YIELD_CULTURE',	2);

INSERT INTO Building_YieldFromYieldPercent
			(BuildingType,				YieldOut,			YieldIn,		Value) 
VALUES		('BUILDING_GOURMET',		'YIELD_TOURISM',	'YIELD_FOOD',	5);

INSERT INTO Building_ResourceYieldChanges
			(BuildingType,			ResourceType,				YieldType,			Yield) 
VALUES		('BUILDING_FLETCHER',	'RESOURCE_TROPICAL_FISH',	'YIELD_PRODUCTION', 2),
			('BUILDING_GOURMET',	'RESOURCE_TROPICAL_FISH',	'YIELD_FOOD',		1),
			('BUILDING_GOURMET',	'RESOURCE_CRAB',			'YIELD_FOOD',		1),
			('BUILDING_GOURMET',	'RESOURCE_GOLD',			'YIELD_FOOD',		1),
			('BUILDING_GOURMET',	'RESOURCE_SPICES',			'YIELD_FOOD',		1);

INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType,			UnitCombatType,				Modifier) 
VALUES		('BUILDING_FLETCHER',	'UNITCOMBAT_ARCHER',		10);
