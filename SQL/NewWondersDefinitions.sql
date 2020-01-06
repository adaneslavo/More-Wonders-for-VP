----------------------------------------------------
-- Vox Populi Wonders Expanded
-- Main file for all Wonders
-- Author: Infixo, adan_eslavo
-- Dec 9, 2017: Created
-- Jan 6, 2020: Improved
----------------------------------------------------
-- Promotion Icons Atlas
----------------------------------------------------
INSERT INTO IconTextureAtlases	(Atlas,				IconSize,	Filename,			IconsPerRow,	IconsPerColumn) 
VALUES							('vpwe_promoAtlas', 256,		'WE_PI_256.dds',	'2',			'1'),
								('vpwe_promoAtlas', 064,		'WE_PI_064.dds',	'2',			'1'),
								('vpwe_promoAtlas', 045,		'WE_PI_045.dds',	'2',			'1'),
								('vpwe_promoAtlas', 032,		'WE_PI_032.dds',	'2',			'1'),
								('vpwe_promoAtlas', 016,		'WE_PI_016.dds',	'2',			'1');
----------------------------------------------------
-- ANCIENT ERA
----------------------------------------------------
-- KARNAK (NEW) - Late game tourism, faith and production, faith and culture from oasis and flood plains, free monument
	UPDATE Buildings SET Cost = 150, PrereqTech = 'TECH_POTTERY',	NumPoliciesNeeded = 0, MaxStartEra = 'ERA_CLASSICAL' WHERE Type = 'BUILDING_KARNAK';
	UPDATE Buildings SET NearbyTerrainRequired = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_KARNAK';
	INSERT INTO Building_LocalFeatureOrs (BuildingType, FeatureType) VALUES ('BUILDING_KARNAK', 'FEATURE_OASIS'),
																			('BUILDING_KARNAK', 'FEATURE_FLOOD_PLAINS');
	UPDATE Buildings SET FreeBuildingThisCity = 'BUILDINGCLASS_MONUMENT', EnhancedYieldTech = 'TECH_ARCHAEOLOGY', TechEnhancedTourism = 4 WHERE Type = 'BUILDING_KARNAK';
	INSERT INTO Building_FeatureYieldChanges (BuildingType, FeatureType, YieldType, Yield) VALUES	('BUILDING_KARNAK', 'FEATURE_OASIS', 'YIELD_PRODUCTION',	1),
																									('BUILDING_KARNAK', 'FEATURE_OASIS', 'YIELD_FAITH',			1);
	INSERT INTO Building_YieldPerXFeatureTimes100 (BuildingType, FeatureType, YieldType, Yield) VALUES	('BUILDING_KARNAK', 'FEATURE_OASIS',		'YIELD_CULTURE',	100),
																										('BUILDING_KARNAK', 'FEATURE_OASIS',		'YIELD_FAITH',		100),
																										('BUILDING_KARNAK', 'FEATURE_FLOOD_PLAINS', 'YIELD_CULTURE',	50),
																										('BUILDING_KARNAK', 'FEATURE_FLOOD_PLAINS', 'YIELD_FAITH',		50);
	INSERT INTO Building_Flavors (BuildingType, FlavorType, Flavor) VALUES	('BUILDING_KARNAK', 'FLAVOR_CULTURE',		40),
																			('BUILDING_KARNAK', 'FLAVOR_HAPPINESS',		20),
																			('BUILDING_KARNAK', 'FLAVOR_PRODUCTION',	20),
																			('BUILDING_KARNAK', 'FLAVOR_RELIGION',		40);
	INSERT INTO Language_en_US (Tag, Text) VALUES	('TXT_KEY_BUILDING_KARNAK',     'Karnak'),
													('TXT_KEY_WONDER_KARNAK_HELP',  'Free [COLOR_POSITIVE_TEXT]Monument[ENDCOLOR] in this City. +1 [ICON_CULTURE] Culture and +1 [ICON_PEACE] Faith from each Oases and every 2 Flood Plains worked by this City. +4 [ICON_TOURISM] Tourism with Archeology.[NEWLINE][NEWLINE]City must be built on or next a [COLOR_CYAN]Desert[ENDCOLOR] and have [COLOR_CYAN]Flood Plains[ENDCOLOR] or an [COLOR_CYAN]Oasis[ENDCOLOR] nearby.'),
													('TXT_KEY_WONDER_KARNAK_QUOTE', '[NEWLINE]"The body is the house of god. That is why it is said ''Man know yourself''"[NEWLINE] - Egyptian Proverb[NEWLINE]'),
													('TXT_KEY_WONDER_KARNAK_PEDIA', 'Karnak is a large temple complex located in Thebes (nowadays is Luxor). It was constructed during the reign of Ramesses II as a place of worship for many different gods and goddesses, instead of focusing on just one member of the Egyptian Pantheon.[NEWLINE][NEWLINE]  The complex is a vast open-air museum, and the second largest ancient religious site in the world (after the Angkor Wat in Cambodia). It is believed to be the second most visited historical site in Egypt, only the Giza Pyramids near Cairo receive more visits.[NEWLINE][NEWLINE]  One famous aspect of Karnak is the Hypostyle Hall in the Precinct of Amun-Re, a hall area of 50,000 sq ft (5,000 m2) with 134 massive columns arranged in 16 rows. 122 of these columns are 10 meters tall, and the other 12 are 21 meters tall with a diameter of over three meters.');

-- STONEHENGE
	UPDATE Buildings SET NearbyTerrainRequired = 'TERRAIN_PLAINS' WHERE Type = 'BUILDING_STONEHENGE';
	UPDATE Buildings SET Flat = 1 WHERE Type = 'BUILDING_STONEHENGE';
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must be built on a [COLOR_CYAN]Flat[ENDCOLOR] and on or next to a [COLOR_CYAN]Plains[ENDCOLOR].' WHERE Tag ='TXT_KEY_BUILDING_STONEHENGE_HELP';

-- NAZCA (NEW) - Late game tourism, science, scientist, food and faith from planes, faith to shrines
	UPDATE Buildings SET Cost = 150, PrereqTech = 'TECH_MINING',	NumPoliciesNeeded = 1, MaxStartEra = 'ERA_CLASSICAL' WHERE Type = 'BUILDING_NAZCA';
	UPDATE Buildings SET NearbyTerrainRequired = 'TERRAIN_PLAINS' WHERE Type = 'BUILDING_NAZCA';
	UPDATE Buildings SET Hill = 1 WHERE Type = 'BUILDING_NAZCA';
	UPDATE Buildings SET EnhancedYieldTech = 'TECH_FLIGHT', TechEnhancedTourism = 4, SpecialistType = 'SPECIALIST_SCIENTIST', GreatPeopleRateChange = 1 WHERE Type = 'BUILDING_NAZCA';
	INSERT INTO Building_YieldChanges (BuildingType, YieldType, Yield) VALUES ('BUILDING_NAZCA', 'YIELD_SCIENCE', 1);
	INSERT INTO Building_TerrainYieldChanges (BuildingType, TerrainType, YieldType, Yield) VALUES	('BUILDING_NAZCA', 'TERRAIN_PLAINS', 'YIELD_FOOD', 1),
																									('BUILDING_NAZCA', 'TERRAIN_PLAINS', 'YIELD_FAITH', 1);
	INSERT INTO Building_BuildingClassYieldChanges (BuildingType, BuildingClassType, YieldType, YieldChange) VALUES	('BUILDING_NAZCA', 'BUILDINGCLASS_SHRINE', 'YIELD_FAITH', 1);
	INSERT INTO Building_Flavors (BuildingType, FlavorType, Flavor) VALUES	('BUILDING_NAZCA', 'FLAVOR_GROWTH',		40),
																			('BUILDING_NAZCA', 'FLAVOR_RELIGION',	40),
																			('BUILDING_NAZCA', 'FLAVOR_SCIENCE',	20);
	INSERT INTO Language_en_US (Tag, Text) VALUES	('TXT_KEY_BUILDING_NAZCA',     'Nazca Lines'),
													('TXT_KEY_WONDER_NAZCA_HELP',  '+1 [ICON_FOOD] Food and +1 [ICON_PEACE] Faith from nearby Plains worked by the City. All Shrines receive +1 [ICON_PEACE] Faith. +4 [ICON_TOURISM] Tourism with Flight.[NEWLINE][NEWLINE]City must be built on a [COLOR_CYAN]Hill[ENDCOLOR] and on or next to [COLOR_CYAN]Plains[ENDCOLOR].'),
													('TXT_KEY_WONDER_NAZCA_QUOTE', '[NEWLINE]"The true mystery of the world is the visible, not the invisible."[NEWLINE] - Oscar Wilde[NEWLINE]'),
													('TXT_KEY_WONDER_NAZCA_PEDIA', 'The Nazca Lines, located between the Peruvian towns of Nazca and Palpa, are a series of enormous Geoglyphs designed on a large plateau, spanning over 80 kilometres. The designs have long been a source of mystery for those who have gazed upon them. It is estimated that the lines were constructed by the Nazca culture, hense the name, between 450 and 600 CE. The level of complexity of design varies between designs. Some are simple lines hundreds of metres long, while others are incredibly complex patterns resembling a variety of zoological designs - Monkeys, Condors, Spiders and Orca (Killer whale) to name but a few.[NEWLINE][NEWLINE]  The Nazca Lines are particularily popular amongst circles which believe in the existance of extra-terrestrial life, which the Nazca culture mistook for their gods. They believe that the simpler, straight lines are in fact landing strips for interstellar crafts used by the extra-terrestrials to land, and that a humanoid figure represented in the patterns is one of the extraterrestrials. Modern science has had a range of theories, amongst which the lines serving a purpose similar to that of Stonehenge as an early form of an observatory / astronomical calendar. Other theories were that the geometric lines could indicate the flow of water, irrigation schemes, or be a part of rituals to "summon" water. However, to this day the exact purpose of the lines remains a mystery.');

-- PYRAMIDS
	INSERT INTO Building_LocalResourceOrs (BuildingType, ResourceType) VALUES ('BUILDING_PYRAMID', 'RESOURCE_STONE');
	UPDATE Buildings SET Flat = 1 WHERE Type = 'BUILDING_PYRAMID';
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must be built on a [COLOR_CYAN]Flat[ENDCOLOR] and have [COLOR_CYAN]Stone[ENDCOLOR] resource nearby.' WHERE Tag ='TXT_KEY_WONDER_CHICHEN_ITZA_HELP';

-- PETRA
	UPDATE Buildings SET NearbyTerrainRequired = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_PETRA';
	UPDATE Buildings SET Mountain = 1 WHERE Type = 'BUILDING_PETRA';
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must be built on or next to a [COLOR_CYAN]Desert[ENDCOLOR] and next to a [COLOR_CYAN]Mountain[ENDCOLOR].' WHERE Tag ='TXT_KEY_WONDER_PETRA_HELP';

-- TEMPLE OF ARTEMIS
	UPDATE Buildings SET Flat = 1 WHERE Type = 'BUILDING_TEMPLE_ARTEMIS';
	INSERT INTO Building_LocalFeatureOrs (BuildingType, FeatureType) VALUES ('BUILDING_TEMPLE_ARTEMIS', 'FEATURE_FOREST');
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must be built on or next to a [COLOR_CYAN]Flat[ENDCOLOR] and have [COLOR_CYAN]Forest[ENDCOLOR] nearby.' WHERE Tag ='TXT_KEY_WONDER_TEMPLE_ARTEMIS_HELP';

-- MAUSOLEUM OF HALICARNASSUSS
	UPDATE Buildings SET Water = 1, MinAreaSize = 10 WHERE Type = 'BUILDING_MAUSOLEUM_HALICARNASSUS';
	UPDATE Buildings SET Hill = 1 WHERE Type = 'BUILDING_MAUSOLEUM_HALICARNASSUS';
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must be built on a [COLOR_CYAN]Hill[ENDCOLOR] and next to a [COLOR_CYAN]Sea[ENDCOLOR].' WHERE Tag ='TXT_KEY_WONDER_MAUSOLEUM_HALICARNASSUS_HELP';

-- STATUE OF ZEUS
	INSERT INTO Building_LocalResourceOrs (BuildingType, ResourceType) VALUES ('BUILDING_STATUE_ZEUS', 'RESOURCE_MARBLE');
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must have [COLOR_CYAN]Marble[ENDCOLOR] resource nearby.' WHERE Tag ='TXT_KEY_WONDER_STATUE_ZEUS_HELP';