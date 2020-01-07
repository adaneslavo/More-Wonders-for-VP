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
--============================================--
-- NEOLITHIC ERA
--============================================--
-- ALTAMIRA CAVE (NEW) - culture, culture from bison and deer, slot for art, defense;
	UPDATE Buildings SET Cost = 115, PrereqTech = 'TECH_AGRICULTURE',	NumPoliciesNeeded = 0, MaxStartEra = 'ERA_ANCIENT' WHERE Type = 'BUILDING_ALTAMIRA';
	UPDATE Buildings SET NearbyMountainRequired = 1 WHERE Type = 'BUILDING_ALTAMIRA';
	
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType,			ResourceType) 
	VALUES		('BUILDING_ALTAMIRA',	'RESOURCE_BISON'),
				('BUILDING_ALTAMIRA',	'RESOURCE_DEER');
	---------------------------------------------------------	
	UPDATE Buildings SET Defense = 500, GreatWorkSlotType = 'GREAT_WORK_SLOT_ART_ARTIFACT', GreatWorkCount = 1 WHERE Type = 'BUILDING_ALTAMIRA';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,			Yield) 
	VALUES		('BUILDING_ALTAMIRA',	'YIELD_CULTURE',	1);

	INSERT INTO Building_ResourceYieldChanges 
				(BuildingType,			ResourceType,		YieldType,			Yield) 
	VALUES		('BUILDING_ALTAMIRA',	'RESOURCE_BISON',	'YIELD_CULTURE',	1),
				('BUILDING_ALTAMIRA',	'RESOURCE_DEER',	'YIELD_CULTURE',	1);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,			Flavor) 
	VALUES		('BUILDING_ALTAMIRA',	'FLAVOR_DEFENSE',	10),
				('BUILDING_ALTAMIRA',	'FLAVOR_CULTURE',	60);
	---------------------------------------------------------	
	INSERT INTO Language_en_US 
				(Tag,								Text) 
	VALUES		('TXT_KEY_BUILDING_ALTAMIRA',		'Altamira Caves'),
				('TXT_KEY_WONDER_ALTAMIRA_HELP',	'Conatins 1 slot for [ICON_GREAT_WORK] Great Work of Art or an Artifact.[NEWLINE][NEWLINE]Nearby [ICON_RES_BISON] Bison: +1 [ICON_CULTURE] Culture.[NEWLINE]Nearby [ICON_RES_DEER] Deer: +1 [ICON_CULTURE] Culture.[NEWLINE][NEWLINE]City must have a [COLOR_CYAN]Mountain[ENDCOLOR] and [ICON_RES_BISON] Bison or [ICON_RES_DEER] Deer nearby.'),
				('TXT_KEY_WONDER_ALTAMIRA_QUOTE',	'[NEWLINE]"After Altamira everything seems decadent". [NEWLINE]- Pablo Picasso'),
				('TXT_KEY_WONDER_ALTAMIRA_PEDIA',	'The cave is approximately 1,000 m (3,280.84 ft) meters long and consists of a series of twisting passages and chambers. The main passage varies from two to six meters in height. The cave was formed through collapses following early karst phenomena in the calcareous rock of Mount Vispieres. Archaeological excavations in the cave floor found rich deposits of artifacts from the Upper Solutrean (c. 18,500 years ago) and Lower Magdalenian (between c. 16,590 and 14,000 years ago). Both periods belong to the Paleolithic or Old Stone Age. In the two millennia between these two occupations, the cave was evidently inhabited only by wild animals. Human occupants of the site were well-positioned to take advantage of the rich wildlife that grazed in the valleys of the surrounding mountains as well as the marine life available in nearby coastal areas. Around 13,000 years ago a rockfall sealed the cave''s entrance, preserving its contents until its eventual discovery, which occurred after a nearby tree fell and disturbed the fallen rocks. Human occupation was limited to the cave mouth, although paintings were created throughout the length of the cave. The artists used charcoal and ochre or hematite to create the images, often diluting these pigments to produce variations in intensity and creating an impression of chiaroscuro. They also exploited the natural contours of the cave walls to give their subjects a three-dimensional effect. The Polychrome Ceiling is the most impressive feature of the cave, depicting a herd of extinct steppe bison (Bison priscus) in different poses, two horses, a large doe, and possibly a wild boar. Dated to the Magdalenian occupation, these paintings include abstract shapes in addition to animal subjects. Solutrean paintings include images of horses and goats, as well as handprints that were created when artists placed their hands on the cave wall and blew pigment over them to leave a negative image. Numerous other caves in northern Spain contain Paleolithic art, but none is as complex or well-populated as Altamira.');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- GGANTIJA (NEW) - faith, global food, instant food;
	UPDATE Buildings SET Cost = 115, PrereqTech = 'TECH_AGRICULTURE',	NumPoliciesNeeded = 0, MaxStartEra = 'ERA_ANCIENT' WHERE Type = 'BUILDING_GGANTIJA';
	UPDATE Buildings SET Hill = 1, NearbyTerrainRequired = 'TERRAIN_PLAINS' WHERE Type = 'BUILDING_GGANTIJA';
	---------------------------------------------------------	
	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,		Yield)
	VALUES		('BUILDING_GGANTIJA',	'YIELD_FAITH',	2);

	INSERT INTO Building_GlobalYieldModifiers
				(BuildingType,			YieldType,		Yield)
	VALUES		('BUILDING_GGANTIJA',	'YIELD_FOOD',	5);

	INSERT INTO Building_InstantYield
				(BuildingType,			YieldType,		Yield) 
	VALUES		('BUILDING_GGANTIJA',	'YIELD_FOOD',	25);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors
				(BuildingType,			FlavorType,			Flavor)
	VALUES		('BUILDING_GGANTIJA',	'FLAVOR_RELIGION',	10),
				('BUILDING_GGANTIJA',	'FLAVOR_GROWTH',	50);
	---------------------------------------------------------	
	INSERT INTO Language_en_US 
				(Tag,								Text) 
	VALUES		('TXT_KEY_BUILDING_GGANTIJA',		'Ggantija'),
				('TXT_KEY_WONDER_GGANTIJA_HELP',	'+5% [ICON_FOOD] Food in all Cities. Grants 25 [ICON_FOOD] Food after construction. [NEWLINE][NEWLINE]City must be built on a [COLOR_CYAN]Hill[ENDCOLOR] and on or next to a [COLOR_CYAN]Plains[ENDCOLOR].'),
				('TXT_KEY_WONDER_GGANTIJA_QUOTE',	'[NEWLINE]"Growth is the only evidence of life."[NEWLINE] - John Henry Newman[NEWLINE]'),
				('TXT_KEY_WONDER_GGANTIJA_PEDIA',	'Ggantija (Giants'' Tower) is a megalithic temple complex in Malta on the Mediterranean island of Gozo. Its makers erected the two Ggantija temples during the Neolithic Age (c. 3600-2500 BC), which makes the buildings more than 5500 years old and the world''s second oldest manmade religious structures, after Gobekli Tepe. The temples were possibly the site of a Fertility cult - archeologists believe that the numerous figurines and statues found on site are connected with that cult.');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- GOEBEKLI TEPE (NEW) - faith, culture, science, faith from mountains, science from marble and stone;
	UPDATE Buildings SET Cost = 115, PrereqTech = 'TECH_AGRICULTURE', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_ANCIENT' WHERE Type = 'BUILDING_GOEBEKLI_TEPE';
	UPDATE Buildings SET NearbyMountainRequired = 1, River = 1 WHERE Type = 'BUILDING_GOEBEKLI_TEPE';
	---------------------------------------------------------	
	INSERT INTO Building_YieldChanges
				(BuildingType,				YieldType,			Yield) 
	VALUES		('BUILDING_GOEBEKLI_TEPE',	'YIELD_CULTURE',	1),
				('BUILDING_GOEBEKLI_TEPE',	'YIELD_SCIENCE',	1),
				('BUILDING_GOEBEKLI_TEPE',	'YIELD_FAITH',		1);

	INSERT INTO Building_ResourceYieldChanges 
				(BuildingType,				ResourceType,		YieldType,			Yield) 
	VALUES		('BUILDING_GOEBEKLI_TEPE',	'RESOURCE_MARBLE',	'YIELD_SCIENCE',	1),
				('BUILDING_GOEBEKLI_TEPE',	'RESOURCE_STONE',	'YIELD_SCIENCE',	1);

	INSERT INTO Building_TerrainYieldChanges 
				(BuildingType,				TerrainType,		YieldType,		Yield) 
	VALUES		('BUILDING_GOEBEKLI_TEPE',	'TERRAIN_MOUNTAIN', 'YIELD_FAITH',	1);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,				FlavorType,			Flavor) 
	VALUES		('BUILDING_GOEBEKLI_TEPE',	'FLAVOR_CULTURE',	10),
				('BUILDING_GOEBEKLI_TEPE',	'FLAVOR_SCIENCE',	40),
				('BUILDING_GOEBEKLI_TEPE',	'FLAVOR_RELIGION',	40);
	---------------------------------------------------------	
	INSERT INTO Language_en_US 
				(Tag,									Text) 
	VALUES		('TXT_KEY_BUILDING_GOEBEKLI_TEPE',		'Goebekli Tepe'),
				('TXT_KEY_WONDER_GOEBEKLI_TEPE_HELP',	'+1 [ICON_PEACE] Faith from Mountains worked by the City.[NEWLINE][NEWLINE]Nearby [ICON_RES_MARBLE] Marble: +1 [ICON_RESEARCH] Science.[NEWLINE]Nearby [ICON_RES_STONE] Stone: +1 [ICON_RESEARCH] Science.[NEWLINE][NEWLINE]City must be built next to a [COLOR_CYAN]River[ENDCOLOR] and have a [COLOR_CYAN]Mountain[ENDCOLOR] nearby.'),
				('TXT_KEY_WONDER_GOEBEKLI_TEPE_QUOTE',	'[NEWLINE]"Listen a hundred times. Ponder a thousand times. Speak once."[NEWLINE] - Turkish Proverb[NEWLINE]'),
				('TXT_KEY_WONDER_GOEBEKLI_TEPE_PEDIA',	'Göbekli Tepe is a religious site located in southern Turkey, near the Syrian border. It is the oldest known religious building on earth, dating to approximately 10000 BCE, during the Neolithic age of Human civilization, and predating all major civilizations and cities by several millenia. It was first observed during the 1960''s, when archeologists noted that the hill could not be natural due to the shape, yet dismissed it as a Byzantine burial ground. It was not thought different until 1994, and not excavated until a year later. The complex is similar in manner to Stonehenge, with a round shape and large Monolithic stones. However, unlike Stonehenge, many of the pillars are carved with the figures of several animals, which are believed to have been sacred to the hunter-gatherers which constructed Göbekli Tepe.');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- SKARA BRAE (NEW) - food and production, global food from Deer, Fish, Cattle, Sheep and Wheet;
	UPDATE Buildings SET Cost = 115, PrereqTech = 'TECH_AGRICULTURE',	NumPoliciesNeeded = 0, MaxStartEra = 'ERA_ANCIENT' WHERE Type = 'BUILDING_SKARA_BRAE';
	UPDATE Buildings SET Water = 1, MinAreaSize = 10, ProhibitedCityTerrain = 'TERRAIN_DESERT'  WHERE Type = 'BUILDING_SKARA_BRAE';
	
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType, ResourceType) 
	VALUES		('BUILDING_SKARA_BRAE', 'RESOURCE_FISH'),
				('BUILDING_SKARA_BRAE', 'RESOURCE_COW'),
				('BUILDING_SKARA_BRAE', 'RESOURCE_WHEAT'),
				('BUILDING_SKARA_BRAE', 'RESOURCE_SHEEP'),
				('BUILDING_SKARA_BRAE', 'RESOURCE_DEER');
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
				('BUILDING_SKARA_BRAE', 'RESOURCE_SHEEP',	'YIELD_FOOD',	1),
				('BUILDING_SKARA_BRAE', 'RESOURCE_DEER',	'YIELD_FOOD',	1);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor) 
	VALUES		('BUILDING_SKARA_BRAE', 'FLAVOR_PRODUCTION',	10),
				('BUILDING_SKARA_BRAE', 'FLAVOR_GROWTH',		60);
	---------------------------------------------------------	
	INSERT INTO Language_en_US 
													(Tag, Text)
	VALUES		('TXT_KEY_BUILDING_SKARA_BRAE',     'Skara Brae'),
				('TXT_KEY_WONDER_SKARA_BRAE_HELP',  'All [ICON_RES_COW] Cattle: +1 [ICON_FOOD] Food.[NEWLINE]All [ICON_RES_DEER] Deer: +1 [ICON_FOOD] Food.[NEWLINE]All [ICON_RES_FISH] Fish: +1 [ICON_FOOD] Food.[NEWLINE]All [ICON_RES_SHEEP] Sheep: +1 [ICON_FOOD] Food.[NEWLINE]All [ICON_RES_WHEAT] Wheat: +1 [ICON_FOOD] Food.[NEWLINE][NEWLINE]City must be built on a [COLOR_CYAN]Coast[ENDCOLOR] and have [ICON_RES_COW] Cattle, [ICON_RES_DEER] Deer, [ICON_RES_FISH] Fish, [ICON_RES_SHEEP] Sheep or [ICON_RES_WHEAT] Wheat nearby. Cannot be built if [COLOR_RED]Desert[ENDCOLOR] is next to it.'),
				('TXT_KEY_WONDER_SKARA_BRAE_QUOTE', '[NEWLINE]"No great thing is created suddenly."[NEWLINE] - Epictetus[NEWLINE]'),
				('TXT_KEY_WONDER_SKARA_BRAE_PEDIA', 'Skara Brae is a stone-built Neolithic settlement, located on the Bay of Skaill on the west coast of Mainland, the largest island in the Orkney archipelago of Scotland. It consists of eight clustered houses, and was occupied from roughly 3180 BC - 2500 BC.[NEWLINE][NEWLINE]Given the number of homes, it seems likely that no more than fifty people lived in Skara Brae at any given time. Apart from being makers and users of grooved ware, a distinctive style of pottery that appeared in northern Scotland not long before the establishment of the village, they were primarily pastorialists who raised cattle and sheep.');
--============================================--
-- ANCIENT ERA
--============================================--
-- KARNAK (NEW) - late game tourism, faith and production, faith and culture from Oasis and Flood Plains, free Monument;
	UPDATE Buildings SET Cost = 150, PrereqTech = 'TECH_POTTERY',	NumPoliciesNeeded = 0, MaxStartEra = 'ERA_CLASSICAL' WHERE Type = 'BUILDING_KARNAK';
	UPDATE Buildings SET NearbyTerrainRequired = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_KARNAK';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,			FeatureType) 
	VALUES		('BUILDING_KARNAK',		'FEATURE_OASIS'),
				('BUILDING_KARNAK',		'FEATURE_FLOOD_PLAINS');
	---------------------------------------------------------	
	UPDATE Buildings SET FreeBuildingThisCity = 'BUILDINGCLASS_MONUMENT', EnhancedYieldTech = 'TECH_ARCHAEOLOGY', TechEnhancedTourism = 4 WHERE Type = 'BUILDING_KARNAK';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,		YieldType,			Yield) 
	VALUES		('BUILDING_KARNAK', 'YIELD_PRODUCTION',	1),
				('BUILDING_KARNAK', 'YIELD_FAITH',		1);
	
	INSERT INTO Building_YieldPerXFeatureTimes100 
				(BuildingType,		FeatureType,			YieldType,			Yield) 
	VALUES		('BUILDING_KARNAK', 'FEATURE_OASIS',		'YIELD_CULTURE',	100),
				('BUILDING_KARNAK', 'FEATURE_OASIS',		'YIELD_FAITH',		100),
				('BUILDING_KARNAK', 'FEATURE_FLOOD_PLAINS', 'YIELD_CULTURE',	50),
				('BUILDING_KARNAK', 'FEATURE_FLOOD_PLAINS', 'YIELD_FAITH',		50);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,		FlavorType,				Flavor) 
	VALUES		('BUILDING_KARNAK', 'FLAVOR_CULTURE',		40),
				('BUILDING_KARNAK', 'FLAVOR_HAPPINESS',		20),
				('BUILDING_KARNAK', 'FLAVOR_PRODUCTION',	20),
				('BUILDING_KARNAK', 'FLAVOR_RELIGION',		40);
	---------------------------------------------------------	
	INSERT INTO Language_en_US 
				(Tag,							Text) 
	VALUES		('TXT_KEY_BUILDING_KARNAK',     'Karnak'),
				('TXT_KEY_WONDER_KARNAK_HELP',  'Free [COLOR_POSITIVE_TEXT]Monument[ENDCOLOR] in this City. +1 [ICON_CULTURE] Culture and +1 [ICON_PEACE] Faith from each Oasis and every 2 Flood Plains worked by this City. +4 [ICON_TOURISM] Tourism with Archeology.[NEWLINE][NEWLINE]City must be built on or next a [COLOR_CYAN]Desert[ENDCOLOR] and have [COLOR_CYAN]Flood Plains[ENDCOLOR] or an [COLOR_CYAN]Oasis[ENDCOLOR] nearby.'),
				('TXT_KEY_WONDER_KARNAK_QUOTE', '[NEWLINE]"The body is the house of god. That is why it is said ''Man know yourself''."[NEWLINE] - Egyptian Proverb[NEWLINE]'),
				('TXT_KEY_WONDER_KARNAK_PEDIA', 'Karnak is a large temple complex located in Thebes (nowadays is Luxor). It was constructed during the reign of Ramesses II as a place of worship for many different gods and goddesses, instead of focusing on just one member of the Egyptian Pantheon.[NEWLINE][NEWLINE]  The complex is a vast open-air museum, and the second largest ancient religious site in the world (after the Angkor Wat in Cambodia). It is believed to be the second most visited historical site in Egypt, only the Giza Pyramids near Cairo receive more visits.[NEWLINE][NEWLINE]  One famous aspect of Karnak is the Hypostyle Hall in the Precinct of Amun-Re, a hall area of 50,000 sq ft (5,000 m2) with 134 massive columns arranged in 16 rows. 122 of these columns are 10 meters tall, and the other 12 are 21 meters tall with a diameter of over three meters.');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- STONEHENGE
	UPDATE Buildings SET NearbyTerrainRequired = 'TERRAIN_GRASS' WHERE Type = 'BUILDING_STONEHENGE';
	UPDATE Buildings SET Flat = 1 WHERE Type = 'BUILDING_STONEHENGE';
	---------------------------------------------------------	
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must be built on a [COLOR_CYAN]Flat[ENDCOLOR] and on or next to a [COLOR_CYAN]Grasslands[ENDCOLOR].' WHERE Tag ='TXT_KEY_BUILDING_STONEHENGE_HELP';
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- NAZCA (NEW) - late game tourism, science, scientist, food and faith from Plains, faith to Shrines;
	UPDATE Buildings SET Cost = 150, PrereqTech = 'TECH_TRAPPING',	NumPoliciesNeeded = 1, MaxStartEra = 'ERA_CLASSICAL' WHERE Type = 'BUILDING_NAZCA';
	UPDATE Buildings SET Hill = 1, NearbyTerrainRequired = 'TERRAIN_PLAINS' WHERE Type = 'BUILDING_NAZCA';
	---------------------------------------------------------	
	UPDATE Buildings SET EnhancedYieldTech = 'TECH_FLIGHT', TechEnhancedTourism = 4, SpecialistType = 'SPECIALIST_SCIENTIST', GreatPeopleRateChange = 1 WHERE Type = 'BUILDING_NAZCA';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,		YieldType,			Yield) 
	VALUES		('BUILDING_NAZCA',	'YIELD_SCIENCE',	1);
	
	INSERT INTO Building_TerrainYieldChanges 
				(BuildingType,		TerrainType,		YieldType,		Yield) 
	VALUES		('BUILDING_NAZCA',	'TERRAIN_PLAINS',	'YIELD_FOOD',	1),
				('BUILDING_NAZCA',	'TERRAIN_PLAINS',	'YIELD_FAITH',	1);
	
	INSERT INTO Building_BuildingClassYieldChanges 
				(BuildingType,		BuildingClassType,		YieldType,		YieldChange) 
	VALUES		('BUILDING_NAZCA',	'BUILDINGCLASS_SHRINE', 'YIELD_FAITH',	1);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,		FlavorType,			Flavor) 
	VALUES		('BUILDING_NAZCA',	'FLAVOR_GROWTH',	40),
				('BUILDING_NAZCA',	'FLAVOR_RELIGION',	40),
				('BUILDING_NAZCA',	'FLAVOR_SCIENCE',	20);
	---------------------------------------------------------	
	INSERT INTO Language_en_US 
				(Tag,							Text) 
	VALUES		('TXT_KEY_BUILDING_NAZCA',		'Nazca Lines'),
				('TXT_KEY_WONDER_NAZCA_HELP',	'+1 [ICON_FOOD] Food and +1 [ICON_PEACE] Faith from nearby Plains worked by the City. All Shrines receive +1 [ICON_PEACE] Faith. +4 [ICON_TOURISM] Tourism with Flight.[NEWLINE][NEWLINE]City must be built on a [COLOR_CYAN]Hill[ENDCOLOR] and on or next to [COLOR_CYAN]Plains[ENDCOLOR].'),
				('TXT_KEY_WONDER_NAZCA_QUOTE',	'[NEWLINE]"The true mystery of the world is the visible, not the invisible."[NEWLINE] - Oscar Wilde[NEWLINE]'),
				('TXT_KEY_WONDER_NAZCA_PEDIA',	'The Nazca Lines, located between the Peruvian towns of Nazca and Palpa, are a series of enormous Geoglyphs designed on a large plateau, spanning over 80 kilometres. The designs have long been a source of mystery for those who have gazed upon them. It is estimated that the lines were constructed by the Nazca culture, hense the name, between 450 and 600 CE. The level of complexity of design varies between designs. Some are simple lines hundreds of metres long, while others are incredibly complex patterns resembling a variety of zoological designs - Monkeys, Condors, Spiders and Orca (Killer whale) to name but a few.[NEWLINE][NEWLINE]  The Nazca Lines are particularily popular amongst circles which believe in the existance of extra-terrestrial life, which the Nazca culture mistook for their gods. They believe that the simpler, straight lines are in fact landing strips for interstellar crafts used by the extra-terrestrials to land, and that a humanoid figure represented in the patterns is one of the extraterrestrials. Modern science has had a range of theories, amongst which the lines serving a purpose similar to that of Stonehenge as an early form of an observatory / astronomical calendar. Other theories were that the geometric lines could indicate the flow of water, irrigation schemes, or be a part of rituals to "summon" water. However, to this day the exact purpose of the lines remains a mystery.');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- PYRAMIDS
	UPDATE Buildings SET Flat = 1, ProhibitedCityTerrain = 'TERRAIN_TUNDRA' WHERE Type = 'BUILDING_PYRAMID';
	
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType,			ResourceType) 
	VALUES		('BUILDING_PYRAMID',	'RESOURCE_STONE');
	---------------------------------------------------------	
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must be built on a [COLOR_CYAN]Flat[ENDCOLOR] and have [COLOR_CYAN]Stone[ENDCOLOR] nearby. Cannot be built if [COLOR_RED]Tundra[ENDCOLOR] is nearby.' WHERE Tag ='TXT_KEY_WONDER_CHICHEN_ITZA_HELP';
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- WIELICZKA (NEW) - late game tourism, +2 Salt, production, 5% global food, food from Salt;
	UPDATE Buildings SET Cost = 150, PrereqTech = 'TECH_MINING', NumPoliciesNeeded = 0, MaxStartEra = 'ERA_CLASSICAL' WHERE Type = 'BUILDING_WIELICZKA';
	
	INSERT INTO Building_LocalResourceOrs 
	(BuildingType, ResourceType) 
	VALUES ('BUILDING_PYRAMID', 'RESOURCE_SALT');
	---------------------------------------------------------	
	UPDATE Buildings SET EnhancedYieldTech = 'TECH_SCIENTIFIC_THEORY', TechEnhancedTourism = 2 WHERE Type = 'BUILDING_WIELICZKA';
	
	INSERT INTO Building_YieldChanges 
				(BuildingType,			YieldType,			Yield) 
	VALUES		('BUILDING_WIELICZKA',	'YIELD_PRODUCTION', 1);
	
	INSERT INTO Building_ResourceYieldChanges 
				(BuildingType,			ResourceType,		YieldType,		Yield) 
	VALUES		('BUILDING_WIELICZKA',	'RESOURCE_SALT',	'YIELD_FOOD',	1);
	
	INSERT INTO Building_ResourceQuantity 
				(BuildingType,			ResourceType,		Quantity) 
	VALUES		('BUILDING_WIELICZKA',	'RESOURCE_SALT',	2);
	
	INSERT INTO Building_GlobalYieldModifiers 
				(BuildingType,			YieldType,		Yield) 
	VALUES		('BUILDING_WIELICZKA',	'YIELD_FOOD',	5);
	---------------------------------------------------------	
	INSERT INTO Building_Flavors 
				(BuildingType,			FlavorType,				Flavor) 
	VALUES		('BUILDING_WIELICZKA',	'FLAVOR_GROWTH',		50),
				('BUILDING_WIELICZKA',	'FLAVOR_PRODUCTION',	10),
				('BUILDING_WIELICZKA',	'FLAVOR_CULTURE',		10),
				('BUILDING_WIELICZKA',	'FLAVOR_HAPPINESS',		40);
	---------------------------------------------------------	
	INSERT INTO Language_en_US 
				(Tag,								Text) 
	VALUES		('TXT_KEY_BUILDING_WIELICZKA',		'Wieliczka Salt Mine'),
				('TXT_KEY_WONDER_WIELICZKA_HELP',	'City gains 2 copies of [ICON_RES_SALT] Salt resource. +5% [ICON_FOOD] Food in all Cities. +2 [ICON_TOURISM] Tourism with Scientific Theory.[NEWLINE][NEWLINE]Nearby [ICON_RES_SALT] Salt: +1 [ICON_FOOD] Food.[NEWLINE][NEWLINE]City must have [ICON_RES_SALT] Salt nearby.'),
				('TXT_KEY_WONDER_WIELICZKA_QUOTE',	'[NEWLINE]"You are the salt of the earth. But remember that salt is useful when in association, but useless in isolation."[NEWLINE] - Israelmore Ayivor[NEWLINE]'),
				('TXT_KEY_WONDER_WIELICZKA_PEDIA',	'The Wieliczka Salt Mine, in the town of Wieliczka, southern Poland, lies within the Kraków metropolitan area. Sodium chloride (table salt) was formerly produced there from the upwelling brine - and had been since Neolithic times. The Wieliczka salt mine, excavated from the 13th century, produced table salt continuously until 2007, as one of the world''s oldest operating salt mines.');
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- PETRA
	UPDATE Buildings SET Mountain = 1, NearbyTerrainRequired = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_PETRA';
	---------------------------------------------------------	
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must be built on or next to a [COLOR_CYAN]Desert[ENDCOLOR] and next to a [COLOR_CYAN]Mountain[ENDCOLOR].' WHERE Tag ='TXT_KEY_WONDER_PETRA_HELP';
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- TEMPLE OF ARTEMIS
	UPDATE Buildings SET Flat = 1, ProhibitedCityTerrain = 'TERRAIN_DESERT' WHERE Type = 'BUILDING_TEMPLE_ARTEMIS';
	
	INSERT INTO Building_LocalFeatureOrs 
				(BuildingType,				FeatureType) 
	VALUES		('BUILDING_TEMPLE_ARTEMIS', 'FEATURE_FOREST');
	---------------------------------------------------------	
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must be built on or next to a [COLOR_CYAN]Flat[ENDCOLOR] and have [COLOR_CYAN]Forest[ENDCOLOR] nearby. Cannot be built if [COLOR_RED]Desert[ENDCOLOR] is nearby.' WHERE Tag ='TXT_KEY_WONDER_TEMPLE_ARTEMIS_HELP';
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- MAUSOLEUM OF HALICARNASSUS
	UPDATE Buildings SET Water = 1, MinAreaSize = 10, Hill = 1 WHERE Type = 'BUILDING_MAUSOLEUM_HALICARNASSUS';
	---------------------------------------------------------	
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must be built on a [COLOR_CYAN]Coast[ENDCOLOR] and [COLOR_CYAN]Hill[ENDCOLOR].' WHERE Tag ='TXT_KEY_WONDER_MAUSOLEUM_HALICARNASSUS_HELP';
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- STATUE OF ZEUS
	INSERT INTO Building_LocalResourceOrs 
				(BuildingType,				ResourceType) 
	VALUES		('BUILDING_STATUE_ZEUS',	'RESOURCE_MARBLE');
	---------------------------------------------------------	
	UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must have [COLOR_CYAN]Marble[ENDCOLOR] nearby.' WHERE Tag ='TXT_KEY_WONDER_STATUE_ZEUS_HELP';
--============================================--
-- CLASSICAL ERA
--============================================--