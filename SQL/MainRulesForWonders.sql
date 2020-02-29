--------------------------------------------------------------
-- Automatic changes applied to all new Wonders
-- Dec 9, 2017: Created, Infixo
-- Jan 6, 2020: Improved, adan_eslavo
--============================================--
-- Table with new Wonder Types
--============================================--
CREATE TABLE VPWEConfig (
	WType	TEXT	NOT NULL,  	-- Wonder Type
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
INSERT INTO VPWEConfig	
			(WType,				WActive,	WFake)
VALUES		('ALTAMIRA',		1,			0),		-- Altamira Cave
			('GGANTIJA',		1,			0),		-- Ggantija
			('GOEBEKLI_TEPE',	1,			0),		-- Goebekli Tepe
			('MAJORVILLE',		1,			0),		-- Majorville Medicine Wheel
			('MOHENJO_DARO',	1,			0),		-- Mohenjo-Daro
			('SKARA_BRAE',		1,			0),		-- Skara Brae
			----------------------------------------------------------------------------------------
			('KARNAK',			1,			0),		-- Karnak Temple
			('NAZCA',			1,			0),		-- Nazca Lines
			('WIELICZKA',		1,			0),		-- Wieliczka Salt Mine
			----------------------------------------------------------------------------------------
			('MALWIYA',			1,			0),		-- Malwiya Minaret (Great Mosque of Samarra)
			('GATE_OF_SUN',		1,			0),		-- Gate of the Sun
			('BAMYAN',			1,			0),		-- Buddhas of Bamiyan
			('EL_GHRIBA',		1,			0),		-- El Ghriba Synagougue
			('ETCHMIADZIN',		1,			0),		-- Etchmiadzin Cathedral
			('CHAND_BAORI',		1,			0),		-- Chand Baori Well
			----------------------------------------------------------------------------------------
			('NABAWI',			1,			0),		-- Al-Masjid an-Nabawi (Prophet's Mosque)
			('LAVAUX',			1,			0),		-- Lavaux
			('WARTBURG',		1,			0),		-- Wartburg Castle
			('GREAT_ZIMBABWE',	1,			0),		-- Great Zimbabwe
			('FALUN',			1,			0),		-- Falun Mine
			--('AHU',		1,			0),		-- Ahu Tongariki
			('DAMASCUS',		1,			0),		-- Forge of Damascus
			('SHWEDAGON',		1,			0),		-- Shwedagon Pagoda / Shwedagon Zedi Daw / Great Dagon Pagoda  / Golden Pagoda
			('MICHEL',			1,			0),		-- Mont Saint Michel
			('ITSUKUSHIMA',		1,			0),		-- Itsukushima Shrine
			('QALHAT',			1,			0),		-- Qalhat
			('CHEVALIERS',		1,			0),		-- Krak des Chevaliers
			----------------------------------------------------------------------------------------
			('BENHADDOU',		1,			0),		-- Ait Benhaddou
			('KILWA_KISIWANI',	1,			0),		-- Kilwa Kisiwani
			('ST_PETERS',		1,			0),		-- Papal Basilica of St. Peter in the Vatican
			('KINKAKU_JI',		1,			0),		-- Golden Pavilion (Kikaku-Ji)
			('MARAE',			1,			0),		-- Marae Arahurahu
			('OLD_BRIDGE',		1,			0),		-- Old Bridge in Mostar
			('MEENAKSHI',		1,			0),		-- Meenakshi Temple
			('PETERHOF',		1,			0),		-- Peterhof Palace
			('BAKKEN',			1,			0),		-- Bakken
			('HOUSE_OF_TRADE',	1,			0),		-- House of Trade of the Indies (Casa de Contratación)
			('SOLOVIETSKY',		1,			0);		-- Solovietsky Monastery
			
			
--('ARECIBO',     1, 0), -- Arecibo Observatory
--('ANITKABIR',   1, 0), -- Anitkabir Mausoleum
--('BROOKLYN',    1, 0), -- Brooklyn Bridge
--('HOLLYWOOD',   1, 0), -- Hollywood
--('JUMEIRAH',    1, 0), -- Palm Jumeirah
--('MARINASANDS', 1, 1), -- Marina Bay Sands
--('METEORA', 1, 1), -- Monastery of the Holy Trinity (Meteora)
--('MILLAU',      1, 0), -- Millau Viaduct
--('MONTECARLO',  1, 0), -- Monte Carlo Casino, The
--('MUSEUM_ISLAND', 1, 0), --Museum Island
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
UPDATE VPWEConfig SET WActive = 0 WHERE WFake = 1;
--------------------------------------------------------------
-- BuildingClasses
INSERT INTO BuildingClasses 
			(Type,						Description,					DefaultBuilding,	MaxGlobalInstances)
SELECT		'BUILDINGCLASS_'||WType,	'TXT_KEY_BUILDING_'||WType,		'BUILDING_'||WType, 1
FROM VPWEConfig WHERE WActive = 1;
--------------------------------------------------------------
-- Buildings
-- MinAreaSize - change to 10 for Coastal Wonders!
-- Set Cost = -1 and later apply proper value for enabled buildings
-- GreatWorkCount defaults to 0, PrereqTech defaults to NULL
INSERT INTO Buildings
			(Type,               BuildingClass,           Description,                Civilopedia,                        Help,								Quote,								ThemingBonusHelp, Cost, FaithCost, NukeImmune, HurryCostModifier, MinAreaSize, ConquestProb, IconAtlas,						 PortraitIndex, WonderSplashImage,				WonderSplashAnchor)
SELECT		'BUILDING_'||WType, 'BUILDINGCLASS_'||WType, 'TXT_KEY_BUILDING_'||WType, 'TXT_KEY_WONDER_'||WType||'_PEDIA', 'TXT_KEY_WONDER_'||WType||'_HELP',	'TXT_KEY_WONDER_'||WType||'_QUOTE', NULL,             1,    0,         1,          -5,                -1,          100,          'ATLAS_NEW_WONDERS_'||WType,	0,             'Wonder_'||WType||'_splash.dds', 'R,T'
FROM VPWEConfig WHERE WActive = 1;
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
FROM VPWEConfig;

INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType,		BuildingClassType,			BuildingType)
SELECT		'CIVILIZATION_MINOR',	'BUILDINGCLASS_'||WType,	NULL 
FROM VPWEConfig;
--------------------------------------------------------------
-- Building_Flavors
-- Let's start with a default 20, can change later for specific Wonders
INSERT INTO Building_Flavors 
			(BuildingType,		FlavorType,			Flavor)
SELECT		'BUILDING_'||WType, 'FLAVOR_WONDER',	20
FROM VPWEConfig;
--------------------------------------------------------------
-- IconTextureAtlases
INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) SELECT 'ATLAS_NEW_WONDERS_'||WType, 256, 'Wonder_'||WType||'_256.dds',	'1', '1' FROM VPWEConfig;
INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) SELECT 'ATLAS_NEW_WONDERS_'||WType, 128, 'Wonder_'||WType||'_128.dds',	'1', '1' FROM VPWEConfig;
INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) SELECT 'ATLAS_NEW_WONDERS_'||WType,  80, 'Wonder_'||WType||'_80.dds',	'1', '1' FROM VPWEConfig;
INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) SELECT 'ATLAS_NEW_WONDERS_'||WType,  64, 'Wonder_'||WType||'_64.dds',	'1', '1' FROM VPWEConfig;
INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) SELECT 'ATLAS_NEW_WONDERS_'||WType,  45, 'Wonder_'||WType||'_45.dds',	'1', '1' FROM VPWEConfig;
--------------------------------------------------------------
-- Fake texts; if the real ones are created, set WFake to 0 (zero)
INSERT INTO Language_en_US (Tag, Text) SELECT 'TXT_KEY_BUILDING_'||WType,         'Wonder '||WType 					    FROM VPWEConfig WHERE WFake = 1;
INSERT INTO Language_en_US (Tag, Text) SELECT 'TXT_KEY_WONDER_'||WType||'_PEDIA', 'Civilopedia text for Wonder '||WType FROM VPWEConfig WHERE WFake = 1;
INSERT INTO Language_en_US (Tag, Text) SELECT 'TXT_KEY_WONDER_'||WType||'_HELP',  'Help text for Wonder '||WType 	    FROM VPWEConfig WHERE WFake = 1;
INSERT INTO Language_en_US (Tag, Text) SELECT 'TXT_KEY_WONDER_'||WType||'_QUOTE', '[NEWLINE]Quote for Wonder '||WType 	FROM VPWEConfig WHERE WFake = 1;
--============================================--
-- DUMMY BUILDINGS
-- HolyCity doesn't need one because it is usually 1 city; 2nd religion and 2nd Holy City might allow for 2nd Wonder
--============================================--
INSERT INTO VPWEConfig 
			(WType,							WName,					WActive,	WFake)
VALUES		('CHEVALIERS_DUMMY',			'Chevaliers',			2,			0), -- for Krak des Chevaliers
			('ITSUKUSHIMA_DUMMY',			'Itsukushima Shrine',	2,			0), -- for Itsukushima
			('QALHAT_DUMMY',				'Qalhat',				2,			0), -- for Qalhat
			('GATE_OF_SUN_DUMMY',			'Gate of the Sun',		2,			0), -- for Gate of the Sun
			('GREAT_ZIMBABWE_DUMMY',		'Great Zimbabwe',		2,			0), -- for Great Zimbabwe
			('KILWA_KISIWANI_DUMMY',		'Kilwa Kisiwani',		2,			0), -- for Kilwa Kisiwani
			('MARAE_DUMMY',					'Marae',				2,			0); -- for Marae Arahurahu

INSERT INTO BuildingClasses 
			(Type,						Description,				DefaultBuilding)
SELECT		'BUILDINGCLASS_'||WType,	'TXT_KEY_BUILDING_'||WType, 'BUILDING_'||WType
FROM VPWEConfig WHERE WActive = 2;

INSERT INTO Buildings
			(Type,               BuildingClass,           Description,					PrereqTech, Cost, FaithCost, GreatWorkCount , NukeImmune, ConquestProb)
SELECT		'BUILDING_'||WType, 'BUILDINGCLASS_'||WType, 'TXT_KEY_BUILDING_'||WType,	NULL,       -1,   -1,        -1,              1,          0
FROM VPWEConfig WHERE WActive = 2;

INSERT INTO Language_en_US 
			(Tag,						Text) 
SELECT		'TXT_KEY_BUILDING_'||WType, WName
FROM VPWEConfig WHERE WActive = 2;				
--------------------------------------------------------------
--------------------------------------------------------------
