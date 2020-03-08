--------------------------------------------------------------
-- Automatic changes applied to all new Wonders
-- Dec 9, 2017: Created, Infixo
-- Jan 6, 2020: Improved, adan_eslavo
--============================================--
-- Table with new Wonder Types
--============================================--
CREATE TABLE MWfVPConfig (
	WType	TEXT	NOT NULL,  	-- Wonder Type
	WDummy	TEXT	NOT NULL,   -- Name for dummy buildings
	WActive	INTEGER	NOT NULL,   -- 1 = Wonder active / 0 = Wonder not active
	WFake	INTEGER	NOT NULL,   -- 1 = Fake texts / 0 = Real texts
	PRIMARY KEY (WType)
);
--============================================--
-- CONFIGURATION
--============================================--
-- Use below table to DISABLE a specific Wonder
-- Change the 1st number to 0 (ZERO) to disable.
-- DO NOT CHANGE 2ND NUMBER!
-- Example:
-- ('NAZCA',    1, 0), -- Brooklyn is ENABLED
-- ('NAZCA',    0, 0), -- Brooklyn is DISABLED
--------------------------------------------------------------
INSERT INTO MWfVPConfig	
			(WType,				WDummy,		WActive,	WFake)
VALUES		('ALTAMIRA',		'None',		1,			0),		-- Altamira Cave
			('GGANTIJA',		'None',		1,			0),		-- Ggantija
			('GOEBEKLI_TEPE',	'None',		1,			0),		-- Goebekli Tepe
			('KUK',				'None',		1,			0),		-- Kuk Swamp
			('MAJORVILLE',		'None',		1,			0),		-- Majorville Medicine Wheel
			('MOHENJO_DARO',	'None',		1,			0),		-- Mohenjo-Daro
			('SKARA_BRAE',		'None',		1,			0),		-- Skara Brae
			----------------------------------------------------------------------------------------
			('KARNAK',			'None',		1,			0),		-- Karnak Temple
			('NAZCA',			'None',		1,			0),		-- Nazca Lines
			('WIELICZKA',		'None',		1,			0),		-- Wieliczka Salt Mine
			----------------------------------------------------------------------------------------
			('MALWIYA',			'None',		1,			0),		-- Malwiya Minaret (Great Mosque of Samarra)
			('GATE_OF_SUN',		'None',		1,			0),		-- Gate of the Sun
			('BAMYAN',			'None',		1,			0),		-- Buddhas of Bamiyan
			('EL_GHRIBA',		'None',		1,			0),		-- El Ghriba Synagougue
			('ETCHMIADZIN',		'None',		1,			0),		-- Etchmiadzin Cathedral
			('CHAND_BAORI',		'None',		1,			0),		-- Chand Baori Well
			----------------------------------------------------------------------------------------
			('NABAWI',			'None',		1,			0),		-- Al-Masjid an-Nabawi (Prophet's Mosque)
			('LAVAUX',			'None',		1,			0),		-- Lavaux
			('WARTBURG',		'None',		1,			0),		-- Wartburg Castle
			('GREAT_ZIMBABWE',	'None',		1,			0),		-- Great Zimbabwe
			('FALUN',			'None',		1,			0),		-- Falun Mine
			('AHU',				'None',		1,			0),		-- Ahu Tongariki
			('DAMASCUS',		'None',		1,			0),		-- Forge of Damascus
			('SHWEDAGON',		'None',		1,			0),		-- Shwedagon Pagoda / Shwedagon Zedi Daw / Great Dagon Pagoda  / Golden Pagoda
			('MICHEL',			'None',		1,			0),		-- Mont Saint Michel
			('ITSUKUSHIMA',		'None',		1,			0),		-- Itsukushima Shrine
			('QALHAT',			'None',		1,			0),		-- Qalhat
			('CHEVALIERS',		'None',		1,			0),		-- Krak des Chevaliers
			----------------------------------------------------------------------------------------
			('BENHADDOU',		'None',		1,			0),		-- Ait Benhaddou
			('KILWA_KISIWANI',	'None',		1,			0),		-- Kilwa Kisiwani
			('ST_PETERS',		'None',		1,			0),		-- Papal Basilica of St. Peter in the Vatican
			('KINKAKU_JI',		'None',		1,			0),		-- Golden Pavilion (Kikaku-Ji)
			('MARAE',			'None',		1,			0),		-- Marae Arahurahu
			('OLD_BRIDGE',		'None',		1,			0),		-- Old Bridge in Mostar
			('MEENAKSHI',		'None',		1,			0),		-- Meenakshi Temple
			('PETERHOF',		'None',		1,			0),		-- Peterhof Palace
			('BAKKEN',			'None',		1,			0),		-- Bakken
			('HOUSE_OF_TRADE',	'None',		1,			0),		-- House of Trade of the Indies (Casa de Contratación)
			('SOLOVIETSKY',		'None',		1,			0);		-- Solovietsky Monastery
			----------------------------------------------------------------------------------------
			--('MUSEUM_ISLAND',	'None',		1,			0),		-- Museum Island
			--('BROOKLYN',		'None',		1,			0),		-- Brooklyn Bridge
			--('MONTE_CARLO',		'None',		1,			0),		-- Monte Carlo Casino
			
--('ARECIBO',     1, 0), -- Arecibo Observatory
--('ANITKABIR',   1, 0), -- Anitkabir Mausoleum
--('HOLLYWOOD',   1, 0), -- Hollywood
--('JUMEIRAH',    1, 0), -- Palm Jumeirah
--('MARINASANDS', 1, 1), -- Marina Bay Sands
--('METEORA', 1, 1), -- Monastery of the Holy Trinity (Meteora)
--('MILLAU',      1, 0), -- Millau Viaduct
--('PETRONAS',    1, 1), -- The Petronas Towers
--('RUSHMORE',    1, 1), -- Mount Rushmore
--('ROCKEFELLER', 1, 0), -- Rockefeller Center
--('SKYTREE',     1, 1), -- Tokyo Skytree
--('SOVIETS',     1, 0), -- Palace of the Soviets
--('SPUTNIK',     1, 0), -- Sputnik Program, The
--('TAIPEI101',   1, 0), -- Taipei 101
--('WHITESANDS',  1, 0), -- White Sands Missile Range
--============================================--
-- WONDERS INITIAL CONFIGURATION
--============================================--
-- This will disable by default all Wonders not yet programmed
UPDATE MWfVPConfig SET WActive = 0 WHERE WFake = 1;
--------------------------------------------------------------
-- BuildingClasses
INSERT INTO BuildingClasses 
			(Type,						Description,					DefaultBuilding,	MaxGlobalInstances)
SELECT		'BUILDINGCLASS_'||WType,	'TXT_KEY_BUILDING_'||WType,		'BUILDING_'||WType, 1
FROM MWfVPConfig WHERE WActive = 1;
--------------------------------------------------------------
-- Buildings
-- MinAreaSize - change to 10 for Coastal Wonders!
-- Set Cost = -1 and later apply proper value for enabled buildings
-- GreatWorkCount defaults to 0, PrereqTech defaults to NULL
INSERT INTO Buildings
			(Type,               BuildingClass,           Description,                Civilopedia,                        Help,								Quote,								ThemingBonusHelp, Cost, FaithCost, NukeImmune, HurryCostModifier, MinAreaSize, ConquestProb, IconAtlas,						 PortraitIndex, WonderSplashImage,				WonderSplashAnchor)
SELECT		'BUILDING_'||WType, 'BUILDINGCLASS_'||WType, 'TXT_KEY_BUILDING_'||WType, 'TXT_KEY_WONDER_'||WType||'_PEDIA', 'TXT_KEY_WONDER_'||WType||'_HELP',	'TXT_KEY_WONDER_'||WType||'_QUOTE', NULL,             1,    0,         1,          -5,                -1,          100,          'ATLAS_MORE_WONDERS_'||WType,	0,             'Wonder_'||WType||'_splash.dds', 'R,T'
FROM MWfVPConfig WHERE WActive = 1;
--------------------------------------------------------------
-- Panama Canal is already in the game
UPDATE Buildings SET IconAtlas = 'BW_ATLAS_2', PortraitIndex = 25, WonderSplashImage = 'WonderConceptPanamaCanal.dds' WHERE Type = 'BUILDING_PANAMA';
--------------------------------------------------------------
-- Also, for reasons, an icon for St. Peter's Basilica is available
UPDATE Buildings SET IconAtlas = 'EXPANSION_SCEN_WONDER_ATLAS', PortraitIndex = 6 WHERE Type = 'BUILDING_ST_PETERS';
--------------------------------------------------------------
-- Civilization_BuildingClassOverrides
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType,			BuildingClassType,			BuildingType)
SELECT		'CIVILIZATION_BARBARIAN',	'BUILDINGCLASS_'||WType,	NULL 
FROM MWfVPConfig;

INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType,		BuildingClassType,			BuildingType)
SELECT		'CIVILIZATION_MINOR',	'BUILDINGCLASS_'||WType,	NULL 
FROM MWfVPConfig;
--------------------------------------------------------------
-- Building_Flavors
-- Let's start with a default 20, can change later for specific Wonders
INSERT INTO Building_Flavors 
			(BuildingType,		FlavorType,			Flavor)
SELECT		'BUILDING_'||WType, 'FLAVOR_WONDER',	20
FROM MWfVPConfig;
--------------------------------------------------------------
-- IconTextureAtlases
INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) SELECT 'ATLAS_MORE_WONDERS_'||WType, 256, 'Wonder_'||WType||'_256.dds',	'1', '1' FROM MWfVPConfig;
INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) SELECT 'ATLAS_MORE_WONDERS_'||WType, 128, 'Wonder_'||WType||'_128.dds',	'1', '1' FROM MWfVPConfig;
INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) SELECT 'ATLAS_MORE_WONDERS_'||WType,  80, 'Wonder_'||WType||'_80.dds',	'1', '1' FROM MWfVPConfig;
INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) SELECT 'ATLAS_MORE_WONDERS_'||WType,  64, 'Wonder_'||WType||'_64.dds',	'1', '1' FROM MWfVPConfig;
INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) SELECT 'ATLAS_MORE_WONDERS_'||WType,  45, 'Wonder_'||WType||'_45.dds',	'1', '1' FROM MWfVPConfig;
--------------------------------------------------------------
-- Fake texts; if the real ones are created, set WFake to 0 (zero)
INSERT INTO Language_en_US (Tag, Text) SELECT 'TXT_KEY_BUILDING_'||WType,         'Wonder '||WType 					    FROM MWfVPConfig WHERE WFake = 1;
INSERT INTO Language_en_US (Tag, Text) SELECT 'TXT_KEY_WONDER_'||WType||'_PEDIA', 'Civilopedia text for Wonder '||WType FROM MWfVPConfig WHERE WFake = 1;
INSERT INTO Language_en_US (Tag, Text) SELECT 'TXT_KEY_WONDER_'||WType||'_HELP',  'Help text for Wonder '||WType 	    FROM MWfVPConfig WHERE WFake = 1;
INSERT INTO Language_en_US (Tag, Text) SELECT 'TXT_KEY_WONDER_'||WType||'_QUOTE', '[NEWLINE]Quote for Wonder '||WType 	FROM MWfVPConfig WHERE WFake = 1;
--============================================--
-- DUMMY BUILDINGS
-- HolyCity doesn't need one because it is usually 1 city; 2nd religion and 2nd Holy City might allow for 2nd Wonder
--============================================--
INSERT INTO MWfVPConfig 
			(WType,							WDummy,						WActive,	WFake)
VALUES		('KUK_DUMMY',					'Kuk',						2,			0),
			('GATE_OF_SUN_DUMMY',			'Gate of the Sun',			2,			0),
			('GREAT_ZIMBABWE_DUMMY',		'Great Zimbabwe',			2,			0),
			('ITSUKUSHIMA_DUMMY',			'Itsukushima Shrine',		2,			0),
			('QALHAT_DUMMY',				'Qalhat',					2,			0),
			('CHEVALIERS_DUMMY',			'Krak des Chevaliers',		2,			0),
			('KILWA_KISIWANI_DUMMY',		'Kilwa Kisiwani',			2,			0),
			('MARAE_DUMMY',					'Marae Arahurahu',			2,			0),
			('ST_PETERS_DUMMY',				'St. Peter''s Basilica',	2,			0);

INSERT INTO BuildingClasses 
			(Type,						Description,				DefaultBuilding)
SELECT		'BUILDINGCLASS_'||WType,	'TXT_KEY_BUILDING_'||WType, 'BUILDING_'||WType
FROM MWfVPConfig WHERE WActive = 2;

INSERT INTO Buildings
			(Type,               BuildingClass,           Description,					PrereqTech, Cost, FaithCost, GreatWorkCount , NukeImmune, ConquestProb)
SELECT		'BUILDING_'||WType, 'BUILDINGCLASS_'||WType, 'TXT_KEY_BUILDING_'||WType,	NULL,       -1,   -1,        -1,              1,          0
FROM MWfVPConfig WHERE WActive = 2;

INSERT INTO Language_en_US 
			(Tag,						Text) 
SELECT		'TXT_KEY_BUILDING_'||WType, WDummy
FROM MWfVPConfig WHERE WActive = 2;				
--------------------------------------------------------------
--------------------------------------------------------------
