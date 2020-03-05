----------------------------------------------------
-- Text file for all Wonders
-- Feb 20, 2020: Created, adan_eslavo
----------------------------------------------------
/*
New HELP texts!
0 = Normal HELP texts made with VP standard;
1 = Better HELP texts. (Default)
*/

INSERT INTO COMMUNITY	
		(Type,			Value)
VALUES	('MW-HELP', 	1);
----------------------------------------------------
----------------------------------------------------
-- Altamira Cave
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_ALTAMIRA',			'Altamira Cave'),
			('TXT_KEY_WONDER_ALTAMIRA_QUOTE',		'[NEWLINE]"After Altamira everything seems decadent."[NEWLINE] - Pablo Picasso[NEWLINE]'),
			('TXT_KEY_WONDER_ALTAMIRA_PEDIA',		'Altamira Cave is approximately 1,000 m (3,280.84 ft) meters long and consists of a series of twisting passages and chambers. The main passage varies from two to six meters in height. The cave was formed through collapses following early karst phenomena in the calcareous rock of Mount Vispieres. Archaeological excavations in the cave floor found rich deposits of artifacts from the Upper Solutrean (c. 18,500 years ago) and Lower Magdalenian (between c. 16,590 and 14,000 years ago). Both periods belong to the Paleolithic or Old Stone Age. In the two millennia between these two occupations, the cave was evidently inhabited only by wild animals. Human occupants of the site were well-positioned to take advantage of the rich wildlife that grazed in the valleys of the surrounding mountains as well as the marine life available in nearby coastal areas. Around 13,000 years ago a rockfall sealed the cave''s entrance, preserving its contents until its eventual discovery, which occurred after a nearby tree fell and disturbed the fallen rocks. Human occupation was limited to the cave mouth, although paintings were created throughout the length of the cave. The artists used charcoal and ochre or hematite to create the images, often diluting these pigments to produce variations in intensity and creating an impression of chiaroscuro. They also exploited the natural contours of the cave walls to give their subjects a three-dimensional effect. The Polychrome Ceiling is the most impressive feature of the cave, depicting a herd of extinct steppe bison (Bison priscus) in different poses, two horses, a large doe, and possibly a wild boar. Dated to the Magdalenian occupation, these paintings include abstract shapes in addition to animal subjects. Solutrean paintings include images of horses and goats, as well as handprints that were created when artists placed their hands on the cave wall and blew pigment over them to leave a negative image. Numerous other caves in northern Spain contain Paleolithic art, but none is as complex or well-populated as Altamira.'),
			('TXT_KEY_WONDER_ALTAMIRA_HELP',		'Contains 1 slot for [ICON_GREAT_WORK] Great Work of Art or Artifact.[NEWLINE][NEWLINE]Nearby [ICON_RES_BISON] Bison: +1 [ICON_FOOD] Food and +1 [ICON_CULTURE] Culture.[NEWLINE]Nearby [ICON_RES_DEER] Deer: +1 [ICON_FOOD] Food and +1 [ICON_CULTURE] Culture.');

UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Altamira Cave[ENDCOLOR] greatly supports early [ICON_CULTURE] Culture generation especially if [ICON_RES_BISON] [COLOR_CYAN]Bisons[ENDCOLOR] or [ICON_RES_DEER] [COLOR_CYAN]Deers[ENDCOLOR] are present in the City. Maximize its effectiveness by filling [ICON_GREAT_WORK] Art slot or by rushing [COLOR_CYAN]Archaeology[ENDCOLOR].'
WHERE Tag = 'TXT_KEY_WONDER_ALTAMIRA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_ALTAMIRA_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_ALTAMIRA_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Mountain[ENDCOLOR]; Resource: [ICON_RES_BISON] [COLOR_CYAN]Bison[ENDCOLOR]/[ICON_RES_DEER] [COLOR_CYAN]Deer[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_ALTAMIRA_HELP';
----------------------------------------------------
-- Ggantija
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_GGANTIJA',			'Ggantija'),
			('TXT_KEY_WONDER_GGANTIJA_QUOTE',		'[NEWLINE]"We need to find God, and he cannot be found in noise and restlessness. God is the friend of silence. See how nature - trees, flowers, grass - grows in silence; see the stars, the moon and the sun, how they move in silence... We need silence to be able to touch souls."[NEWLINE] - Mother Teresa[NEWLINE]'),
			('TXT_KEY_WONDER_GGANTIJA_PEDIA',		'Ggantija (Giants'' Tower) is a megalithic temple complex in Malta on the Mediterranean island of Gozo. Its makers erected the two Ggantija temples during the Neolithic Age (c. 3600-2500 BC), which makes the buildings more than 5500 years old and the world''s second oldest manmade religious structures, after Gobekli Tepe. The temples were possibly the site of a Fertility cult - archeologists believe that the numerous figurines and statues found on site are connected with that cult.'),
			('TXT_KEY_WONDER_GGANTIJA_HELP',		'Grants 50 [ICON_FOOD] Food after construction. Converts 10% [ICON_PEACE] Faith produced by this City into [ICON_FOOD] Food. All Farms in the Empire receive +1 [ICON_FOOD] Food.');

UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Ggantija[ENDCOLOR] instantly boosts [ICON_FOOD] Food generation and upgrades all Farms in the Empire. To increase your City [ICON_FOOD] Growth even more, produce as much [ICON_PEACE] Faith in the City as possible.'
WHERE Tag = 'TXT_KEY_WONDER_GGANTIJA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_GGANTIJA_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_GGANTIJA_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Grassland[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Improvement: [COLOR_CYAN]2 Farms[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_GGANTIJA_HELP';
----------------------------------------------------				
-- Goebekli Tepe	
INSERT INTO Language_en_US 
			(Tag,										Text) 
VALUES		('TXT_KEY_BUILDING_GOEBEKLI_TEPE',			'Goebekli Tepe'),
			('TXT_KEY_WONDER_GOEBEKLI_TEPE_QUOTE',		'[NEWLINE]"Look up at the stars and not down at your feet. Try to make sense of what you see, and wonder about what makes the universe exist. Be curious."[NEWLINE] - Stephen Hawking[NEWLINE]'),
			('TXT_KEY_WONDER_GOEBEKLI_TEPE_PEDIA',		'Göbekli Tepe is a religious site located in southern Turkey, near the Syrian border. It is the oldest known religious building on earth, dating to approximately 10000 BCE, during the Neolithic age of Human civilization, and predating all major civilizations and cities by several millenia. It was first observed during the 1960''s, when archeologists noted that the hill could not be natural due to the shape, yet dismissed it as a Byzantine burial ground. This belief persisted until 1994, and not excavated until a year later. The complex is similar in form to Stonehenge, with a round shape and large Monolithic stones. However, unlike Stonehenge, many of the pillars are carved with the figures of several animals, which are believed to have been sacred to the hunter-gatherers which constructed Göbekli Tepe.'),
			('TXT_KEY_WONDER_GOEBEKLI_TEPE_HELP',		'+1 [ICON_RESEARCH] Science and +1 [ICON_PEACE] Faith from Mountains worked by this City.[NEWLINE][NEWLINE]All [ICON_RES_STONE] Stone: +1 [ICON_RESEARCH] Science.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Goebekli Tepe[ENDCOLOR] is excellent wonder in mountainous terrain, which increase [ICON_RESEARCH] Science, [ICON_CULTURE] Culture and [ICON_PEACE] Faith generation. Make sure to claim each [ICON_RES_STONE] [COLOR_CYAN]Stone[ENDCOLOR] deposit you can find.'
WHERE Tag = 'TXT_KEY_WONDER_GOEBEKLI_TEPE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_GOEBEKLI_TEPE_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_GOEBEKLI_TEPE_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Mountain[ENDCOLOR]; Feature: [COLOR_NEGATIVE_TEXT]Water[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_GOEBEKLI_TEPE_HELP';
----------------------------------------------------				
-- Kuk
INSERT INTO Language_en_US 
			(Tag,							Text) 
VALUES		('TXT_KEY_BUILDING_KUK',		'Kuk'),
			('TXT_KEY_WONDER_KUK_QUOTE',	'[NEWLINE]"If perfection is stagnation, then Heaven is a swamp."[NEWLINE] - Richard Bach[NEWLINE]'),
			('TXT_KEY_WONDER_KUK_PEDIA',	'TODO'),
			('TXT_KEY_WONDER_KUK_HELP',		'10% [ICON_FOOD] Food and 5% [ICON_PRODUCTION] Production is carried over after new [ICON_CITIZEN] Citizen is born. +1 [ICON_PRODUCTION] Production and +1 [ICON_RESEARCH] Science from Marshes worked by this City.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Kuk[ENDCOLOR], thanks to unique agricultural techniques turned [COLOR_CITY_GREEN]Marshes[ENDCOLOR] (+1[ICON_PRODUCTION]; +1[ICON_RESEARCH]) into rich soil. Use its power to increase effectiveness of your huge city (+10%[ICON_FOOD], +5%[ICON_PRODUCTION]/New [ICON_CITIZEN]).'
WHERE Tag = 'TXT_KEY_WONDER_KUK_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_KUK_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_KUK_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_NEGATIVE_TEXT]Tundra[ENDCOLOR], [COLOR_NEGATIVE_TEXT]Snow[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Feature: [COLOR_CYAN]Marsh[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_KUK_HELP';
----------------------------------------------------
-- Majorville Medicine Wheel
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_MAJORVILLE',			'Majorville Medicine Wheel'),
			('TXT_KEY_WONDER_MAJORVILLE_QUOTE',		'[NEWLINE]"When the Earth is sick, the animals will begin to disappear, when that happens, The Warriors of the Rainbow will come to save them."[NEWLINE] - Chief Seattle[NEWLINE]'),
			('TXT_KEY_WONDER_MAJORVILLE_PEDIA',		'The Majorville Medicine Wheel is an archaeological site of the Blackfeet nation dating to 3200 BCE. It is a round stone cairn connected to a cobble circle by 28 stone spokes. Traditionally, in certain Native American cultures, medicine wheels are metaphors for a variety of spiritual concepts. However, as it is believed that the Majorville Medicine Wheel was improved upon for successive generations, the precise meaning of the wheel may differ for each generation. Offerings found at the site included sweet grass, willow, cloth, tobacco, and iniskim stones ("buffalo calling stones").'),
			('TXT_KEY_WONDER_MAJORVILLE_HELP',		'+1 [ICON_PEACE] Faith from Tundra tiles worked by this City. All Camps in the Empire receive +1 [ICON_FOOD] Food.[NEWLINE][NEWLINE]All [ICON_RES_BISON] Bison: +1 [ICON_CULTURE] Culture.');
			
UPDATE Language_en_US
SET Text = 'This [COLOR_YIELD_FOOD]Medicine Wheel[ENDCOLOR] strongly supports developement of Tundra tiles in the City by an early [ICON_PEACE] Faith generation. Additionally build as many Camps as possible to increase [ICON_FOOD] Growth and and claim all [ICON_RES_BISON] [COLOR_CYAN]Bisons[ENDCOLOR] to boost your [ICON_CULTURE] Culture as well.'
WHERE Tag = 'TXT_KEY_WONDER_MAJORVILLE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_MAJORVILLE_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_MAJORVILLE_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Tundra[ENDCOLOR], [COLOR_NEGATIVE_TEXT]Coast[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_MAJORVILLE_HELP';	
----------------------------------------------------
-- Mohenjo-daro
INSERT INTO Language_en_US 
			(Tag,										Text) 
VALUES		('TXT_KEY_BUILDING_MOHENJO_DARO',			'Mohenjo-daro'),
			('TXT_KEY_WONDER_MOHENJO_DARO_QUOTE',		'[NEWLINE]"A river is an ocean in a desert."[NEWLINE] - Matshona Dhliwayo[NEWLINE]'),
			('TXT_KEY_WONDER_MOHENJO_DARO_PEDIA',		'Built sometime around 2500 BC, Mohenjo-daro was one of the largest of the Harappan civilizations settlements, center of a thriving culture that spanned northern India and Pakistan. While the Egyptians were building pyramids for their pharaohs and the Minoans were leaping over bulls for sport, the 40,000 (or so) citizens of Mohenjo-daro were building striking structures of fired and mortared brick: public baths, a central market with a public well, spacious homes, a great granary (with air ducts to dry the grain), the Pillared Hall for assemblies, and the College Hall (78 rooms thought to have been a residence for priests). Mohenjo-daro was the most advanced city of its time, with remarkably sophisticated civil engineering and urban planning. When the Harappan civilization went into a sudden  and as yet unexplained, although historians have lots of theories  decline around 1900 BC, Mohenjo-daro was gradually abandoned, to be lost until 1920 AD. (Adapted from Sid Meier''s Civilization 6)'),
			('TXT_KEY_WONDER_MOHENJO_DARO_HELP',		'Provides a [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] Well in the City in which it is built. +1 [ICON_FOOD] Food from River tiles worked by this City.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Mohenjo-daro[ENDCOLOR] focuses on [ICON_FOOD] Food and [ICON_PRODUCTION] Production in the City in which it is built, increases richness of River tiles and additionally develops your [ICON_CULTURE] Culture and [ICON_PEACE] Faith output.'
WHERE Tag = 'TXT_KEY_WONDER_MOHENJO_DARO_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_MOHENJO_DARO_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_MOHENJO_DARO_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Desert[ENDCOLOR], [COLOR_NEGATIVE_TEXT]Coast[ENDCOLOR]; Feature: [COLOR_CYAN]River[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_MOHENJO_DARO_HELP';	
----------------------------------------------------
-- Skara Brae
INSERT INTO Language_en_US 
			(Tag, Text)
VALUES		('TXT_KEY_BUILDING_SKARA_BRAE',			'Skara Brae'),
			('TXT_KEY_WONDER_SKARA_BRAE_QUOTE',		'[NEWLINE]"No great thing is created suddenly."[NEWLINE] - Epictetus[NEWLINE]'),
			('TXT_KEY_WONDER_SKARA_BRAE_PEDIA',		'Skara Brae is a stone-built Neolithic settlement, located on the Bay of Skaill on the west coast of Mainland, the largest island in the Orkney archipelago of Scotland. It consists of eight clustered houses, and was occupied from roughly 3180 BC - 2500 BC.[NEWLINE][NEWLINE]Given the number of homes, it seems likely that no more than fifty people lived in Skara Brae at any given time. Apart from being makers and users of grooved ware, a distinctive style of pottery that appeared in northern Scotland not long before the establishment of the village, they were primarily pastorialists who raised cattle and sheep.'),
			('TXT_KEY_WONDER_SKARA_BRAE_HELP',		'All Villages in the Empire receive +1 [ICON_PRODUCTION] Production and +1 [ICON_GOLD] Gold.[NEWLINE][NEWLINE]All [ICON_RES_COW] Cattle: +1 [ICON_FOOD] Food.[NEWLINE]All [ICON_RES_FISH] Fish: +1 [ICON_FOOD] Food.[NEWLINE]All [ICON_RES_SHEEP] Sheep: +1 [ICON_FOOD] Food.[NEWLINE]All [ICON_RES_WHEAT] Wheat: +1 [ICON_FOOD] Food.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Skara Brae[ENDCOLOR] gives major [ICON_FOOD] Food boost to all Cities with basic bonus resources. You can also increase [ICON_PRODUCTION] Production and [ICON_GOLD] Gold generation by building numerous Villages across your Empire.'
WHERE Tag = 'TXT_KEY_WONDER_SKARA_BRAE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_SKARA_BRAE_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_SKARA_BRAE_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Plot: [COLOR_CYAN]Flat[ENDCOLOR]; Resource: [ICON_RES_COW] [COLOR_CYAN]Cattle[ENDCOLOR]/[ICON_RES_FISH] [COLOR_CYAN]Fish[ENDCOLOR]/[ICON_RES_SHEEP] [COLOR_CYAN]Sheep[ENDCOLOR]/[ICON_RES_WHEAT] [COLOR_CYAN]Wheat[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_SKARA_BRAE_HELP';	
----------------------------------------------------
----------------------------------------------------
-- Karnak
INSERT INTO Language_en_US 
			(Tag,								Text) 
VALUES		('TXT_KEY_BUILDING_KARNAK',			'Karnak'),
			('TXT_KEY_WONDER_KARNAK_QUOTE',		'[NEWLINE]"I was sitting in the Temple of Karnak of the Nile, as the sun was going down, and I was all alone, and the great Hypostyle Hall was full of shadows and ghosts of the past, (...) and if you believe that, you''ll believe anything."[NEWLINE] - Wilbur A. Smith[NEWLINE]'),
			('TXT_KEY_WONDER_KARNAK_PEDIA',		'Karnak is a large temple complex located in Thebes (nowadays is Luxor). It was constructed during the reign of Ramesses II as a place of worship for many different gods and goddesses, instead of focusing on just one member of the Egyptian Pantheon.[NEWLINE][NEWLINE]  The complex is a vast open-air museum, and the second largest ancient religious site in the world (after the Angkor Wat in Cambodia). It is believed to be the second most visited historical site in Egypt, only the Giza Pyramids near Cairo receive more visits.[NEWLINE][NEWLINE]  One famous aspect of Karnak is the Hypostyle Hall in the Precinct of Amun-Re, a hall area of 50,000 sq ft (5,000 m2) with 134 massive columns arranged in 16 rows. 122 of these columns are 10 meters tall, and the other 12 are 21 meters tall with a diameter of over three meters.'),
			('TXT_KEY_WONDER_KARNAK_HELP',		'Provides a [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] Monument in the City in which it is built and all Monuments in the Empire receive +1 [ICON_CULTURE] Culture. +1 [ICON_PRODUCTION] Production and +1 [ICON_PEACE] Faith from each Oasis and every 2 Flood Plains worked by this City. +4 [ICON_TOURISM] Tourism with [COLOR_CYAN]Archeology[ENDCOLOR].');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Karnak[ENDCOLOR] temples turn rare Oasis and Flood Plains tiles in the City into sacred places and make them more productive. Remember to build a [COLOR_YIELD_FOOD]Monument[ENDCOLOR] in your every City to profit from all its abilities.'
WHERE Tag = 'TXT_KEY_WONDER_KARNAK_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_KARNAK_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_KARNAK_HELP';
				
UPDATE Language_en_US SET Text = 'Plot: [COLOR_CYAN]Flat[ENDCOLOR]; Feature: [COLOR_CYAN]Flood Plains[ENDCOLOR]/[COLOR_CYAN]Oasis[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_KARNAK_HELP';	
----------------------------------------------------
-- Nazca Lines
INSERT INTO Language_en_US 
			(Tag,								Text) 
VALUES		('TXT_KEY_BUILDING_NAZCA',			'Nazca Lines'),
			('TXT_KEY_WONDER_NAZCA_QUOTE',		'[NEWLINE]"The true mystery of the world is the visible, not the invisible."[NEWLINE] - Oscar Wilde[NEWLINE]'),
			('TXT_KEY_WONDER_NAZCA_PEDIA',		'The Nazca Lines, located between the Peruvian towns of Nazca and Palpa, are a series of enormous Geoglyphs designed on a large plateau, spanning over 80 kilometres. The designs have long been a source of mystery for those who have gazed upon them. It is estimated that the lines were constructed by the Nazca culture, hense the name, between 450 and 600 CE. The level of complexity of design varies between designs. Some are simple lines hundreds of metres long, while others are incredibly complex patterns resembling a variety of zoological designs - Monkeys, Condors, Spiders and Orca (Killer whale) to name but a few.[NEWLINE][NEWLINE]  The Nazca Lines are particularily popular amongst circles which believe in the existance of extra-terrestrial life, which the Nazca culture mistook for their gods. They believe that the simpler, straight lines are in fact landing strips for interstellar crafts used by the extra-terrestrials to land, and that a humanoid figure represented in the patterns is one of the extraterrestrials. Modern science has had a range of theories, amongst which the lines serving a purpose similar to that of Stonehenge as an early form of an observatory / astronomical calendar. Other theories were that the geometric lines could indicate the flow of water, irrigation schemes, or be a part of rituals to "summon" water. However, to this day the exact purpose of the lines remains a mystery.'),
			('TXT_KEY_WONDER_NAZCA_HELP',		'+2 [ICON_FOOD] Food from nearby Plains, +1 [ICON_PEACE] Faith from nearby Hills and +1 [ICON_RESEARCH] Science from Camps worked by this City. +4 [ICON_RESEARCH] Science and +2 [ICON_TOURISM] Tourism with [COLOR_CYAN]Flight[ENDCOLOR].');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Nazca Lines[ENDCOLOR] hide awesome scientific secrets fully discovered only after researching [COLOR_CYAN]Flight[ENDCOLOR]. Boost your [ICON_FOOD] Growth and [ICON_PEACE] Faith by claiming all Plains and Hills in the City.'
WHERE Tag = 'TXT_KEY_WONDER_NAZCA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_NAZCA_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_NAZCA_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Plains[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Improvement: [COLOR_CYAN]Camp[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_NAZCA_HELP';	
----------------------------------------------------
-- Wieliczka
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_WIELICZKA',			'Wieliczka Salt Mine'),
			('TXT_KEY_WONDER_WIELICZKA_QUOTE',		'[NEWLINE]"You are the salt of the earth. But remember that salt is useful when in association, but useless in isolation."[NEWLINE] - Israelmore Ayivor[NEWLINE]'),
			('TXT_KEY_WONDER_WIELICZKA_PEDIA',		'The Wieliczka Salt Mine, in the town of Wieliczka, southern Poland, lies within the Kraków metropolitan area. Sodium chloride (table salt) was formerly produced there from the upwelling brine - and had been since Neolithic times. The Wieliczka salt mine, excavated from the 13th century, produced table salt continuously until 2007, as one of the world''s oldest operating salt mines.'),
			('TXT_KEY_WONDER_WIELICZKA_HELP',		'Wonder places 2 new [ICON_RES_SALT] Salt resources inside City range if possible. +5% [ICON_FOOD] Food in all Cities. +1 [ICON_FOOD] Food from Mines worked by this City.[NEWLINE][NEWLINE]Nearby [ICON_RES_SALT] Salt: +1 [ICON_PRODUCTION] Production and +1 [ICON_GOLD] Gold.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Wieliczka[ENDCOLOR] reveals hidden underground secret and greatly boosts your [ICON_FOOD] Food generation, supported by more productive and richer newly discovered [ICON_RES_SALT] [COLOR_CYAN]Salt[ENDCOLOR] deposits.'
WHERE Tag = 'TXT_KEY_WONDER_WIELICZKA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_WIELICZKA_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_WIELICZKA_HELP';
				
UPDATE Language_en_US SET Text = 'Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Improvement: [COLOR_CYAN]2 Mines[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_WIELICZKA_HELP';	
----------------------------------------------------
-- Stonehenge
UPDATE Language_en_US
SET Text = 'Mysterious [COLOR_YIELD_FOOD]Stonehenge[ENDCOLOR] serves as an improved [COLOR_YIELD_FOOD]Council[ENDCOLOR] and provides instant [ICON_PEACE] Faith boost, almost guaranteeing founding new Religion and improving your early [ICON_RESEARCH] Science output.'
WHERE Tag = 'TXT_KEY_BUILDING_STONEHENGE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,									Text) 
SELECT		'TXT_KEY_BUILDING_STONEHENGE_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_BUILDING_STONEHENGE_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Grassland[ENDCOLOR], [COLOR_NEGATIVE_TEXT]Coast[ENDCOLOR]; Plot: [COLOR_CYAN]Flat[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_BUILDING_STONEHENGE_HELP';
----------------------------------------------------
-- Pyramids
UPDATE Language_en_US
SET Text = 'Great [COLOR_YIELD_FOOD]Pyramids[ENDCOLOR] are an engineering masterpiece, accelerating the coming of next [ICON_GOLDEN_AGE] Golden Age thanks to the efforts of expended [ICON_GREAT_PEOPLE] Great People. Use recently trained [COLOR_POSITIVE_TEXT]Settler[ENDCOLOR] to found another great and prosperous City.'
WHERE Tag = 'TXT_KEY_WONDER_CHICHEN_ITZA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,									Text) 
SELECT		'TXT_KEY_WONDER_CHICHEN_ITZA_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_CHICHEN_ITZA_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_NEGATIVE_TEXT]Tundra[ENDCOLOR], [COLOR_NEGATIVE_TEXT]Snow[ENDCOLOR]; Plot: [COLOR_CYAN]Flat[ENDCOLOR]; Feature: [COLOR_CYAN]River[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_CHICHEN_ITZA_HELP';
----------------------------------------------------
-- Petra
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Petra[ENDCOLOR] complex uses surrounding [COLOR_CITY_BLUE]Desert[ENDCOLOR] (+1[ICON_GOLD]) to increase your income. Send new [COLOR_YIELD_GOLD]Caravan[ENDCOLOR] along available trade routes (+1[ICON_INTERNATIONAL_TRADE]) to quickly spread your culture over the world.'
WHERE Tag = 'TXT_KEY_WONDER_PETRA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

UPDATE Language_en_US SET Text = REPLACE(Text, 'City must be built on or next to Desert. ', '') WHERE Tag ='TXT_KEY_WONDER_PETRA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 0);
		
INSERT INTO Language_en_US 
			(Tag,								Text) 
SELECT		'TXT_KEY_WONDER_PETRA_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_PETRA_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Desert[ENDCOLOR], [COLOR_CYAN]Mountain (near)[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_PETRA_HELP';

----------------------------------------------------
-- Temple of Artemis
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Temple of Artemis[ENDCOLOR] supports global [ICON_FOOD] Growth, increase usefulness of Forests and supports hiring Specialists in the City. As and addition, this City can spam Archery Units to conquer even more valuable lands.'
WHERE Tag = 'TXT_KEY_WONDER_TEMPLE_ARTEMIS_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_TEMPLE_ARTEMIS_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_TEMPLE_ARTEMIS_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_NEGATIVE_TEXT]Desert[ENDCOLOR]; Feature: [COLOR_CYAN]Fresh Water[ENDCOLOR]; Improvement: [COLOR_CYAN]Camp[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_TEMPLE_ARTEMIS_HELP';
----------------------------------------------------
-- Mausoleum of Halicarnassus
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Mausoleum of Halicarnassus[ENDCOLOR] starts [ICON_HAPPINESS_1] WLTKD and boosts basic yields during this festival. Greatly boosts [ICON_PRODUCTION] Production and [ICON_GOLD] Gold generation from local [COLOR_SELECTED_TEXT]Quarries[ENDCOLOR].'
WHERE Tag = 'TXT_KEY_WONDER_MAUSOLEUM_HALICARNASSUS_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,												Text) 
SELECT		'TXT_KEY_WONDER_MAUSOLEUM_HALICARNASSUS_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_MAUSOLEUM_HALICARNASSUS_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Improvement: [COLOR_CYAN]Quarry[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_MAUSOLEUM_HALICARNASSUS_HELP';
----------------------------------------------------
-- Statue of Zeus
UPDATE Language_en_US
SET Text = 'Monumental [COLOR_YIELD_FOOD]Statue of Zeus[ENDCOLOR] increases your offensive capabilities, especially during City sieges and triples your efforts towards reducing [ICON_FOOD]/[ICON_PRODUCTION] Distress in the City.'
WHERE Tag = 'TXT_KEY_WONDER_STATUE_ZEUS_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,									Text) 
SELECT		'TXT_KEY_WONDER_STATUE_ZEUS_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_STATUE_ZEUS_HELP';
				
UPDATE Language_en_US SET Text = 'Resource: [ICON_RES_MARBLE] [COLOR_CYAN]Marble[ENDCOLOR]/[ICON_RES_STONE] [COLOR_CYAN]Stone[ENDCOLOR]; Other Player: [COLOR_CYAN]Guarded[ENDCOLOR]/[COLOR_CYAN]Afraid[ENDCOLOR]/[COLOR_CYAN]Hostile[ENDCOLOR]/[COLOR_CYAN]Warring[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_STATUE_ZEUS_HELP';
----------------------------------------------------
----------------------------------------------------
-- Malwiya Minaret
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_MALWIYA',			'Malwiya Minaret'),
			('TXT_KEY_WONDER_MALWIYA_QUOTE',		'[NEWLINE]"Aim at heaven and you will get Earth... Aim at Earth and you will get neither."[NEWLINE] - C.S. Lewis[NEWLINE]'),
			('TXT_KEY_WONDER_MALWIYA_PEDIA',		'The Malwiya Minaret (also known as the Spiral Minaret) is part of the Great Mosque of Samarra, located in Samarra, Iraq. The complex was built over a period of four years, from 848 to 852 CE. The main mosque was completed one year before the Minaret. The complex was constructed during the reign of Al-Mutawakkil, an Abbasid Caliph. For a time it was the largest mosque in the world.[NEWLINE][NEWLINE]  The minaret (tower) was constructed of sandstone, and is unique among other minarets because of its ascending spiral conical design. 52 metres high and 33 metres wide at the base, the spiral contains stairs reaching to the top. The word "malwiya" translates as "twisted" or "snail shell".[NEWLINE][NEWLINE]  With the turbulence of the Iraq war, the Malwiya Minaret has been damaged by bomb blasts, one in 2005 and one in 2011, when it was attacked by Iraqi insurgents.'),
			('TXT_KEY_WONDER_MALWIYA_HELP',			'All Stone Works in the Empire receive +2 [ICON_PRODUCTION] Production, all Quarries +1 [ICON_PRODUCTION] Production and +1 [ICON_PEACE] Faith and all Manufactories +3 [ICON_PEACE] Faith.');
				
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Malwiya Minaret[ENDCOLOR] is a result of engineering genious (+2[ICON_GREAT_ENGINEER]), that improved all [COLOR_SELECTED_TEXT]Quarried[ENDCOLOR] materials (+1[ICON_PRODUCTION][ICON_PRODUCTION], +1[ICON_PEACE][ICON_PEACE]). Make sure to link your resources, construct many [COLOR_SELECTED_TEXT]Manufactories[ENDCOLOR] (+3[ICON_PEACE][ICON_PEACE]) and rush [COLOR_YIELD_FOOD]Stone Works[ENDCOLOR] (+2[ICON_PRODUCTION][ICON_PRODUCTION]) in all your cities to support this wonderful project.'
WHERE Tag = 'TXT_KEY_WONDER_MALWIYA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_MALWIYA_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_MALWIYA_HELP';
				
UPDATE Language_en_US SET Text = 'Plot: [COLOR_CYAN]Flat[ENDCOLOR]; Building: [COLOR_CYAN]Stone Works[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_MALWIYA_HELP';	
----------------------------------------------------
-- Buddhas of Bamyan
INSERT INTO Language_en_US 
			(Tag,								Text)
VALUES		('TXT_KEY_BUILDING_BAMYAN',			'Buddhas of Bamyan'),
			('TXT_KEY_WONDER_BAMYAN_QUOTE',		'[NEWLINE]"The past is already gone, the future is not yet here. There''s only one moment for you to live."[NEWLINE] - Buddha[NEWLINE]'),
			('TXT_KEY_WONDER_BAMYAN_PEDIA',		'Deep in the Hindu Kush, in the Bamyan Valley, along the Silk Road, the Buddhas of Bamyan once towered over the region. Bamyan was a religious site from the 2nd century until the later half of the 7th century, and the Buddhas were constructed throughout that time. The Chinese Buddhist pilgrim Xuanzang visited in 630 CE, describing Bamyan as a flourishing Buddhist center "with more than ten monstaries and more than a thousand monks". In 2001, the Buddhas were destroyed by the Taliban, either in protest of international aid priorities or as part of Islamic religious iconoclasm, to both international and domestic condemnation. Since then, international efforts have been made to reconstruct the Buddhas. Furthermore, after the destruction of the Buddhas, caves containing art from the 5th through 9th centuries were discovered, as well as Xuanzang''s translation of the Pratityasamutpada Sutra that spelled out the basic belief of Buddhism: all things are transient.While the original Buddhas of Bamyan may be gone, their message and cultural significance will echo for all eternity.'),
			('TXT_KEY_WONDER_BAMYAN_HELP',		'City generates +100% Religious Pressure. +2 [ICON_PEACE] per City-State Friend and +3 [ICON_GOLDEN_AGE] per City-State Ally. +1 [ICON_INFLUENCE] World Congress Vote for each 2 Declarations of Friendship.');
			
UPDATE Language_en_US
SET Text = 'Gigantic [COLOR_YIELD_FOOD]Buddhas[ENDCOLOR] should be sign of your generosity passed to all nations in the world (+100%[ICON_RELIGION] Pressure). Make sure to keep peace around you and gather many friends and allies (+2[ICON_PEACE]/CS Friend; +3[ICON_GOLDEN_AGE]/CS Ally), even in distant future when world will be led by superpowers (+1[ICON_INFLUENCE] League Vote/2 DoF).'
WHERE Tag = 'TXT_KEY_WONDER_BAMYAN_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_BAMYAN_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_BAMYAN_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]2 Mountains[ENDCOLOR]; Player: [COLOR_CYAN]at Peace[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_BAMYAN_HELP';	
----------------------------------------------------
-- Gate of the Sun
INSERT INTO Language_en_US 
			(Tag,										Text) 
VALUES		('TXT_KEY_BUILDING_GATE_OF_SUN',			'Gate of the Sun'),
			('TXT_KEY_WONDER_GATE_OF_SUN_QUOTE',		'[NEWLINE]"May the sun set on where my love dwells."[NEWLINE] - Bolivian proverb[NEWLINE]'),
			('TXT_KEY_WONDER_GATE_OF_SUN_PEDIA',		'The Gate of the Sun is a stone arch constructed by the ancient Tiwanaku culture of Bolivia, dated to between 500-950 CE. The lintel is carved with 48 squars surrounding a central figure. The central figure is a man with his head surrounded by 24 rays. Some believe that the Gate of the Sun possesses an astronomical or astrological significance, or may have served as a calendar. No one knows for sure.'),
			('TXT_KEY_WONDER_GATE_OF_SUN_HELP',			'All Walls in the Empire receive +1 [ICON_RESEARCH] Science. +1 [ICON_CULTURE] Culture from Mountains and Lakes worked by this City. Has 1 slot for [ICON_GREAT_WORK] Great Work of Art. +5% [ICON_RESEARCH] Science produced by this City during [ICON_GOLDEN_AGE] Golden Age and +5% [ICON_RESEARCH] Science in Cities with Walls.');
			
UPDATE Language_en_US
SET Text = 'Mysterious [COLOR_YIELD_FOOD]Gate of the Sun[ENDCOLOR] hides unremarkable inscriptions (+1[ICON_GREAT_WORK]). Revealing their secrets can help your [COLOR_CITY_BLUE]Mountains[ENDCOLOR] and [COLOR_CITY_GREEN]Lakes[ENDCOLOR] (+1[ICON_CULTURE]) become more influential and will be key factor in your developement (+5%[ICON_RESEARCH]/[ICON_GOLDEN_AGE]). Remember to pass the knowledge by building [COLOR_YIELD_FOOD]Walls[ENDCOLOR] (+1[ICON_RESEARCH]; +5%[ICON_RESEARCH]/Cities with Walls) in all your cities.'
WHERE Tag = 'TXT_KEY_WONDER_GATE_OF_SUN_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_GATE_OF_SUN_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_GATE_OF_SUN_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Mountain[ENDCOLOR]; Feature: [COLOR_CYAN]Lake[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_GATE_OF_SUN_HELP';	
----------------------------------------------------
-- El Ghriba Synagogue
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_EL_GHRIBA',			'El Ghriba Synagogue'),
			('TXT_KEY_WONDER_EL_GHRIBA_QUOTE',		'[NEWLINE]"Jesus was born a Jew, and he died a Jew. It never occurred to him to establish a new religion. He never crossed himself: he had no reason to. He never set one foot in a church. He went to synagogue."[NEWLINE] - Amos Oz[NEWLINE]'),
			('TXT_KEY_WONDER_EL_GHRIBA_PEDIA',		'El Ghriba Synagogue, located on the Tunisian island of Djerba, is the oldest synagogue in Tunisa and the center of the village''s holy life. According to legend, it was constructed with a door and a stone from the destruction of either Solomon''s Temple in 586 BCE or the Second Temple in 70 CE. Thus, it links the local Jewish community to the ancestral heart of Judaism and remains a pilgrimage site into the modern day.'),
			('TXT_KEY_GREAT_WORK_THE_ARK',			'Ark of the Covenant'),
			('TXT_KEY_GREAT_WORK_THE_ARK_QUOTE',	'[NEWLINE]"I had it in my heart to build a house of rest [NEWLINE]for the ark of the covenant of the Lord, [NEWLINE]and for the footstool of our God."[NEWLINE] - 1 Chronicles, 28:2[NEWLINE]'),
			('TXT_KEY_WONDER_EL_GHRIBA_HELP',		'Provides a [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] Synagogue in the City in which it is built. Receive 50 [ICON_GOLD] Gold from each [ICON_PEACE] Faith Purchase. Has 1 slot for [ICON_GREAT_WORK] Great Work of Art, and starts with [ICON_GREAT_WORK] [COLOR_MAGENTA]Ark of the Covenant[ENDCOLOR].');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]El Ghriba[ENDCOLOR] is a [COLOR_YIELD_FOOD]Synagogue[ENDCOLOR] ([ICON_PRODUCTION]; [ICON_PEACE]; [ICON_HAPPINESS_3]; [ICON_GREAT_WORK]; [ICON_RESEARCH]) containing artifacts like [COLOR_MAGENTA]Ark of the Covenant[ENDCOLOR] (+1[ICON_GREAT_WORK]), which is foundation stone of Jewish history. It can also successfully make all religious expenses profit some gold in return (50[ICON_GOLD]/[ICON_PEACE][ICON_PEACE] Purchase).'
WHERE Tag = 'TXT_KEY_WONDER_EL_GHRIBA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_EL_GHRIBA_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_EL_GHRIBA_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_YIELD_PRODUCTION]Holy City[ENDCOLOR]; Terrain: [COLOR_NEGATIVE_TEXT]Tundra[ENDCOLOR], [COLOR_NEGATIVE_TEXT]Snow[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_EL_GHRIBA_HELP';		
----------------------------------------------------
-- Etchmiadzin Cathedral
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_ETCHMIADZIN',		'Etchmiadzin Cathedral'),
			('TXT_KEY_WONDER_ETCHMIADZIN_QUOTE',	'[NEWLINE]"The wound of a dagger heals, but that of the tongue, never."[NEWLINE] - Armenian proverb[NEWLINE]'),
			('TXT_KEY_WONDER_ETCHMIADZIN_PEDIA',	'Located in Vagharshapat, Armenia, Etchmiadzin Cathedral is often considered the oldest cathedral in the world. Following the adoption of Christianity as the Armenian state religion by King Tiridates III, tt was built between 301 and 303 CE by Saint Gregory the Illuminator over a pagan temple. Until the second half of the fifth century, Etchmiadzin was the seat of the supreme head of the Armenian Church.[NEWLINE]Etchmiadzin was the national and political center of the Armenian people for centuries, and is considered to be holy ground. It is crucial to the Armenian identity, and remains a popular pilgrimage site today. While Shah Abbas I of Persia plundered the cathedral in an attempt to diminish Armenian cultural identity, and the cathedral''s importance was diminished under the Soviet Union, it endured. In 2000, it was added to the list of UNESCO World Heritage Sites. Notably, the cathedral claims to house several relics, such as the Lance of Longingus, relics of the Twelve Apostles, and a fragment of Noah''s Ark.'),
			('TXT_KEY_GREAT_WORK_HOLY_LANCE',		'Holy Lance'),
			('TXT_KEY_GREAT_WORK_HOLY_LANCE_QUOTE',	'[NEWLINE]One of the soldiers pierced his side [NEWLINE]with a lance, and immediately [NEWLINE]there came out blood and water.[NEWLINE] - John, 19:34[NEWLINE]'),
			('TXT_KEY_WONDER_ETCHMIADZIN_HELP',		'Converts 10% of [ICON_PEACE] Faith produced by this City into [ICON_CULTURE] Culture and another 10% into [ICON_GOLDEN_AGE] Golden Age Points. Has 1 slot for [ICON_GREAT_WORK] Great Work of Art, and starts with [ICON_GREAT_WORK] [COLOR_MAGENTA]Holy Lance[ENDCOLOR]. All [ICON_GREAT_WORK] Great Works in the Empire receive +1 [ICON_PEACE] Faith.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Etchmiadzin Cathedral[ENDCOLOR] stores wonderful great works like [COLOR_MAGENTA]Holy Lance[ENDCOLOR] (+1[ICON_GREAT_WORK]; +1[ICON_PEACE]/[ICON_GREAT_WORK][ICON_GREAT_WORK]). Thanks to the support of high up nobles, it turns speeds up coming of next golden era and increase your culture output (10%[ICON_PEACE] into [ICON_CULTURE], [ICON_GOLDEN_AGE]).'
WHERE Tag = 'TXT_KEY_WONDER_ETCHMIADZIN_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_ETCHMIADZIN_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_ETCHMIADZIN_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Grassland[ENDCOLOR], [COLOR_NEGATIVE_TEXT]Coast[ENDCOLOR]; Feature: [COLOR_CYAN]Forest[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_ETCHMIADZIN_HELP';		
----------------------------------------------------
-- Chand Baori
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_CHAND_BAORI',		'Chand Baori'),
			('TXT_KEY_WONDER_CHAND_BAORI_QUOTE',	'[NEWLINE]"When the well''s dry, we know the worth of water."[NEWLINE] - Benjamin Franklin[NEWLINE]'),
			('TXT_KEY_WONDER_CHAND_BAORI_PEDIA',	'Built over a thousand years ago, Chand Baori is a stepwell located in the Abhaneri village of Rajasthan, India. Stepwells are unique to the Indian subcontinent, and are wells with steps leading down to the water. They were one of many developments to deal with the seasonal availability of water. [NEWLINE]Chand Baori is quite possibly the largest of the stepwells, and may be the most visually spectacular. It is a four-sided structure, with a temple to Harshat Mata, goddess of joy, at one face. In the modern era, Chand Baori has been included in several Bollywood films, though stepwells have fallen out of favor with the arrival of running water.'),
			('TXT_KEY_WONDER_CHAND_BAORI_HELP',		'Receive 1 [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] [ICON_GREAT_PEOPLE] Great Person of your choice. +10% generation of [ICON_GREAT_PEOPLE] Great People in this City. +1 [ICON_FOOD] Food from Desert tiles in this City. 3 Specialists in the City no longer generates [ICON_HAPPINESS_3] Unhappiness from Urbanization.');

UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Chand Baori[ENDCOLOR] guarantees, that your local [COLOR_CITY_BLUE]Desert[ENDCOLOR] (+1[ICON_FOOD]) will not be useless for your city. It is also place, where new specialists settle their offices (-3[ICON_HAPPINESS_3] Urbanization) and very important and profitable deals between nobles are agreed ([COLOR_YIELD_GOLD]Great Person[ENDCOLOR]; +10%[ICON_GREAT_PEOPLE]).'
WHERE Tag = 'TXT_KEY_WONDER_CHAND_BAORI_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_CHAND_BAORI_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_CHAND_BAORI_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Desert[ENDCOLOR]; Feature: [COLOR_NEGATIVE_TEXT]Fresh Water[ENDCOLOR]; Building: [COLOR_CYAN]Well[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_CHAND_BAORI_HELP';		
----------------------------------------------------
-- Great Lighthouse
UPDATE Language_en_US
SET Text = 'Nothing can help sailors to achieve their destination more than [COLOR_YIELD_FOOD]Lighthouse[ENDCOLOR] ([ICON_FOOD]; [ICON_GOLD]; [ICON_CONNECTED]). [COLOR_YIELD_FOOD]Great Lighthouse[ENDCOLOR] additionally strengthens vision and movement of all your military naval units ([COLOR_WATER_TEXT]Great Lighthouse[ENDCOLOR]).'
WHERE Tag = 'TXT_KEY_WONDER_GREAT_LIGHTHOUSE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

UPDATE Language_en_US SET Text = REPLACE(Text, 'City must be built on the coast. ', '') WHERE Tag ='TXT_KEY_WONDER_GREAT_LIGHTHOUSE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 0);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_GREAT_LIGHTHOUSE_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_GREAT_LIGHTHOUSE_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Feature: [COLOR_CYAN]River[ENDCOLOR]; Resource: [ICON_RES_STONE] [COLOR_CYAN]Stone[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_GREAT_LIGHTHOUSE_HELP';
----------------------------------------------------
-- Great Library
UPDATE Language_en_US
SET Text = 'Enormous collection of books from [COLOR_YIELD_FOOD]Great Library[ENDCOLOR], like all other [COLOR_YIELD_FOOD]Libraries[ENDCOLOR] ([ICON_RESEARCH]; [ICON_HAPPINESS_3]) provides massive scientific boost (+1[ICON_GREAT_SCIENTIST]), instant technological progress ([ICON_RESEARCH] [COLOR_CYAN]Technology[ENDCOLOR]) and additional slots for literature granting even more science if themed (+2[ICON_GREAT_WORK]: [ICON_RESEARCH]).'
WHERE Tag = 'TXT_KEY_WONDER_GREAT_LIBRARY_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_GREAT_LIBRARY_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_GREAT_LIBRARY_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Feature: [COLOR_CYAN]Forest[ENDCOLOR]/[COLOR_CYAN]Jungle[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_GREAT_LIBRARY_HELP';
----------------------------------------------------
-- Forum Romanum
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Forum Romanum[ENDCOLOR] uses variety of abilities to make you the most influential ruler in the world. Beside receiving support of experts ([COLOR_YIELD_GOLD]Great Diplomat[ENDCOLOR]; +1[ICON_DIPLOMAT]), you have increased production of diplomatic units (+20%[ICON_PRODUCTION]), new [COLOR_CYAN]Paper[ENDCOLOR] source available (+1[ICON_RES_PAPER]) and increased pitch in any diplomatic actions ([COLOR_WATER_TEXT]Imperial Seal[ENDCOLOR]).'
WHERE Tag = 'TXT_KEY_BUILDING_FORUM_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,								Text) 
SELECT		'TXT_KEY_BUILDING_FORUM_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_BUILDING_FORUM_HELP';
				
UPDATE Language_en_US SET Text = 'Feature: [COLOR_CYAN]River[ENDCOLOR], [COLOR_CYAN]Marsh[ENDCOLOR]; Policy: [COLOR_MAGENTA]-1[ENDCOLOR][NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_BUILDING_FORUM_HELP';
----------------------------------------------------
-- Hanging Gardens
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Hanging Gardens[ENDCOLOR] are are much bigger and spectacular version of standard [COLOR_YIELD_FOOD]Garden[ENDCOLOR] ([ICON_GREAT_PEOPLE]; [ICON_GOLD]; [ICON_FOOD]; [ICON_HAPPINESS_3]), which provides massive amount of food (+10[ICON_FOOD]). Boost your population growth using its perks.'
WHERE Tag = 'TXT_KEY_WONDER_HANGING_GARDEN_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_HANGING_GARDEN_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_HANGING_GARDEN_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_NEGATIVE_TEXT]Coast[ENDCOLOR]; Plot: [COLOR_CYAN]Flat[ENDCOLOR]; Feature: [COLOR_CYAN]Fresh Water[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_HANGING_GARDEN_HELP';
----------------------------------------------------
-- Terracota Army
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Terracota Army[ENDCOLOR] allows for creation incredible army (+5[ICON_SILVER_FIST]) and increases improvement construction speed (+25%[ICON_WORKER]) to create well-developed cities. Make sure to kill all your enemies (10[ICON_CULTURE]/Kill)!.'
WHERE Tag = 'TXT_KEY_WONDER_TERRA_COTTA_ARMY_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_TERRA_COTTA_ARMY_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_TERRA_COTTA_ARMY_HELP';
				
UPDATE Language_en_US SET Text = 'Feature: [COLOR_NEGATIVE_TEXT]Water[ENDCOLOR]; Improvement: [COLOR_CYAN]Mine[ENDCOLOR]/[COLOR_CYAN]Quarry[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_TERRA_COTTA_ARMY_HELP';
----------------------------------------------------
-- Parthenon
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Parthenon[ENDCOLOR] focuses not only on artistry (+2[ICON_GREAT_WORK]: [ICON_CULTURE]; [COLOR_MAGENTA]Phidias Showing the Frieze of the Parthenon to his Friends[ENDCOLOR]) entartaining your citizens (-1[ICON_HAPPINESS_3] Boredom), but also supports your army (+10%[ICON_SILVER_FIST]). Additionally it turns [COLOR_YIELD_FOOD]Amphitheaters[ENDCOLOR] (+1[ICON_RESEARCH][ICON_RESEARCH]; +1[ICON_CULTURE][ICON_CULTURE]) into scientific and cultural centers.'
WHERE Tag = 'TXT_KEY_WONDER_PARTHENON_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

UPDATE Language_en_US SET Text = REPLACE(Text, 'Contains a prebuilt [ICON_GREAT_WORK] Great Work of Art in one of the [ICON_GREAT_WORK] Great Work slots.', 'Starts with [ICON_GREAT_WORK] [COLOR_MAGENTA]Phidias Showing the Frieze of the Parthenon to his Friends[ENDCOLOR].') WHERE Tag ='TXT_KEY_WONDER_PARTHENON_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 0);

INSERT INTO Language_en_US 
			(Tag,									Text) 
SELECT		'TXT_KEY_WONDER_PARTHENON_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_PARTHENON_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_NEGATIVE_TEXT]Grassland[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Feature: [COLOR_NEGATIVE_TEXT]Fresh Water[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_PARTHENON_HELP';
----------------------------------------------------
-- Oracle
UPDATE Language_en_US
SET Text = 'Mysterious [COLOR_YIELD_FOOD]Oracle[ENDCOLOR], unlike other [COLOR_YIELD_FOOD]Temples[ENDCOLOR] ([ICON_PEACE]; [ICON_CULTURE]; [ICON_GOLD]; [ICON_GREAT_WORK]; [ICON_HAPPINESS_3]), makes all your scientific projects possible (+1[ICON_GREAT_SCIENTIST]). It gives you massive instant yield injection (500[ICON_RESEARCH]; 500[ICON_CULTURE]) and makes your citizens more qualified (-1[ICON_HAPPINESS_3] Illiteracy).'
WHERE Tag = 'TXT_KEY_WONDER_ORACLE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,								Text) 
SELECT		'TXT_KEY_WONDER_ORACLE_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_ORACLE_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Mountain[ENDCOLOR], [COLOR_NEGATIVE_TEXT]Grassland[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_ORACLE_HELP';
----------------------------------------------------
-- Angkor Wat
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Angkor Wat[ENDCOLOR] boosts your empire''s expansion (-25%[ICON_CULTURE][ICON_CULTURE] Border Growth; -25%[ICON_GOLD][ICON_GOLD] Plot Cost) and, unlike other [COLOR_YIELD_FOOD]Mandirs[ENDCOLOR] ([ICON_FOOD]; [ICON_PEACE]; [ICON_HAPPINESS_3]; [ICON_GREAT_WORK]; [ICON_SPY]), supports your engineering projects (+1[ICON_GREAT_ENGINEER]).'
WHERE Tag = 'TXT_KEY_WONDER_ANGKOR_WAT_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,									Text) 
SELECT		'TXT_KEY_WONDER_ANGKOR_WAT_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_ANGKOR_WAT_HELP';
				
UPDATE Language_en_US SET Text = 'Plot: [COLOR_CYAN]Flat[ENDCOLOR]; Feature: [COLOR_CYAN]Lake[ENDCOLOR], [COLOR_CYAN]Jungle[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_ANGKOR_WAT_HELP';
----------------------------------------------------
-- Great Wall
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Great Wall[ENDCOLOR] is unbelievably successful defensive project, modifying your [COLOR_YIELD_FOOD]Walls[ENDCOLOR] ([ICON_STRENGTH]; [ICON_SILVER_FIST]; [ICON_RANGED_STRIKE]; [ICON_HAPPINESS_3]) into monstrual barrier (-All [ICON_MOVES] if Enemy cross your borders). It allows your soldiers, led by experienced [COLOR_YIELD_GOLD] Great General[ENDCOLOR], to compete with greatest armies in the world (+3[ICON_SILVER_FIST]).'
WHERE Tag = 'TXT_KEY_WONDER_GREAT_WALL_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,									Text) 
SELECT		'TXT_KEY_WONDER_GREAT_WALL_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_GREAT_WALL_HELP';
				
UPDATE Language_en_US SET Text = 'Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Feature: [COLOR_CYAN]River[ENDCOLOR]; Other Player: [COLOR_CYAN]Deceptive[ENDCOLOR]/[COLOR_CYAN]Hostile[ENDCOLOR]/[COLOR_CYAN]Warring[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_GREAT_WALL_HELP';
----------------------------------------------------
-- Colossus
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Colossus[ENDCOLOR] will make from you the greatest merchant of all seas (+1[ICON_INTERNATIONAL_TRADE]; [COLOR_YIELD_GOLD]Cargo Ship[ENDCOLOR]). You can only watch how your gold income in the city is growing more and more thanks to the recently established trade routes (+2[ICON_GOLD]/[ICON_INTERNATIONAL_TRADE]).'
WHERE Tag = 'TXT_KEY_WONDER_COLOSSUS_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

UPDATE Language_en_US SET Text = REPLACE(Text, 'City must be built on the coast. ', '') WHERE Tag ='TXT_KEY_WONDER_COLOSSUS_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 0);

INSERT INTO Language_en_US 
			(Tag,								Text) 
SELECT		'TXT_KEY_WONDER_COLOSSUS_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_COLOSSUS_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Resource: [ICON_RES_IRON] [COLOR_CYAN]Iron[ENDCOLOR]/[ICON_RES_COPPER] [COLOR_CYAN]Copper[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_COLOSSUS_HELP';
----------------------------------------------------
----------------------------------------------------
-- Prophet's Mosque
INSERT INTO Language_en_US 
			(Tag,									Text)
VALUES		('TXT_KEY_BUILDING_NABAWI',				'Prophet''s Mosque'),
			('TXT_KEY_WONDER_NABAWI_QUOTE',			'[NEWLINE]"When you see a person who has been given more than you in money and beauty, look to those, who have been given less."[NEWLINE] - Prophet Muhammad[NEWLINE]'),
			('TXT_KEY_WONDER_NABAWI_PEDIA',			'Al-Masjid al-Nabawi, often called the Prophet''s Mosque, is a mosque situated in the city of Medina. As the final resting place of the Islamic prophet Muhammad, it is considered the second holiest site in Islam by Muslims (the first being the Masjid al-Haram in Mecca) and is one of the largest mosques in the World. The mosque is under the control of the Custodian of the Two Holy Mosques. It is the second mosque built in history.[NEWLINE][NEWLINE]  One of the most notable features of the site is the Green Dome over the center of the mosque, where the tomb of Muhammad is located. It is not exactly known when the green dome was constructed but manuscripts dating to the early 12th century describe the dome. It is known as the Dome of the Prophet or the Green Dome. Subsequent Islamic rulers greatly expanded and decorated it. Early Muslim leaders Abu Bakr and Umar are buried in an adjacent area in the mosque.[NEWLINE][NEWLINE]  The site was originally Muhammad''s house; he settled there after his Hijra to Medina, later building a mosque on the grounds. He himself shared in the heavy work of construction. The original mosque was an open-air building. The basic plan of the building has been adopted in the building of other mosques throughout the world.'),
			('TXT_KEY_THEMING_BONUS_NABAWI',		'Islamic calligraphy works'),
			('TXT_KEY_THEMING_BONUS_NABAWI_HELP',	'To maximize your bonus, make sure both Great Works are filled with Writings created by you.'),
			('TXT_KEY_WONDER_NABAWI_HELP',			'Provides a [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] Mosque in the City in which it is built. All Cities generate +10% [ICON_PEACE] Faith. Has 2 slot for [ICON_GREAT_WORK] Great Works of Writing that provide +4 [ICON_PEACE] Faith and [ICON_GOLDEN_AGE] Golden Age Points if [COLOR_POSITIVE_TEXT]Themed[ENDCOLOR]. +20% generation of [ICON_GREAT_WRITER] Great Writers in this City.');
			
UPDATE Language_en_US
SET Text = 'This Wonder is an unique [COLOR_YIELD_FOOD]Mosque[ENDCOLOR] ([ICON_RESEARCH]; [ICON_PEACE]; [ICON_GREAT_WORK]; [ICON_CULTURE]; [ICON_GOLDEN_AGE]; [ICON_HAPPINESS_3]) where you can learn arabic religious literature (+20%[ICON_GREAT_WRITER]; +2[ICON_GREAT_WORK]: [ICON_PEACE], [ICON_GOLDEN_AGE]). Massive faith output (+10%[ICON_PEACE][ICON_PEACE]) from your empire will help you in achieving religious domination.'
WHERE Tag = 'TXT_KEY_WONDER_NABAWI_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_NABAWI_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_NABAWI_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_YIELD_PRODUCTION]Holy City[ENDCOLOR]; Feature: [COLOR_NEGATIVE_TEXT]Water[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_NABAWI_HELP';		
----------------------------------------------------
-- Lavaux
INSERT INTO Language_en_US 
			(Tag,									Text)
VALUES		('TXT_KEY_BUILDING_LAVAUX',				'Lavaux'),
			('TXT_KEY_WONDER_LAVAUX_QUOTE',			'[NEWLINE]"A bottle of wine contains more philosophy than all the books in the world".[NEWLINE] - Louis Pasteur[NEWLINE]'),
			('TXT_KEY_WONDER_LAVAUX_PEDIA',			'TODO'),
			('TXT_KEY_WONDER_LAVAUX_HELP',			'Wonder places 2 new [ICON_RES_WINE] Wine resources inside City range if possible. Empire [ICON_HAPPINESS_3] Needs Modifier is reduced by 10% in all Cities. +1 [ICON_FOOD] Food from Lakes worked by this City.[NEWLINE][NEWLINE]Nearby [ICON_RES_WINE] Wine: +1 [ICON_FOOD] Food, +1 [ICON_GOLD] Gold and +1 [ICON_PEACE] Faith.');
			
UPDATE Language_en_US
SET Text = 'Wineyards of [COLOR_YIELD_FOOD]Lavaux[ENDCOLOR] are well-known source of unique [COLOR_CYAN]Grapes[ENDCOLOR] (+2[ICON_RES_WINE]; +1[ICON_FOOD], +1[ICON_GOLD], +1[ICON_PEACE]/[ICON_RES_WINE]). Try to make all your citizens much happier (-10%[ICON_HAPPINESS_3][ICON_HAPPINESS_3] Needs) using these wonderful fruits, benefitting crystal clear waters of nearby [COLOR_CITY_GREEN]Lake[ENDCOLOR] (+1[ICON_FOOD]).'
WHERE Tag = 'TXT_KEY_WONDER_LAVAUX_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_LAVAUX_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_LAVAUX_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Grassland[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Feature: [COLOR_CYAN]Lake[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_LAVAUX_HELP';		
----------------------------------------------------
-- Wartburg
INSERT INTO Language_en_US 
			(Tag,										Text)
VALUES		('TXT_KEY_BUILDING_WARTBURG',				'Wartburg'),
			('TXT_KEY_WONDER_WARTBURG_QUOTE',			'[NEWLINE]"In nature we never see anything isolated, but everything in connection with something else which is before it, beside it, under it and over it."[NEWLINE] - Johann Wolfgang von Goethe[NEWLINE]'),
			('TXT_KEY_WONDER_WARTBURG_PEDIA',			'Wartburg Castle was built in 1067 by Ludwig der Springer to secure his traditional territories. From 1172 to 1211, it was an important princely court in the Holy Roman Empire and a support for poets, thus becoming the setting of the legendary Sangerkrieg. Following his excommunication, Martin Luther stayed at Wartburg when he translated the New Testament from ancient Greek into German.[NEWLINE]For centuries, Wartburg has been a place of pilgrimage for its significance in German and Christian history. In the modern day, Wartburg remains a popular tourist attraction. It often stages the opera Tannhauser. While the castle still contains original structures from the 12th through 15th centuries, much of the interior dates back only to the 19th century, transformed under communist rule in the time of the GDR.'),
			('TXT_KEY_THEMING_BONUS_WARTBURG',			'Literature that inspired whole nations'),
			('TXT_KEY_THEMING_BONUS_WARTBURG_HELP',		'To maximize your bonus, make sure all the Great Work Slots are all filled with literature created by you.'),
			('TXT_KEY_WONDER_WARTBURG_HELP',			'+30% generation of [ICON_GREAT_WRITER] Great Writers in Empire. Has 3 slots for [ICON_GREAT_WORK] Great Works of Literature. +3 [ICON_CULTURE] Culture and +3 [ICON_PEACE] Faith and 3 [ICON_GOLDEN_AGE] Golden Age Points if [COLOR_POSITIVE_TEXT]Themed[ENDCOLOR]. 10 XP per each [ICON_GREAT_WORK] Great Work for Land units trained in this City. All Writer''s Guilds in the Empire receive +1 [ICON_PEACE] Faith.');
			
UPDATE Language_en_US
SET Text = 'With [COLOR_YIELD_FOOD]Wartburg[ENDCOLOR] you will become king of literature (+2[ICON_GREAT_WRITER]; +30%[ICON_GREAT_WRITER]), which can be stored on your new shelves (+3[ICON_GREAT_WORK]: [ICON_CULTURE], [ICON_PEACE], [ICON_GOLDEN_AGE]). Increase your faith output by constructing [COLOR_YIELD_FOOD]Writer''s Guilds[ENDCOLOR] (+1[ICON_PEACE][ICON_PEACE]) in your empire and raise up experience of your units using your city collection (10 XP/[ICON_GREAT_WORK]/[COLOR_YIELD_GOLD]Land[ENDCOLOR]).'
WHERE Tag = 'TXT_KEY_WONDER_WARTBURG_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_WARTBURG_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_WARTBURG_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Progress Finisher[ENDCOLOR]; Feature: [COLOR_CYAN]Forest[ENDCOLOR]; Building: [COLOR_CYAN]Writer''s Guild[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_WARTBURG_HELP';		
----------------------------------------------------
-- Great Zimbabwe
INSERT INTO Language_en_US 
			(Tag,										Text) 
VALUES		('TXT_KEY_BUILDING_GREAT_ZIMBABWE',			'Great Zimbabwe'),
			('TXT_KEY_WONDER_GREAT_ZIMBABWE_QUOTE',		'[NEWLINE]"God is good, but never dance with a lion."[NEWLINE] - Zimbabwean proverb[NEWLINE]'),
			('TXT_KEY_WONDER_GREAT_ZIMBABWE_PEDIA',		'TODO'),
			('TXT_KEY_WONDER_GREAT_ZIMBABWE_HELP',		'Gain 1 [COLOR_POSITIVE_TEXT]Additional[ENDCOLOR] [ICON_INTERNATIONAL_TRADE] Trade Route slot. [ICON_GOLD] Gold cost of aquiring new tiles reduced by 30% in all Cities. +2 [ICON_GOLDEN_AGE] Golden Age Points in this City and 10 XP to units constructed in all cities for each active [ICON_INTERNATIONAL_TRADE] Trade Route.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Great Zimbabwe[ENDCOLOR] makes use from your expanded trade network (+1[ICON_INTERNATIONAL_TRADE]), which supports your empire''s yields (+2[ICON_GOLDEN_AGE]/[ICON_INTERNATIONAL_TRADE][ICON_INTERNATIONAL_TRADE]) and army (2 XP/[ICON_INTERNATIONAL_TRADE][ICON_INTERNATIONAL_TRADE]). Make sure to use your treasury to expand your Cities more than your neighbours (-30%[ICON_GOLD][ICON_GOLD] Plot Cost).'
WHERE Tag = 'TXT_KEY_WONDER_GREAT_ZIMBABWE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_GREAT_ZIMBABWE_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_GREAT_ZIMBABWE_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Authority Finisher[ENDCOLOR]; Terrain: [COLOR_NEGATIVE_TEXT]Coast[ENDCOLOR]; Improvement: [COLOR_CYAN]3 (Mines + Camps)[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_GREAT_ZIMBABWE_HELP';		
----------------------------------------------------
-- Ahu Tongariki
INSERT INTO Language_en_US 
			(Tag,								Text) 
VALUES		('TXT_KEY_BUILDING_AHU',			'Ahu Tongariki'),
			('TXT_KEY_WONDER_AHU_QUOTE',		'[NEWLINE]"The metaphor is so obvious. Easter Island isolated in the Pacific Ocean - once the island got into trouble, there was no way they could get free. There was no other people from whom they could get help. In the same way that we on planet Earth, if we ruin our own world, we won''t be able to get help."[NEWLINE] - Jared Diamond[NEWLINE]'),
			('TXT_KEY_WONDER_AHU_PEDIA',		'TODO'),
			('TXT_KEY_WONDER_AHU_HELP',			'+1 [ICON_PRODUCTION] Production from Forest or Jungle, +1 [ICON_CULTURE] Culture from Quarries and +1 [ICON_PEACE] Faith from Coast tiles worked by this City. +20% [ICON_WORKER] Improvement Construction Rate. Grants 1 copy of unique luxury resource: Tern Egg.'),
			('TXT_KEY_RESOURCE_TERN',			'Tern Egg'),
			('TXT_KEY_RESOURCE_TERN_TEXT',		'TODO'),
			('TXT_KEY_RESOURCE_MONOPOLY_TERN',	'[COLOR_POSITIVE_TEXT]Monopoly Bonus:[ENDCOLOR] +10% [ICON_PEACE] Faith in all owned Cities.');
			
UPDATE Language_en_US
SET Text = 'Monumental platform, [COLOR_YIELD_FOOD]Ahu Tongariki[ENDCOLOR], boosts your production significantly if you have [COLOR_CITY_GREEN]Forest[ENDCOLOR] or [COLOR_CITY_GREEN]Jungle[ENDCOLOR] nearby (+1[ICON_PRODUCTION]) or hire new Workers (+20%[ICON_WORKER]). Cultural influence of all [COLOR_SELECTED_TEXT]Quarries[ENDCOLOR] (+1[ICON_CULTURE][ICON_CULTURE]) on your citizens, supported by new [COLOR_CYAN]Unique Luxury[ENDCOLOR] (+1[ICON_RES_TERN]) will send you in much brighter future.'
WHERE Tag = 'TXT_KEY_WONDER_AHU_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_AHU_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_AHU_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Feature: [COLOR_CYAN]Forest/Jungle[ENDCOLOR]; Resource: [ICON_RES_STONE] [COLOR_CYAN]Stone[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_AHU_HELP';		
----------------------------------------------------
-- Falun Mine
INSERT INTO Language_en_US 
			(Tag,								Text) 
VALUES		('TXT_KEY_BUILDING_FALUN',			'Falun Mine'),
			('TXT_KEY_WONDER_FALUN_QUOTE',		'[NEWLINE]"Mining is like a search-and-destroy mission."[NEWLINE] - Stewart Udall[NEWLINE]'),
			('TXT_KEY_WONDER_FALUN_PEDIA',		'Operating in Falun, Sweden from the tenth century to 1992, Falun Mine produced as much as two thirds of Europe''s copper needs and helped fund many of Sweden''s wars in the 17th century. The operation of the mine granted Sweden a virtual monopoly on copper through the 17th century, funding the various wars of Sweden during its great power era, though the output of the mine was a pittance by modern standards. In 1992, commercial mining ceased as the mine was no longer economically viable. In 2001, Falun Mine was selected as a UNESCO World Heritage site.'),
			('TXT_KEY_WONDER_FALUN_HELP',		'Wonder places 2 new [ICON_RES_COPPER] Copper resources inside City range if possible. +1 [ICON_GOLD] Gold from Mines worked by this City. Receive 1 [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] [ICON_GREAT_GENERAL] Great General and +100 [ICON_GREAT_ENGINEER] Great Engineers Progress on construction during Medieval or Renaissance Era.[NEWLINE][NEWLINE]Nearby [ICON_RES_COPPER] Copper: +1 [ICON_GOLD] and +1 [ICON_GOLDEN_AGE] Golden Age Point.');
			
UPDATE Language_en_US
SET Text = 'Mining complex at [COLOR_YIELD_FOOD]Falun[ENDCOLOR] makes all difficult investments possible. Huge support of [COLOR_YIELD_GOLD]Great Engineers[ENDCOLOR] (2%[ICON_GREAT_ENGINEER]/Construction) or [COLOR_YIELD_GOLD]Great General[ENDCOLOR], new [COLOR_CYAN]Copper[ENDCOLOR] deposits (+2[ICON_RES_COPPER]; +1[ICON_GOLD], +1[ICON_GOLDEN_AGE]/[ICON_RES_COPPER]) and more valuable local [COLOR_SELECTED_TEXT]Mines[ENDCOLOR] (+1[ICON_GOLD]) can easily buy you leadership of the world.'
WHERE Tag = 'TXT_KEY_WONDER_FALUN_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_FALUN_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_FALUN_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Progress Finisher[ENDCOLOR]; Improvement: [COLOR_CYAN]4 Mines[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_FALUN_HELP';		
----------------------------------------------------
-- Forge of Damascus
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_DAMASCUS',			'Forge of Damascus'),
			('TXT_KEY_WONDER_DAMASCUS_QUOTE',		'[NEWLINE]"The reputation and history of Damascus steel has given rise to many legends, such as the ability to cut through a rifle barrel or to cut a hair falling across the blade. The manufacturing technique has yet to be reverse engineered, even in modern times."[NEWLINE] - from legends about Damascus Steel[NEWLINE]'),
			('TXT_KEY_WONDER_DAMASCUS_PEDIA',		'Damascus steel was a type of steel used for manufacturing sword blades in the Near East made with wootz steel. These swords are characterized by distinctive patterns of banding and mottling reminiscent of flowing water. Such blades were reputed to be tough, resistant to shattering and capable of being honed to a sharp, resilient edge.[NEWLINE][NEWLINE]  The reputation and history of Damascus steel has given rise to many legends, such as the ability to cut through a rifle barrel or to cut a hair falling across the blade. Although many types of modern steel outperform ancient Damascus alloys, chemical reactions in the production process made the blades extraordinary for their time, as Damascus steel was superplastic and very hard at the same time.'),
			('TXT_KEY_PROMOTION_DAMASCUS',			'Damascus Steel'),
			('TXT_KEY_PROMOTION_DAMASCUS_HELP',		'+20%[ICON_STRENGTH]CS.'),
			('TXT_KEY_WONDER_DAMASCUS_HELP',		'+3 [ICON_PRODUCTION] Production with [COLOR_CYAN]Metallurgy[ENDCOLOR]. Provides a [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] Forge in the City in which it is built. All Melee and Mounted Units in the Empire get [COLOR_POSITIVE_TEXT]Damascus Steel[ENDCOLOR] promotion.[NEWLINE][NEWLINE]All [ICON_RES_IRON] Iron: +1 [ICON_PRODUCTION] Production and +1 [ICON_RESEARCH] Science.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Forge of Damascus[ENDCOLOR], thanks to recent scientific discovery, turns your melee weaponry into masterpiece ([COLOR_WATER_TEXT]Damascus Steel[ENDCOLOR]), which cannot be copied in any other [COLOR_YIELD_FOOD]Forge[ENDCOLOR] ([ICON_PRODUCTION]; [ICON_GOLD]; [ICON_GREAT_ENGINEER]; [ICON_RESEARCH]). Your production and science literally explodes, so remember to claim all available [COLOR_CYAN]Iron[ENDCOLOR] deposits (+1[ICON_PRODUCTION], +1[ICON_RESEARCH]/[ICON_RES_IRON][ICON_RES_IRON]).'
WHERE Tag = 'TXT_KEY_WONDER_DAMASCUS_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_DAMASCUS_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_DAMASCUS_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Authority Finisher[ENDCOLOR]; Feature: [COLOR_CYAN]Fresh Water[ENDCOLOR]; Resource: [ICON_RES_IRON] [COLOR_CYAN]Iron[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_DAMASCUS_HELP';		
----------------------------------------------------
-- Golden Dagon Pagoda
INSERT INTO Language_en_US 
			(Tag,										Text)
VALUES		('TXT_KEY_BUILDING_SHWEDAGON',				'Golden Dagon Pagoda'),
			('TXT_KEY_WONDER_SHWEDAGON_QUOTE',			'[NEWLINE]"There was a tumult among men and spirits, the blind beheld objects, the deaf heard sounds. The earth quaked, lightning flashed, gems rained down until they were knee deep, and all trees of the Himalayas, though not in season, bore blossoms and fruit."[NEWLINE] - King Okkalapa[NEWLINE]'),
			('TXT_KEY_WONDER_SHWEDAGON_PEDIA',			'Shwedagon Paya (also known as Shwedagon Pagoda or the Great Dragon Pagoda) is a large Buddhist stupa located in the Burmese city of Rangoon. It is 99 metres tall in it''s current state, and is coated with gold donated by the Burmese populus to maintain the Stupa. It is not known when the gold was put in place, although the stupa itself is said to date back over 2,500 years. Each sucessive dynasty has built upon the Stupa, until it reached the current height of 99 metres during reconstruction following an earthquake in 1768. Shwedagon Paya also features a crown of 5,448 diamonds and 2317 Rubies.'),
			('TXT_KEY_THEMING_BONUS_SHWEDAGON',			'Relics of the four previous Buddhas of the present kalpa'),
			('TXT_KEY_THEMING_BONUS_SHWEDAGON_HELP',	'To maximize your bonus, make sure all the Great Work Slots are all filled with Artifacts created by you.'),
			('TXT_KEY_WONDER_SHWEDAGON_HELP',			'+33% generation of [ICON_GREAT_ARTIST] Great Artists in Empire. +2 [ICON_PEACE] Faith from Artists. Has 4 slots for [ICON_GREAT_WORK] Great Works of Art. +3 [ICON_GOLD] Gold, [ICON_CULTURE] Culture, [ICON_PEACE] Faith and [ICON_TOURISM] Tourism if [COLOR_POSITIVE_TEXT]Themed[ENDCOLOR].');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Golden Pagoda[ENDCOLOR] fully focuses on every aspect related to artistry. Religious and more frequent artists in this city (+1[ICON_GREAT_ARTIST]; +33%[ICON_GREAT_ARTIST]; +2[ICON_PEACE]/[ICON_GREAT_ARTIST]), more valuable great works of your empire (+1[ICON_GOLD]/[ICON_GREAT_WORK][ICON_GREAT_WORK]) and much more space for new art (+4[ICON_GREAT_WORK]: [ICON_GOLD], [ICON_CULTURE], [ICON_PEACE], [ICON_TOURISM]) will make your city shine!'
WHERE Tag = 'TXT_KEY_WONDER_SHWEDAGON_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_SHWEDAGON_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_SHWEDAGON_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Tradition Finisher[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Feature: [COLOR_CYAN]Fresh Water[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_SHWEDAGON_HELP';		
----------------------------------------------------
-- Mont St. Michel
INSERT INTO Language_en_US 
			(Tag,								Text) 
VALUES		('TXT_KEY_BUILDING_MICHEL',			'Mont Saint-Michel'),
			('TXT_KEY_WONDER_MICHEL_QUOTE',		'[NEWLINE]"Church and State, Soul and Body, God and Man, are all one at Mont Saint Michel, and the business of all is to fight, each in his own way, or to stand guard for each other."[NEWLINE] - Henry Adams[NEWLINE]'),
			('TXT_KEY_WONDER_MICHEL_PEDIA',		'Perched on a rocky islet in the midst of vast sandbanks exposed to powerful tides between Normandy and Brittany stand the "Wonder of the West", a Gothic-style Benedictine abbey dedicated to the archangel St Michael, and the village that grew up in the shadow of its great walls. Built between the 11th and 16th centuries, the abbey is a technical and artistic tour de force, having had to adapt to the problems posed by this unique natural site.'),
			('TXT_KEY_WONDER_MICHEL_HELP',		'Provides a [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] Monastery in the City in which it is built. Greatly increase [ICON_STRENGTH] Combat Strength and Hit Points of this City. +3 [ICON_GOLD] Gold and +3 [ICON_TOURISM] Tourism with [COLOR_CYAN]Electricity[ENDCOLOR].');
			
UPDATE Language_en_US
SET Text = 'Lonely [COLOR_YIELD_FOOD]Mont Saint-Michel[ENDCOLOR] will turn your vulnerable [COLOR_YIELD_FOOD]Monastery[ENDCOLOR] ([ICON_FOOD]; [ICON_RESEARCH]; [ICON_PEACE]) into a fortress (+10[ICON_STRENGTH]; +100 HP), where you can focus on your soul (+2[ICON_PEACE]/5 [ICON_CITIZEN]) and plan next expenses for your growing treasury.'
WHERE Tag = 'TXT_KEY_WONDER_MICHEL_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_MICHEL_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_MICHEL_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]single-tile Island[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_MICHEL_HELP';		
----------------------------------------------------
-- Itsukushima Shrine
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_ITSUKUSHIMA',		'Itsukushima Shrine'),
			('TXT_KEY_WONDER_ITSUKUSHIMA_QUOTE',	'[NEWLINE]"Faith is not the clinging to a shrine but an endless pilgrimage of the heart."[NEWLINE] - Abraham Joshua Heschel[NEWLINE]'),
			('TXT_KEY_WONDER_ITSUKUSHIMA_PEDIA',	'Itsukushima shrine is one of the most iconic Shinto shrines in Japan. It is world renowned for it''s iconic "Floating" torii gate, which pilgrims had to steer their boat through before they could enter the shrine''s grounds. It is located on the island of Itsukushima, at the western end of Japan''s "inland sea". There has been a shrine at the location since approximately 628 CE, when one was constructed under the reign of Empresss Suiko. The current design, however, dates from 1168, when the shrine was constructed with funds provided by the warlord Taiya no Kiyomori.[NEWLINE][NEWLINE]  The shrine, and it''s floating Torii, are one of the "Three Views of Japan", along with the sandbar at Amanohashidate, and Matsushima bay. These have been designated as the most beautiful scenes of Japan, and are frequented by tourists.'),
			('TXT_KEY_WONDER_ITSUKUSHIMA_HELP',		'+1 [ICON_FOOD] Food, +1 [ICON_CULTURE] Culture and +1 [ICON_PEACE] Faith to Atolls and [ICON_CULTURE] Culture cost of aquiring new tiles reduced by 50% in coastal Cities. +1 [ICON_PEACE] Faith from Sea tiles. All Fishing Boats in the Empire receive +1 [ICON_CULTURE] Culture.[NEWLINE][NEWLINE]Nearby [ICON_RES_CORAL] Coral: +2 [ICON_PEACE] Faith.[NEWLINE]Nearby [ICON_RES_CRAB] Crab: +2 [ICON_PEACE] Faith.[NEWLINE]Nearby [ICON_RES_PEARLS] Pearls: +2 [ICON_PEACE] Faith.[NEWLINE]Nearby [ICON_RES_WHALE] Whales: +2 [ICON_PEACE] Faith.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Itsukushima Shrine[ENDCOLOR] boost yields generated by nearby [COLOR_CITY_BLUE]Oceans[ENDCOLOR] (+1[ICON_PEACE]), [COLOR_CYAN]Sea Luxuries[ENDCOLOR] (+2[ICON_PEACE]) and [COLOR_SELECTED_TEXT]Fishing Boats[ENDCOLOR] (+1[ICON_CULTURE]) as well as all [COLOR_CITY_GREEN]Atolls[ENDCOLOR] in your empire (+1[ICON_FOOD][ICON_FOOD]; +1[ICON_CULTURE][ICON_CULTURE]; +1[ICON_PEACE][ICON_PEACE]). Additionally expansion of your coastal cities is now much easier (+50%[ICON_CULTURE][ICON_CULTURE] Border Growth).'
WHERE Tag = 'TXT_KEY_WONDER_ITSUKUSHIMA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_ITSUKUSHIMA_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_ITSUKUSHIMA_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Resource: [ICON_RES_CORAL] [COLOR_CYAN]Coral[ENDCOLOR]/[ICON_RES_CRAB] [COLOR_CYAN]Crab[ENDCOLOR]/[ICON_RES_PEARLS] [COLOR_CYAN]Pearls[ENDCOLOR]/[ICON_RES_WHALE] [COLOR_CYAN]Whales[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_ITSUKUSHIMA_HELP';		
----------------------------------------------------
-- Qalhat
INSERT INTO Language_en_US 
			(Tag,								Text) 
VALUES		('TXT_KEY_BUILDING_QALHAT',			'Qalhat'),
			('TXT_KEY_WONDER_QALHAT_QUOTE',		'[NEWLINE]"The haven is very large and good, and is frequented by numerous ships with goods from India, and from this city the spices and other merchandize are distributed among the cities and towns of the interior. They also export many good Arab horses from this to India."[NEWLINE] - Marco Polo[NEWLINE]'),
			('TXT_KEY_WONDER_QALHAT_PEDIA',		'TODO'),
			('TXT_KEY_WONDER_QALHAT_HELP',		'Gain 1 [COLOR_POSITIVE_TEXT]Additional[ENDCOLOR] [ICON_INTERNATIONAL_TRADE] Trade Route slot. Sea [ICON_INTERNATIONAL_TRADE] Trade Routes gain +100% range and +1 [ICON_GOLD] Gold. +50% [ICON_PRODUCTION] Production of Cargo Ships. +2 [ICON_CULTURE] Culture for each [ICON_INTERNATIONAL_TRADE] Sea Trade Route from or to other major Player.[NEWLINE][NEWLINE]Nearby [ICON_RES_HORSE] Horses: +2 [ICON_GOLD].');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Qalhat[ENDCOLOR], mentioned by some europeans sailors seeking unique supplies (+1[ICON_GOLD]/[ICON_RES_HORSE]), is a wonderful place, where merchants of all seas meet and exchange their goods (Sea [ICON_INTERNATIONAL_TRADE]: +1[ICON_GOLD], +100%[ICON_SWAP]). Learn foreign culture by monopolizing worldwide sea trade (2[ICON_CULTURE]/Sea [ICON_INTERNATIONAL_TRADE][ICON_INTERNATIONAL_TRADE] with Major).'
WHERE Tag = 'TXT_KEY_WONDER_QALHAT_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_QALHAT_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_QALHAT_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Resource: [ICON_RES_HORSE] [COLOR_CYAN]Horses[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_QALHAT_HELP';		
----------------------------------------------------
-- Krak des Chevaliers
INSERT INTO Language_en_US 
			(Tag,									Text)
VALUES		('TXT_KEY_BUILDING_CHEVALIERS',			'Krak des Chevaliers'),
			('TXT_KEY_WONDER_CHEVALIERS_QUOTE',		'[NEWLINE]"I have long since been aware that your king is a man of the greatest honor and bravery, but he is imprudent."[NEWLINE] - Saladin to Richard I the Lionheart[NEWLINE]'),
			('TXT_KEY_WONDER_CHEVALIERS_PEDIA',		'Krak des Chevaliers, also Crac des Chevaliers, is a Crusader castle in Syria and one of the most important preserved medieval castles in the world. The site was first inhabited in the 11th century by a settlement of Kurds; as a result it was known as Hisn al Akrad, meaning the "Castle of the Kurds". In 1142 it was given by Raymond II, Count of Tripoli, to the Knights Hospitaller. It remained in their possession until it fell in 1271. It became known as Crac de l''Ospital; the name Krak des Chevaliers was coined in the 19th century.'),
			('TXT_KEY_WONDER_CHEVALIERS_HELP',		'Greatly increase [ICON_STRENGTH] Combat Strength and +20% [ICON_PRODUCTION] Production of Mounted and Siege Units in this City. Carries over 10% of [ICON_FOOD] Food after [ICON_CITIZEN] City Growth. +1 [ICON_SILVER_FIST] Military Unit Supply Cap. All other [COLOR_POSITIVE_TEXT]non-coastal[ENDCOLOR] Cities receive +1 [ICON_PEACE] Faith, +5 [ICON_STRENGTH] City Defense and +1 [ICON_SILVER_FIST] Military Unit Supply Cap.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Krak des Chevaliers[ENDCOLOR], castle on top of a hill, a perfect place to defend against your enemies (30[ICON_STRENGTH]) and plan next offensive. Increased production of your troops (+20%[ICON_PRODUCTION]/[COLOR_YIELD_GOLD]Mounted[ENDCOLOR], [COLOR_YIELD_GOLD]Siege[ENDCOLOR]), awesome leadership of new [COLOR_YIELD_GOLD]Great General[ENDCOLOR], and improved management of all your non-coastal cities (+1[ICON_PEACE][ICON_PEACE]; +5[ICON_STRENGTH][ICON_STRENGTH]; +1[ICON_SILVER_FIST][ICON_SILVER_FIST]) are just a beginning of your glory.'
WHERE Tag = 'TXT_KEY_WONDER_CHEVALIERS_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_CHEVALIERS_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_CHEVALIERS_HELP';
				
UPDATE Language_en_US SET Text = 'Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Feature: [COLOR_NEGATIVE_TEXT]Water[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_CHEVALIERS_HELP';		
----------------------------------------------------
-- University of Sankore
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]University of Sankore[ENDCOLOR] successfully combines science and faith together. Nearby [COLOR_YIELD_FOOD]Mosque[ENDCOLOR] ([ICON_RESEARCH]; [ICON_PEACE]; [ICON_GREAT_WORK]; [ICON_CULTURE]; [ICON_GOLDEN_AGE]; [ICON_HAPPINESS_3]) will attract noble great people, who use their influence to boost your most important research projects (50[ICON_RESEARCH]/[ICON_GREAT_PEOPLE]).'
WHERE Tag = 'TXT_KEY_WONDER_MOSQUE_OF_DJENNE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

UPDATE Language_en_US SET Text = REPLACE(Text, 'Requires completion of [COLOR_MAGENTA]Tradition[ENDCOLOR] Branch. ', '') WHERE Tag ='TXT_KEY_WONDER_MOSQUE_OF_DJENNE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 0);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_MOSQUE_OF_DJENNE_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_MOSQUE_OF_DJENNE_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Tradition Finisher[ENDCOLOR]; Terrain: [COLOR_CYAN]Desert[ENDCOLOR]; Building: [COLOR_CYAN]Library[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_MOSQUE_OF_DJENNE_HELP';
----------------------------------------------------
-- Hagia Sophia
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Hagia Sophia[ENDCOLOR] profits from its rich history and fully reorganizes your religion. New [COLOR_YIELD_GOLD]Great Prophet[ENDCOLOR], recently constructed [COLOR_YIELD_FOOD]Church[ENDCOLOR] ([ICON_PEACE]; [ICON_MISSIONARY]; [ICON_CULTURE]; [ICON_HAPPINESS_3]; [ICON_GREAT_WORK]) and increased pressure on dissenters (+25%[ICON_MISSIONARY] Strength) will force your will among other nations.'
WHERE Tag = 'TXT_KEY_WONDER_HAGIA_SOPHIA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,									Text) 
SELECT		'TXT_KEY_WONDER_HAGIA_SOPHIA_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_HAGIA_SOPHIA_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_YIELD_PRODUCTION]Holy City[ENDCOLOR]: Terrain: [COLOR_CYAN]Coast[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_HAGIA_SOPHIA_HELP';
----------------------------------------------------
-- Borobudur
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Borobudur[ENDCOLOR] is a gigantic [COLOR_YIELD_FOOD]Stupa[ENDCOLOR] ([ICON_PEACE]; [ICON_MISSIONARY]; [ICON_RESEARCH]; [ICON_GOLDEN_AGE]; [ICON_TOURISM]; [ICON_HAPPINESS_3]), which focuses on small actions, that can flow other cities with your faith (+5[ICON_PEACE]). Use existing and produce new more powerful [COLOR_YIELD_GOLD]Missionaries[ENDCOLOR] (+1[ICON_MISSIONARY] Spread) to quickly convert your enemies.'
WHERE Tag = 'TXT_KEY_WONDER_BOROBUDUR_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

UPDATE Language_en_US SET Text = REPLACE(Text, 'Must be built in a Holy City. ', '') WHERE Tag ='TXT_KEY_WONDER_BOROBUDUR_HELP';
	
INSERT INTO Language_en_US 
			(Tag,									Text) 
SELECT		'TXT_KEY_WONDER_BOROBUDUR_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_BOROBUDUR_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_YIELD_PRODUCTION]Holy City[ENDCOLOR]; Feature: [COLOR_CYAN]Jungle[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_BOROBUDUR_HELP';
----------------------------------------------------
-- Alhambra
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Alhambra[ENDCOLOR] is an architectural mix of two totally different cultures (+10%[ICON_CULTURE]) formed into unique [COLOR_YIELD_FOOD]Castle[ENDCOLOR] ([ICON_STRENGTH]; [ICON_SILVER_FIST]; [ICON_PRODUCTION]; [ICON_HAPPINESS_3]; [ICON_GREAT_WORK]), where special mounted melee units will be trained to support your expansion ([COLOR_WATER_TEXT]Jinete[ENDCOLOR]).'
WHERE Tag = 'TXT_KEY_WONDER_ALHAMBRA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

UPDATE Language_en_US SET Text = REPLACE(Text, 'Requires completion of [COLOR_MAGENTA]Authority[ENDCOLOR] Branch. ', '') WHERE Tag ='TXT_KEY_WONDER_ALHAMBRA_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 0);

INSERT INTO Language_en_US 
			(Tag,								Text) 
SELECT		'TXT_KEY_WONDER_ALHAMBRA_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_ALHAMBRA_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Authority Finisher[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; [COLOR_CYAN]Forest[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_ALHAMBRA_HELP';

----------------------------------------------------
-- Machu Picchu
UPDATE Language_en_US
SET Text = 'If your city is surrounded by [COLOR_CITY_BLUE]Mountains[ENDCOLOR] (+1[ICON_FOOD]; +1[ICON_PRODUCTION]; +1[ICON_CULTURE]; +1[ICON_PEACE]), then [COLOR_YIELD_FOOD]Machu Picchu[ENDCOLOR] is a perfect choice. All your city connections in this difficult terrain are more profitble (+15%[ICON_GOLD]/[ICON_CONNECTED][ICON_CONNECTED]) and your treasury is supported by qualified specialists (+1[ICON_GREAT_MERCHANT]).'
WHERE Tag = 'TXT_KEY_WONDER_MACHU_PICHU_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

UPDATE Language_en_US SET Text = REPLACE(Text, 'City must be built within 2 tiles of a Mountain that is inside your territory. ', '') WHERE Tag ='TXT_KEY_WONDER_MACHU_PICHU_HELP';
	
INSERT INTO Language_en_US 
			(Tag,									Text) 
SELECT		'TXT_KEY_WONDER_MACHU_PICHU_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_MACHU_PICHU_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]2 Mountains[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_MACHU_PICHU_HELP';
----------------------------------------------------
-- Forbidden Palace
UPDATE Language_en_US
SET Text = 'Rich [COLOR_YIELD_FOOD]Forbidden Palace[ENDCOLOR] will help you get out of crisis (-1[ICON_HAPPINESS_3] Poverty). Huge investments in empire developement (-15%[ICON_GOLD][ICON_GOLD] Purchase Cost) and brand new merchant district (+2[ICON_GREAT_MERCHANT]) will introduce you into new era.'
WHERE Tag = 'TXT_KEY_WONDER_FORBIDDEN_PALACE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

UPDATE Language_en_US SET Text = REPLACE(Text, 'Requires completion of [COLOR_MAGENTA]Progress[ENDCOLOR] Branch. ', '') WHERE Tag ='TXT_KEY_WONDER_FORBIDDEN_PALACE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 0);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_FORBIDDEN_PALACE_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_FORBIDDEN_PALACE_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Progress Finishier[ENDCOLOR]; [COLOR_YIELD_GOLD]Capital[ENDCOLOR]; Building: [COLOR_CYAN]Walls[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_FORBIDDEN_PALACE_HELP';
----------------------------------------------------
-- Cathedral of St. Basil
UPDATE Language_en_US SET Text = 'St. Basil''s Cathedral' WHERE Tag ='TXT_KEY_WONDER_KREMLIN';

UPDATE Language_en_US
SET Text = 'Colourful [COLOR_YIELD_FOOD]Cathedral of St. Basil[ENDCOLOR] is a kind of [COLOR_YIELD_FOOD]Order[ENDCOLOR] ([ICON_PEACE]; [ICON_MISSIONARY]; [ICON_STRENGTH]; [ICON_SILVER_FIST]; [ICON_HAPPINESS_3]), which has high base yields (+3[ICON_CULTURE]; +4[ICON_PEACE]) and lowers requirement for reformation (-5%[ICON_RELIGION] Followers). Use it to gain new abilities just before your enemies do the same!'
WHERE Tag = 'TXT_KEY_WONDER_KREMLIN_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

UPDATE Language_en_US SET Text = REPLACE(Text, 'Must be built in a Holy City. ', '') WHERE Tag ='TXT_KEY_WONDER_KREMLIN_HELP';
	
INSERT INTO Language_en_US 
			(Tag,								Text) 
SELECT		'TXT_KEY_WONDER_KREMLIN_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_KREMLIN_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_YIELD_PRODUCTION]Holy City[ENDCOLOR]; Feature: [COLOR_CYAN]River[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_KREMLIN_HELP';
----------------------------------------------------
-- Notre Dame
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Notre Dame[ENDCOLOR], wonderful [COLOR_YIELD_FOOD]Cathedral[ENDCOLOR] ([ICON_GOLD]; [ICON_PEACE]; [ICON_MISSIONARY]; [ICON_HAPPINESS_3]), creates history and starts new era in your empire (Start [ICON_GOLDEN_AGE]). Many impressing artwork (+2[ICON_GREAT_WORK]: [ICON_PEACE], [ICON_GOLDEN_AGE]) collected behind its walls will make your citizens much happier (+1[ICON_HAPPINESS_1]).'
WHERE Tag = 'TXT_KEY_BUILDING_NOTRE_DAME_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,									Text) 
SELECT		'TXT_KEY_BUILDING_NOTRE_DAME_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_BUILDING_NOTRE_DAME_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Tradition Finisher[ENDCOLOR]; Plot: [COLOR_CYAN]Flat[ENDCOLOR]; Feature: [COLOR_CYAN]River[ENDCOLOR]; Improvement: [COLOR_CYAN]Lumber Mill[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_BUILDING_NOTRE_DAME_HELP';
----------------------------------------------------
----------------------------------------------------
-- Ait Benhaddou
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_BENHADDOU',			'Ait Benhaddou'),
			('TXT_KEY_WONDER_BENHADDOU_QUOTE',		'[NEWLINE]"Are you not entertained?"[NEWLINE] - Maximus Decimus Meridius[NEWLINE]'),
			('TXT_KEY_WONDER_BENHADDOU_PEDIA',		'TODO'),
			('TXT_KEY_WONDER_BENHADDOU_HELP',		'Gain 1 [COLOR_POSITIVE_TEXT]Additional[ENDCOLOR] [ICON_INTERNATIONAL_TRADE] Trade Route slot. +1 [ICON_FOOD] Food from River tiles woked by this City. Nearby Villages receive +3 [ICON_GOLD] Gold and +3 [ICON_TOURISM] Tourism. +4 [ICON_TOURISM] Tourism with [COLOR_CYAN]Radio[ENDCOLOR].');
			
UPDATE Language_en_US
SET Text = 'Huge [COLOR_YIELD_FOOD]Ait Benhaddou[ENDCOLOR] [COLOR_SELECTED_TEXT]Village[ENDCOLOR] (+3[ICON_GOLD]; +3[ICON_TOURISM]) is awesome tourist attraction and an ideal scenography for numerous movie projects ([COLOR_CYAN]Radio:[ENDCOLOR] +4[ICON_TOURISM]). This desert settlement makes also profit from nearby [COLOR_CITY_GREEN]River[ENDCOLOR] (+1[ICON_FOOD]) to expand your current trade network (+1[ICON_INTERNATIONAL_TRADE]).'
WHERE Tag = 'TXT_KEY_WONDER_BENHADDOU_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_BENHADDOU_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_BENHADDOU_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Desert[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Feature: [COLOR_NEGATIVE_TEXT]Water[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_BENHADDOU_HELP';		
----------------------------------------------------
-- Kilwa Kisiwani
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_KILWA_KISIWANI',			'Kilwa Kisiwani'),
			('TXT_KEY_WONDER_KILWA_KISIWANI_QUOTE',		'[NEWLINE]"Kilwa is one of the most beautifully built cities in the world. The houses there are entirely made of wood, their rooftops out of rope grass, and it rains with great vigour."[NEWLINE] - Ibn Battuta[NEWLINE]'),
			('TXT_KEY_WONDER_KILWA_KISIWANI_PEDIA',		'TODO'),
			('TXT_KEY_WONDER_KILWA_KISIWANI_HELP',		'Receive 1 copy of [ICON_RES_PORCELAIN] Porcelain and [ICON_RES_JEWELRY] Jewelry. Gain 2 [COLOR_POSITIVE_TEXT]Additional[ENDCOLOR] [ICON_INTERNATIONAL_TRADE] Trade Route slots. +1 [ICON_PRODUCTION] Production from Strategic and +1 [ICON_GOLD] Gold from Luxury resources worked by this City.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Kilwa Kisiwani[ENDCOLOR] trade center (+2[ICON_INTERNATIONAL_TRADE]) acquires for you few copies of [COLOR_CYAN]City-State Luxuries[ENDCOLOR] (+1[ICON_RES_JEWELRY]; +1[ICON_RES_PORCELAIN]). Moreover, you receive substantial bonus from resources available on your terrain (+1[ICON_PRODUCTION]/[COLOR_CYAN]Strategic[ENDCOLOR]; +1[ICON_GOLD]/[COLOR_CYAN]Luxury[ENDCOLOR]).'
WHERE Tag = 'TXT_KEY_WONDER_KILWA_KISIWANI_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_KILWA_KISIWANI_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_KILWA_KISIWANI_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Statecraft Finisher[ENDCOLOR]; Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Improvement: [COLOR_CYAN]3 (Mines + Camps)[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_KILWA_KISIWANI_HELP';		
----------------------------------------------------
-- St. Peter's Basilica
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_ST_PETERS',			'St. Peter''s Basilica'),
			('TXT_KEY_WONDER_ST_PETERS_QUOTE',		'[NEWLINE]"A rock pile ceases to be a rock pile the moment a single man contemplates it, bearing within him the image of a cathedral."[NEWLINE] - Antoine de Saint-Exupery[NEWLINE]'),
			('TXT_KEY_WONDER_ST_PETERS_PEDIA',		'Basilica Papale di San Pietro in Vaticano, better known as St. Peter''s Basilica, is a late Renaissance church in Vatican City, with the largest interior of any Christian church in the world. The supposed burial site of the apostle Peter in 64 AD, some years later a shrine was constructed there. Replacing the shrine, construction of "old" St. Peter''s was begun by the Emperor Constantine between 319 and 333 AD.[NEWLINE][NEWLINE]  Having fallen into serious disrepair over the centuries, Pope Julius II in 1505 determined to demolish the old church and replace it with a monumental structure, a construction project that spanned the next 120 years under a succession of popes and architects. To finance the colossal project, a number of popes authorized the wholesale selling of indulgences, a practice that led in part to Martin Luther''s protestant movement.[NEWLINE][NEWLINE]  With work by some of the Renaissance''s leading figures - Michelangelo, Raphael, Bramante, Bernini and others - the church now stands as one of the great treasures of Western civilization.'),
			('TXT_KEY_WONDER_ST_PETERS_HELP',		'Provides a [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] Cathedral and 3 [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] Inquisitors in the City in which it is built. +1 [ICON_HAPPINESS_1] Happiness from all unique Religious buildings. Receive 1 [COLOR_POSITIVE_TEXT]Additional[ENDCOLOR] [ICON_DOPLOMAT] World Congress Delegate.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]St. Peter''s Basilica[ENDCOLOR] is not only religious, but also diplomatic (3 [COLOR_YIELD_GOLD]Missionaries[ENDCOLOR]; +1[ICON_INFLUENCE] League Vote) [COLOR_YIELD_FOOD]Cathedral[ENDCOLOR] ([ICON_GOLD]; [ICON_PEACE]; [ICON_MISSIONARY]; [ICON_HAPPINESS_3]) as well. Grants massive happiness boost, if you invest in religion (+1[ICON_HAPPINESS_1][ICON_HAPPINESS_1]/Religious building).'
WHERE Tag = 'TXT_KEY_WONDER_ST_PETERS_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_ST_PETERS_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_ST_PETERS_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_YIELD_PRODUCTION]Holy City[ENDCOLOR]; Plot: [COLOR_CYAN]Flat[ENDCOLOR][NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_ST_PETERS_HELP';		
----------------------------------------------------
-- Golden Pavilion
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_KINKAKU_JI',			'Golden Pavilion'),
			('TXT_KEY_WONDER_KINKAKU_JI_QUOTE',		'[NEWLINE]"A book holds a house of Gold."[NEWLINE] - Chinese Proverb[NEWLINE]'),
			('TXT_KEY_WONDER_KINKAKU_JI_PEDIA',		'Kinkaku-ji (literally "Temple of the Golden Pavilion") is a Buddhist temple in Kyoto, Japan. it was originally built as a villa at an unknown date, however was bought in 1397 by Shogun Ashikaga Yoshimitsu, who converted the villa into the Kinkaku-ji complex. Upon his death, it was converted to a Zen temple by his son.[NEWLINE][NEWLINE]  In July 1950 it was burnt down by a Monk with a mental illness, causing a massive renovation project to be undertaken. The renovations took five years, completed in 1955. The exterior of the upper two floors were covered in pure gold leave, giving the name "Golden Pavilion", however it is unclear wether the gold leaf was present in the pre-1950''s version.'),
			('TXT_KEY_WONDER_KINKAKU_JI_HELP',		'Provides a [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] Pagoda in the City in which it is built. +1 [ICON_FOOD] Food, +1 [ICON_PEACE] Faith and +1 [ICON_CULTURE] Culture from each Lake, Forest and Jungle tile worked by the City. Has 1 slot for [ICON_GREAT_WORK] Great Works of Literature.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Golden Pavilion[ENDCOLOR] is strongly tied to surrounding nature: [COLOR_CITY_GREEN]Lakes[ENDCOLOR], [COLOR_CITY_GREEN]Forests[ENDCOLOR] and [COLOR_CITY_GREEN]Jungles[ENDCOLOR] (+1[ICON_FOOD]; +1[ICON_CULTURE]; +1[ICON_PEACE]). Mentioned nature was always inspiration for writers (1[ICON_GREAT_WORK]) spending their leisure time in peaceful [COLOR_YIELD_FOOD]Pagodas[ENDCOLOR] ([ICON_RELIGION]; [ICON_HAPPINESS_3]).'
WHERE Tag = 'TXT_KEY_WONDER_KINKAKU_JI_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_KINKAKU_JI_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_KINKAKU_JI_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Fealty Finisher[ENDCOLOR]; Feature: [COLOR_CYAN]Fresh Water[ENDCOLOR], [COLOR_CYAN]Forest[ENDCOLOR]/[COLOR_CYAN]Jungle[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_KINKAKU_JI_HELP';		
----------------------------------------------------
-- Marae Arahurahu
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_MARAE',				'Marae Arahurahu'),
			('TXT_KEY_WONDER_MARAE_QUOTE',			'[NEWLINE]"The leader at the front and the workers behind the scenes."[NEWLINE] - Maori proverb[NEWLINE]'),
			('TXT_KEY_WONDER_MARAE_PEDIA',			'TODO'),
			('TXT_KEY_WONDER_MARAE_HELP',			'Has 1 slot for [ICON_GREAT_WORK] Great Works of Music. 10 XP per each [ICON_GREAT_WORK] Great Work for Land and Sea Units trained in this City. All Ranged Units get [COLOR_POSITIVE_TEXT]Marae[ENDCOLOR] promotion and all Land and Sea Units get [COLOR_POSITIVE_TEXT]Arahurahu[ENDCOLOR].'),
			('TXT_KEY_PROMOTION_MARAE',				'Marae'),
			('TXT_KEY_PROMOTION_MARAE_HELP',		'+10%[ICON_RANGE_STRENGTH]RCS.'),
			('TXT_KEY_PROMOTION_ARAHURAHU',			'Arahurahu'),
			('TXT_KEY_PROMOTION_ARAHURAHU_HELP',	'15 [ICON_CULTURE] Culture [COLOR:255:230:85:255]on Kill[ENDCOLOR] and 15 [ICON_PEACE] Faith [COLOR:255:230:85:255]on Death[ENDCOLOR].');

UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Marae Arahurahu[ENDCOLOR] greatly supports your army, especially ranged land units ([COLOR_WATER_TEXT]Marae[ENDCOLOR]), which should be core of your army ever since. Motivated troops are rewarded, regardless the result of the combat ([COLOR_WATER_TEXT]Arahurahu[ENDCOLOR]). Remember, that great works in the city increase experience gained by your units (10 XP/[ICON_GREAT_WORK]/[COLOR_YIELD_GOLD]Land[ENDCOLOR], [COLOR_YIELD_GOLD]Naval[ENDCOLOR]).'
WHERE Tag = 'TXT_KEY_WONDER_MARAE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_MARAE_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_MARAE_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Grassland[ENDCOLOR], [COLOR_CYAN]Coast[ENDCOLOR]; Building: [COLOR_CYAN]Garden[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_MARAE_HELP';		
----------------------------------------------------
-- Old Bridge
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_OLD_BRIDGE',			'Old Bridge in Mostar'),
			('TXT_KEY_WONDER_OLD_BRIDGE_QUOTE',		'[NEWLINE]"A refugee is someone who survived and who can create the future."[NEWLINE] - Amela Koluder[NEWLINE]'),
			('TXT_KEY_WONDER_OLD_BRIDGE_PEDIA',		'TODO'),
			('TXT_KEY_WONDER_OLD_BRIDGE_HELP',		'Receive 1 [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] [ICON_DIPLOMAT] Great Diplomat and 2 [COLOR_POSITIVE_TEXT]Additional[ENDCOLOR] [ICON_DOPLOMAT] World Congress Delegates.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Old Bridge in Mostar[ENDCOLOR] is your call for peace and prosperity (+2[ICON_INFLUENCE] League Votes; +1[ICON_HAPPINESS_1]). Use your diplomatic strength ([COLOR_YIELD_GOLD]Great Diplomat[ENDCOLOR]; +2[ICON_DIPLOMAT]) to bring nations on your site.'
WHERE Tag = 'TXT_KEY_WONDER_OLD_BRIDGE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_OLD_BRIDGE_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_OLD_BRIDGE_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Statecraft Finisher[ENDCOLOR]; Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Feature: [COLOR_CYAN]River[ENDCOLOR]; Player: [COLOR_CYAN]at Peace[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_OLD_BRIDGE_HELP';		
----------------------------------------------------
-- Meenakshi Temple
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_MEENAKSHI',			'Meenakshi Temple'),
			('TXT_KEY_WONDER_MEENAKSHI_QUOTE',		'[NEWLINE]"We greet you, Devi Meenakshi, she who shines like a thousand-million suns, adorned with bracelets and garlands... She who is auspicious, she who embodies existence. I always bow to you, whose compassion is an ocean."[NEWLINE] - Adi Shankara[NEWLINE]'),
			('TXT_KEY_WONDER_MEENAKSHI_PEDIA',		'TODO'),
			('TXT_KEY_WONDER_MEENAKSHI_HELP',		'Provides a [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] Mandir in the City in which it is built. Receive 100 [ICON_FOOD] Food from each [ICON_PEACE] Faith Purchase. All [ICON_GREAT_WORK] Great Works in the Empire receive +1 [ICON_FOOD] Food. +1 [ICON_PEACE] Faith from Lake and River tiles worked by this City.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Mandir[ENDCOLOR] ([ICON_FOOD]; [ICON_PEACE]; [ICON_HAPPINESS_3]; [ICON_GREAT_WORK]; [ICON_SPY]) praising [COLOR_YIELD_FOOD]Meenakshi[ENDCOLOR] increases faith in your people (+1[ICON_PEACE]/4 [ICON_CITIZEN][ICON_CITIZEN]) amazed by this colorful wonder. Waters of nearby [COLOR_CITY_GREEN]Lakes[ENDCOLOR] and [COLOR_CITY_GREEN]Rivers[ENDCOLOR] (+1[ICON_PEACE]) boost your growth, which can be raised even more by investing in religious projects (100[ICON_FOOD]/[ICON_PEACE][ICON_PEACE] Purchase) or devoting to artistry (+1[ICON_FOOD]/[ICON_GREAT_WORK][ICON_GREAT_WORK]).'
WHERE Tag = 'TXT_KEY_WONDER_MEENAKSHI_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_MEENAKSHI_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_MEENAKSHI_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_YIELD_PRODUCTION]Holy City[ENDCOLOR]; Feature: [COLOR_CYAN]Fresh Water[ENDCOLOR][NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_MEENAKSHI_HELP';		
----------------------------------------------------
-- Peterhof
INSERT INTO Language_en_US 
			(Tag,									Text) 
VALUES		('TXT_KEY_BUILDING_PETERHOF',			'Peterhof'),
			('TXT_KEY_WONDER_PETERHOF_QUOTE',		'[NEWLINE]"It is my great desire to reform my subjects, and yet I am ashamed to confess that I am unable to reform myself."[NEWLINE] - Peter The Great[NEWLINE]'),
			('TXT_KEY_WONDER_PETERHOF_PEDIA',		'The Peterhof Palace is a series of palaces and gardens located in Saint Petersburg, Russia, laid out on the orders of Peter the Great. These Palaces and gardens are sometimes referred as the "Russian Versailles". The palace-ensemble along with the city centre is recognised as a UNESCO World Heritage Site.'),
			('TXT_KEY_WONDER_PETERHOF_HELP',		'+10% generation of [ICON_GREAT_PEOPLE] Great People in this City. Starts 20 turn of [ICON_HAPPINESS_1] WLTKD in this City. +15% [ICON_PRODUCTION] Production, [ICON_GOLD] Gold and [ICON_GOLDEN_AGE] Golden Age Points during [ICON_HAPPINESS_1] WLTKD.');
			
UPDATE Language_en_US
SET Text = 'Palace of [COLOR_YIELD_FOOD]Peterhof[ENDCOLOR] tells your citizens about your will to do everything possible to improve their lives (+6[ICON_GOLDEN_AGE]; 20[ICON_HAPPINESS_1] WLTKD), and they respond you with the same (+15%[ICON_PRODUCTION], +15%[ICON_GOLD], +15%[ICON_GOLDEN_AGE]/[ICON_HAPPINESS_1] WLTKD). Such a prosperity is strong invitation for any kind of nobles planning to cisit your city (+10%[ICON_GREAT_PEOPLE]).'
WHERE Tag = 'TXT_KEY_WONDER_PETERHOF_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_PETERHOF_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_PETERHOF_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Imperialism Finisher[ENDCOLOR]; Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Plot: [COLOR_CYAN]Flat[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_PETERHOF_HELP';		
----------------------------------------------------
-- Bakken
INSERT INTO Language_en_US 
			(Tag,								Text) 
VALUES		('TXT_KEY_BUILDING_BAKKEN',			'Bakken'),
			('TXT_KEY_WONDER_BAKKEN_QUOTE',		'[NEWLINE]"Amusement is appealing because we don''t have to think. It spares us the fear and anxiety that might otherwise prey on our thoughts."[NEWLINE] - John Ortberg[NEWLINE]'),
			('TXT_KEY_WONDER_BAKKEN_PEDIA',		'TODO'),
			('TXT_KEY_WONDER_BAKKEN_HELP',		'Starts 10 turn of [ICON_HAPPINESS_1] WLTKD in this City. +33% [ICON_TOURISM] Tourism during [ICON_HAPPINESS_1] WLTKD.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Bakken[ENDCOLOR] provides entertainment on maximum level (+3[ICON_HAPPINESS_1]), greatly increasing your tourism traffic and its profits (10[ICON_HAPPINESS_1] WLTKD; +33%[ICON_TOURISM]/[ICON_HAPPINESS_1] WLTKD).'
WHERE Tag = 'TXT_KEY_WONDER_BAKKEN_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_BAKKEN_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_BAKKEN_HELP';
				
UPDATE Language_en_US SET Text = 'Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Player: [COLOR_CYAN]Happiness > 80%[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_BAKKEN_HELP';		
----------------------------------------------------
-- House of Trades of the Indies
INSERT INTO Language_en_US 
			(Tag,										Text) 
VALUES		('TXT_KEY_BUILDING_HOUSE_OF_TRADE',			'House of Trade of the Indies'),
			('TXT_KEY_WONDER_HOUSE_OF_TRADE_QUOTE',		'[NEWLINE]"All other lands found on the western side of the boundary shall belong to the King and Queen of Castille - and their successors."[NEWLINE] - Treaty of Tordesillas[NEWLINE]'),
			('TXT_KEY_WONDER_HOUSE_OF_TRADE_PEDIA',		'TODO'),
			('TXT_KEY_WONDER_HOUSE_OF_TRADE_HELP',		'Receive 1 [COLOR_POSITIVE_TEXT]Free[ENDCOLOR] [ICON_GREAT_ADMIRAL] Great Admiral. Gain 2 [COLOR_POSITIVE_TEXT]Additional[ENDCOLOR] [ICON_INTERNATIONAL_TRADE] Trade Route slots. +10% [ICON_PRODUCTION] Production towards Naval Military Units and Cargo Ships.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]House of Trade[ENDCOLOR] bonds your military with trade so tightly, that it feels natural (+10%[ICON_PRODUCTION]/[COLOR_YIELD_GOLD]Military Naval[ENDCOLOR], [COLOR_YIELD_GOLD]Cargo[ENDCOLOR]). Fresh leadership of [COLOR_YIELD_GOLD]Great Admiral[ENDCOLOR] and new possible trade routes (+2[ICON_INTERNATIONAL_TRADE]) will make ruler of all seas.'
WHERE Tag = 'TXT_KEY_WONDER_HOUSE_OF_TRADE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_HOUSE_OF_TRADE_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_HOUSE_OF_TRADE_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Player: [COLOR_CYAN]2 CS Allies[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_HOUSE_OF_TRADE_HELP';		
----------------------------------------------------
-- Solovietsky Monastery
INSERT INTO Language_en_US 
			(Tag,										Text) 
VALUES		('TXT_KEY_BUILDING_SOLOVIETSKY',			'Solovietsky Monastery'),
			('TXT_KEY_WONDER_SOLOVIETSKY_QUOTE',		'[NEWLINE]"Everything is defeated before love."[NEWLINE] - Elder Thaddeus of Vitovnica[NEWLINE]'),
			('TXT_KEY_WONDER_SOLOVIETSKY_PEDIA',		'The Solovetsky Monastery is a fortified monastery located on the Solovetsky Islands in the White Sea in northern Russia. It was one of the largest Christian citadels in northern Russia before it was converted into a Soviet prison and labor camp in 1926-39, and served as a prototype for the camps of the Gulag system. The monastery has experienced several major changes and military sieges. Its most important structures date from the 16th century, when Filip Kolychev was its hegumen (comparable to an abbot).'),
			('TXT_KEY_WONDER_SOLOVIETSKY_HELP',			'+1 [ICON_PRODUCTION] Production and +1 [ICON_PEACE] Faith from Tundra tiles worked by this City. Greatly increase [ICON_STRENGTH] Combat Strength and Hit Points of this City. +1 [ICON_WAR] Military Unit Supply Cap. +15% [ICON_PRODUCTION] Production towards Naval Military Units.');
			
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Solovietsky Monastery[ENDCOLOR] greatly supports your weak Tundra (+1[ICON_PRODUCTION]; +1[ICON_PEACE]) tiles. It helps you in quick navy reinforcement (+25%[ICON_PRODUCTION]/[COLOR_YIELD_GOLD]Military Naval[ENDCOLOR]) and strengthen your offense and deffense in the city (10[ICON_STRENGTH]; 50 HP; +1[ICON_SILVER_FIST]).'
WHERE Tag = 'TXT_KEY_WONDER_SOLOVIETSKY_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US (Tag, Text) 
SELECT 'TXT_KEY_WONDER_SOLOVIETSKY_HELP_CUT', Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_SOLOVIETSKY_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Fealty Finisher[ENDCOLOR]; Terrain: [COLOR_CYAN]Tundra[ENDCOLOR], [COLOR_CYAN]Coast[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_SOLOVIETSKY_HELP';		
----------------------------------------------------
-- Globe Theater
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Globe Theater[ENDCOLOR] unites all artistic proffessions in one wonder (+2[ICON_GOLDEN_AGE]/[ICON_GREAT_ARTIST][ICON_GREAT_ARTIST], [ICON_GREAT_WRITER][ICON_GREAT_WRITER], [ICON_GREAT_MUSICIAN][ICON_GREAT_MUSICIAN]), but its much stronger focus on literature is obvious ([COLOR_YIELD_GOLD]Great Writer[ENDCOLOR]; +2[ICON_GREAT_WORK]: [ICON_GOLD]). This wonder is so influencial, that people''s tastes change accoridng to your will (-1[ICON_HAPPINESS_3] Boredom; -1[ICON_HAPPINESS_3][ICON_HAPPINESS_3] Urbanization).'
WHERE Tag = 'TXT_KEY_WONDER_GLOBE_THEATER_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_GLOBE_THEATER_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_GLOBE_THEATER_HELP';
				
UPDATE Language_en_US SET Text = 'Feature: [COLOR_CYAN]River[ENDCOLOR]; Building: [COLOR_CYAN]Amphitheater[ENDCOLOR], [COLOR_CYAN]Baths[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_GLOBE_THEATER_HELP';
----------------------------------------------------
-- Chichen Itza
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Chichen Itza[ENDCOLOR] makes your golden ages much more important (+50%[ICON_GOLDEN_AGE] Length), and your citizens much happier (-10%[ICON_HAPPINESS_3][ICON_HAPPINESS_3]). Build it, and your people will awe you.'
WHERE Tag = 'TXT_KEY_WONDER_TAJ_MAHAL_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,									Text) 
SELECT		'TXT_KEY_WONDER_TAJ_MAHAL_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_TAJ_MAHAL_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Plains[ENDCOLOR]; Plot: [COLOR_CYAN]Flat[ENDCOLOR]; Feature: [COLOR_CYAN]Forest[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_TAJ_MAHAL_HELP';
----------------------------------------------------
-- Himeji Castle
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Himeji Castle[ENDCOLOR] turns typical [COLOR_YIELD_FOOD]Castle[ENDCOLOR] ([ICON_STRENGTH]; [ICON_SILVER_FIST]; [ICON_PRODUCTION]; [ICON_HAPPINESS_3]; [ICON_GREAT_WORK]) into impenetrable fortress (+10%[ICON_STRENGTH][ICON_STRENGTH]). Moreover, you can create bigger army (+5[ICON_SILVER_FIST]) and all units on your own land receive combat bonuses ([COLOR_WATER_TEXT]Himeji Castle[ENDCOLOR]).'
WHERE Tag = 'TXT_KEY_WONDER_HIMEJI_CASTLE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_HIMEJI_CASTLE_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_HIMEJI_CASTLE_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_CYAN]Coast[ENDCOLOR]; Plot: [COLOR_CYAN]Flat[ENDCOLOR]; Feature: [COLOR_CYAN]Forest[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_HIMEJI_CASTLE_HELP';
----------------------------------------------------
-- Leaning Tower of Pisa
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Leaning Tower of Piza[ENDCOLOR] brings attention of many influential nobles, who want to cooperate with you ([COLOR_YIELD_GOLD]Great Person[ENDCOLOR]). Their final destination is not only this city (+25%[ICON_GREAT_PEOPLE]), but also all others in your empire (+10%[ICON_GREAT_PEOPLE][ICON_GREAT_PEOPLE]).'
WHERE Tag = 'TXT_KEY_WONDER_LEANING_TOWER_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_LEANING_TOWER_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_LEANING_TOWER_HELP';
				
UPDATE Language_en_US SET Text = 'Plot: [COLOR_CYAN]Flat[ENDCOLOR]; Feature: [COLOR_CYAN]Water[ENDCOLOR], [COLOR_CYAN]Marsh[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_LEANING_TOWER_HELP';
----------------------------------------------------
-- Porcelain Tower
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Porcelain Tower[ENDCOLOR] is a wonderful scientific building which improves education of your citizens (-1[ICON_HAPPINESS_3] Illiteracy), invites new great people to the city ([COLOR_YIELD_GOLD]Great Scientist[ENDCOLOR]; +2[ICON_GREAT_SCIENTIST]) and makes use of overall research you produce (+50%[ICON_RESEARCH]/[ICON_RESEARCH] RA or +25%[ICON_SCIENCE] if [ICON_RESEARCH] RAs are disabled).'
WHERE Tag = 'TXT_KEY_WONDER_PORCELAIN_TOWER_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_PORCELAIN_TOWER_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_PORCELAIN_TOWER_HELP';
				
UPDATE Language_en_US SET Text = 'Feature: [COLOR_CYAN]River[ENDCOLOR]; Player: [COLOR_CYAN]2 CS Allies[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_PORCELAIN_TOWER_HELP';
----------------------------------------------------
-- Taj Mahal
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Taj Mahal[ENDCOLOR] maximizes number of golden ages you enter (Start [ICON_GOLDEN_AGE]; +1[ICON_GOLDEN_AGE]/2[ICON_CITIZEN]) and benefits from multiple religions in your city (+3[ICON_RESEARCH], +3[ICON_CULTURE], +3[ICON_PEACE]/[ICON_RELIGION]). Do not let them go away!'
WHERE Tag = 'TXT_KEY_WONDER_PYRAMIDS_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_PYRAMIDS_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_PYRAMIDS_HELP';
				
UPDATE Language_en_US SET Text = 'Terrain: [COLOR_NEGATIVE_TEXT]Coast[ENDCOLOR]; Plot: [COLOR_CYAN]Flat[ENDCOLOR]; Feature: [COLOR_CYAN]River[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_PYRAMIDS_HELP';
----------------------------------------------------
-- Uffizi
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Uffizi[ENDCOLOR] gallery is perfect spot for any talented artist ([COLOR_YIELD_GOLD]Great Artist[ENDCOLOR]; +3[ICON_GREAT_WORK]: [ICON_CULTURE]; +1[ICON_CULTURE]/[ICON_GREAT_WORK][ICON_GREAT_WORK]). This wonder also resolves almost all problems with urbanization in your empire (-1[ICON_HAPPINESS_3][ICON_HAPPINESS_3] Urbanization)'
WHERE Tag = 'TXT_KEY_WONDER_UFFIZI_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_UFFIZI_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_UFFIZI_HELP';
				
UPDATE Language_en_US SET Text = 'Feature: [COLOR_CYAN]River[ENDCOLOR]; Great Works: [COLOR_CYAN]2 [ICON_GREAT_WORK] GW of Art[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_UFFIZI_HELP';
----------------------------------------------------
-- Sistine Chapel
UPDATE Language_en_US
SET Text = 'Filled with wonderful frescos (+2[ICON_GREAT_WORK]: [ICON_CULTURE], [ICON_PEACE]) beautiful [COLOR_YIELD_FOOD]Sistine Chapel[ENDCOLOR] is literally an artistic bomb for your empire (+10%[ICON_CULTURE][ICON_CULTURE]). Make sure to built it, if you aim for a cultural victory.'
WHERE Tag = 'TXT_KEY_WONDER_SISTINE_CHAPEL_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_WONDER_SISTINE_CHAPEL_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_SISTINE_CHAPEL_HELP';
				
UPDATE Language_en_US SET Text = 'Building: [COLOR_CYAN]Artist''s Guild[ENDCOLOR]; Player: [COLOR_CYAN]Founded Religion[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_SISTINE_CHAPEL_HELP';
----------------------------------------------------
-- Summer Palace
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Sumer Palace[ENDCOLOR] is another wonder fully focused on strengthening your diplomatic power ([COLOR_WATER_TEXT]Nobility[ENDCOLOR]) and improving construction rate of your negotiators (+20%[ICON_PRODUCTION]/[COLOR_YIELD_GOLD]Diplomatic[ENDCOLOR]). It also upgrades [COLOR_YIELD_FOOD]Chanceries[ENDCOLOR] (+3[ICON_GOLD][ICON_GOLD]; +1[ICON_CULTURE][ICON_CULTURE]) in your empire and creates new source of [COLOR_CYAN]Paper[ENDCOLOR] (+1[ICON_RES_PAPER]).'
WHERE Tag = 'TXT_KEY_BUILDING_SUMMER_PALACE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

INSERT INTO Language_en_US 
			(Tag,										Text) 
SELECT		'TXT_KEY_BUILDING_SUMMER_PALACE_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_BUILDING_SUMMER_PALACE_HELP';
				
UPDATE Language_en_US SET Text = 'Plot: [COLOR_CYAN]Hill[ENDCOLOR]; Feature: [COLOR_CYAN]Forest[ENDCOLOR], [COLOR_CYAN]Lake[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_BUILDING_SUMMER_PALACE_HELP';
----------------------------------------------------
-- Red Fort
UPDATE Language_en_US
SET Text = '[COLOR_YIELD_FOOD]Red Fort[ENDCOLOR] is an ideal choice for a militaristic leader. Increased global army limit (+5%[ICON_SILVER_FIST][ICON_SILVER_FIST]), upgraded city''s offensive and defensive capabilities (+10%[ICON_RANGE_STRENGTH]; +1[ICON_SWAP]; +30[ICON_STRENGTH]; +100 HP), brand new [COLOR_YIELD_FOOD]Arsenal[ENDCOLOR] ([ICON_STRENGTH]; [ICON_RANGE_STRENGTH]; [ICON_SILVER_FIST]; [ICON_SPY]; [ICON_HAPPINESS_3]) as well as support of [COLOR_YIELD_GOLD]Great Engineer[ENDCOLOR] and [COLOR_YIELD_GOLD]Great Scientists[ENDCOLOR] (+1[ICON_GREAT_SCIENTIST]) will make from you unquestionnable lider of the world.'
WHERE Tag = 'TXT_KEY_WONDER_RED_FORT_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 1);

UPDATE Language_en_US SET Text = REPLACE(Text, 'Requires completion of [COLOR_MAGENTA]Fealty[ENDCOLOR] Branch. ', '') WHERE Tag ='TXT_KEY_WONDER_RED_FORT_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='MW-HELP' AND Value= 0);

INSERT INTO Language_en_US 
			(Tag,								Text) 
SELECT		'TXT_KEY_WONDER_RED_FORT_HELP_CUT',	Text
FROM Language_en_US WHERE Tag = 'TXT_KEY_WONDER_RED_FORT_HELP';
				
UPDATE Language_en_US SET Text = 'Special: [COLOR_MAGENTA]Fealty Finisher[ENDCOLOR]; Terrain: [COLOR_NEGATIVE_TEXT]Coast[ENDCOLOR]; Feature: [COLOR_CYAN]River[ENDCOLOR].[NEWLINE][NEWLINE]'||Text WHERE Tag ='TXT_KEY_WONDER_RED_FORT_HELP';
----------------------------------------------------
----------------------------------------------------
