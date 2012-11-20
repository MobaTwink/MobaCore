/*World.sql Updates
 *Myendras World Updates
 *LastUpdate: Phailure
 *http://wow.urnaweb.cz/wotlk/web/index.php
 */


REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (18069, 0, 4, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 28747, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mogor - At 30% HP - Cast Frenzy');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (1806901, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 15, 9977, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 'Mogor - KC');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (18069, 0, 5, 0, 2, 0, 100, 1, 0, 30, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - At 30% HP - Say Line 0');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (18069, 0, 3, 0, 2, 0, 100, 1, 0, 60, 0, 0, 11, 15982, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mogor - At 60% HP - Cast Healing Wave');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=10 AND `SourceGroup`=34379;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(10,34379,50452,0,0,19,0,8,0,0,0,0,'', 'Wodin''s Lucky Necklace only 25 heroic'),
(10,34379,50453,0,0,19,0,8,0,0,0,0,'', 'Ring of Rotting Sinew only 25 heroic');

DELETE FROM spell_script_names WHERE scriptName="spell_dru_savage_roar";
INSERT INTO spell_script_names (spell_id, ScriptName) VALUES
(52610, 'spell_dru_savage_roar');


SET @TRIGGER := 22991;
SET @EGG := 185549;
SET @SKYBLAST := 39844;
SET @SUMMEGG := 39843;
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`=@TRIGGER;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@TRIGGER AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@TRIGGER*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@TRIGGER,0,0,0,25,0,100,0,0,0,0,0,11,@SUMMEGG,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Monstrous Kaliri Egg Trigger - On spawn/reset - Summon Monstrous Kaliri Egg (object wild)'),
(@TRIGGER,0,1,2,8,0,100,0,@SKYBLAST,0,0,0,33,@TRIGGER,0,0,0,0,0,16,0,0,0,0,0,0,0, 'Monstrous Kaliri Egg Trigger - On Skyguard Blasting Charge hit - Give kill credit to invoker party'),
(@TRIGGER,0,2,0,61,0,100,0,0,0,0,0,80,@TRIGGER*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Monstrous Kaliri Egg Trigger - Linked with previous event - Start script 0'),
(@TRIGGER*100,9,0,0,0,0,100,0,44000,44000,0,0,11,@SUMMEGG,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Monstrous Kaliri Egg Trigger /On actionlist/ - Action 0 - Cast Summon Monstrous Kaliri Egg');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SKYBLAST;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,@SKYBLAST,0,0,31,0,3,22991,0,0,0,'','Skyguard Blasting Charge can hit only Monstrous Kaliri Egg Trigger'),
(13,2,@SKYBLAST,0,0,31,0,5,185549,0,0,0,'','Skyguard Blasting can hit only Monstrous Kaliri Egg');
UPDATE `gameobject_template` SET `AIName`='' WHERE `entry`=@EGG;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@EGG AND `source_type`=1;
DELETE FROM `gameobject` WHERE `id`=@EGG;


REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-203373, 0, 0, 1, 1, 0, 100, 1, 1000, 1000, 1000, 1000, 11, 50389, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-203373, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 11, 50390, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-203373, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 28, 50389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-203373, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 50390, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-203372, 0, 0, 1, 1, 0, 100, 1, 1000, 1000, 1000, 1000, 11, 50389, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-203372, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 11, 50390, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-203372, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 28, 50389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-203372, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 50390, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108037, 0, 0, 1, 1, 0, 100, 1, 1000, 1000, 1000, 1000, 11, 50389, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108037, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 11, 50390, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108037, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 28, 50389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108037, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 50390, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108036, 0, 0, 1, 1, 0, 100, 1, 1000, 1000, 1000, 1000, 11, 50389, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108036, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 11, 50390, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108036, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 28, 50389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108036, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 50390, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108035, 0, 0, 1, 1, 0, 100, 1, 1000, 1000, 1000, 1000, 11, 50389, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108035, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 11, 50390, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108035, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 28, 50389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108035, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 50390, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108034, 0, 0, 1, 1, 0, 100, 1, 1000, 1000, 1000, 1000, 11, 50389, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108034, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 11, 50390, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On reset - Cast Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108034, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 28, 50389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');
REPLACE INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (-108034, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 50390, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Storm Giant - On Aggro - Remove Flesh Construct Test');


REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -1833, 2, 'Bladestorm - Cheap shot');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -42950, 2, 'Bladestorm - Dragon');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -10890, 2, 'Bladestorm - Fear');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (676, -46924, 1, 'Bladestorm - Fix');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (51722, -46924, 1, 'Bladestorm - Fix');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (64058, -46924, 1, 'Bladestorm - Fix');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (64346, -46924, 1, 'Bladestorm - Fix');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -10308, 2, 'Bladestorm - Hammer of Justice');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -408, 2, 'Bladestorm - Kidney Shot');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -605, 2, 'Bladestorm - Mind Control');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -47847, 2, 'Bladestorm - Shadow fury');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -45524, 2, 'Bladestorm immune at Chains of Ice');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -68766, 2, 'Bladestorm immune at Desecration');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -13810, 2, 'Bladestorm immune at Frost Trap');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -116, 2, 'Bladestorm immune at FrostBolt');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -58617, 2, 'Bladestorm immune at Glyph of Heart Strike');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -51514, 2, 'Bladestorm immune at Hex');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -53227, 2, 'Bladestorm Immune Knockback');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -59159, 2, 'Bladestorm Knockback');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -12826, 2, 'Bladestorm vs Polymorph');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (46924, -6358, 2, 'Bladestorm vs Sucubus');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (49576, 49560, 0, 'Death Grip');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (31224, -1543, 2, 'Cloak of Shadow - Immune');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (31224, -6358, 2, 'Cloak of Shadows - Seduction');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (11129, 35581, 2, 'Combustion increased Fire Damage');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (-11129, -35581, 2, 'Combustion increased Fire Damage Remove');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (54566, 61697, 0, 'Death Knight Pet Scaling 03');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (44572, 71757, 0, 'Deep Freeze - Damage Proc');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (51722, -23920, 2, 'Dismantle remove Reflect');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (53376, 57318, 2, 'Sanctified Wrath');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (53375, 57318, 2, 'Sanctified Wrath');

INSERT INTO `smart_scripts` (`entryorguid`, `id`, `link`, `event_type`, `event_flags`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
('18069', '14', '0', '6', '1', '15', '9977', '16', 'Mogor - On Death - Give Quest Credit');

DELETE FROM `npc_vendor` WHERE `entry` = 24495 AND `item` IN (37737,46707,33863,33682);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES 
(24495, 0, 37737, 0, 0, 2397), -- "Brew of the Month" Club Membership Form (Horde) (200 Brewfest Tokens) http://www.old.wowhead.com/item=37737
(24495, 0, 46707, 0, 0, 2275), -- Pint-Sized Pink Pachyderm (100 Brewfest Tokens) http://www.old.wowhead.com/item=46707
(24495, 0, 33863, 0, 0, 2276), -- Brewfest Dress (200 Brewfest Tokens) http://www.old.wowhead.com/item=33863
(24495, 0, 33862, 0, 0, 2276); -- Brewfest Regalia (200 Brewfest Tokens) http://www.old.wowhead.com/item=33862

DELETE FROM `npc_vendor` WHERE `entry` = 23710 AND `item` IN (46707,32233);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES 
(23710, 0, 46707, 0, 0, 2275), -- Pint-Sized Pink Pachyderm (100 Brewfest Tokens) http://www.old.wowhead.com/item=46707
(23710, 0, 32233, 0, 0, 0); -- Wolpertinger's Tankard http://www.old.wowhead.com/item=32233

-- A lot of missing spawns. Objects and creatures
SET @CGUID := 1700000;
SET @OGUID := 1700000;
SET @EVENT := 24;
-- Berfest Reveler
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+33;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
-- Barleybrew Apprentice <Barleybrew Brew Vendor>
(@CGUID+0,23482,530,1,1,22395,0,-4016.6,-11833,0.106771,4.04165,300,0,0,2215,0,0,0,0,0),
-- Brewfest Reveler - Exodar
(@CGUID+1,24484,530,1,1,21843,86,-4004.32,-11859.4,0.177081,0.860784,300,0,0,2215,0,0,0,0,0),
(@CGUID+2,24484,530,1,1,21844,86,-4001.38,-11855.2,0.211436,4.18773,300,0,0,2215,0,0,0,0,0),
(@CGUID+3,24484,530,1,1,21843,86,-4010.47,-11852.8,0.118782,4.25763,300,0,0,2215,0,0,0,0,0),
(@CGUID+4,24484,530,1,1,21842,86,-4009.89,-11854.7,0.121793,3.64502,300,0,0,2215,0,0,0,0,0),
(@CGUID+5,24484,530,1,1,21844,86,-4012.09,-11839.5,0.131949,0.507355,300,0,0,2215,0,0,0,0,0),
(@CGUID+6,24484,530,1,1,21845,86,-4005.04,-11840.8,0.203372,2.26665,300,0,0,2215,0,0,0,0,0),
(@CGUID+7,24484,530,1,1,21842,86,-4017.34,-11851.2,0.047381,1.00608,300,0,0,2215,0,0,0,0,0),
(@CGUID+8,24484,530,1,1,21845,86,-4013.17,-11842.1,0.114192,4.16731,300,0,0,2215,0,0,0,0,0),
(@CGUID+9,24484,530,1,1,21844,86,-4012.1,-11847.4,0.111304,2.65935,300,0,0,2215,0,0,0,0,0),
(@CGUID+10,24484,530,1,1,21843,86,-4017.5,-11845,0.0595054,5.9266,300,0,0,2215,0,0,0,0,0),
-- Brewfest Reveler - Eversong Woods
(@CGUID+11,24484,530,1,1,21841,86,9318.1,-7278.19,13.3383,0.709729,300,0,0,2215,0,0,0,0,0),
(@CGUID+12,24484,530,1,1,21838,86,9318.04,-7274.55,13.3571,5.13466,300,0,0,2215,0,0,0,0,0),
(@CGUID+13,24484,530,1,1,21840,86,9322.69,-7278.57,13.2085,3.03844,300,0,0,2215,0,0,0,0,0),
(@CGUID+14,24484,530,1,1,21839,86,9323.46,-7274.86,13.2653,3.31333,300,0,0,2215,0,0,0,0,0),
(@CGUID+15,24484,530,1,1,21840,86,9333.88,-7275.82,13.514,5.39384,300,0,0,2215,0,0,0,0,0),
(@CGUID+16,24484,530,1,1,21841,86,9335.93,-7281.15,13.695,2.03234,300,0,0,2215,0,0,0,0,0),
(@CGUID+17,24484,530,1,1,21838,86,9340.67,-7275.46,14.0555,4.97837,300,0,0,2215,0,0,0,0,0),
(@CGUID+18,24484,530,1,1,21839,86,9343.15,-7280.24,14.3778,2.35828,300,0,0,2215,0,0,0,0,0),
(@CGUID+19,24484,530,1,1,21840,86,9334.47,-7296.27,13.7759,3.58271,300,0,0,2215,0,0,0,0,0),
(@CGUID+20,24484,530,1,1,21839,86,9329.98,-7295.05,13.7486,5.6758,300,0,0,2215,0,0,0,0,0),
(@CGUID+21,24484,530,1,1,21841,86,9340.93,-7269.42,14.5058,0.837748,300,0,0,2215,0,0,0,0,0),
-- Troll Commoner
(@CGUID+22,19177,1,1,1,21876,0,1748.94,-4497.53,28.793,5.47104,300,0,0,42,0,0,0,0,0),
(@CGUID+23,19177,1,1,1,21877,0,1752.58,-4499.43,28.2911,2.89886,300,0,0,42,0,0,0,0,0),
-- Orc Commoner
(@CGUID+24,19175,1,1,1,21868,0,1609.47,-4323.21,2.33176,3.34811,300,0,0,42,0,0,0,0,0),
(@CGUID+25,19175,1,1,1,21869,0,1605.95,-4324.2,2.19915,0.0101724,300,0,0,42,0,0,0,0,0),
-- Gnome Commoner
(@CGUID+26,19172,0,1,1,21850,0,-4831.74,-1172.58,502.278,6.19592,2,0,0,42,0,0,3,0,0),
(@CGUID+27,19172,0,1,1,21853,0,-4829.88,-1173.25,502.277,2.49582,2,0,0,42,0,0,3,0,0),
-- Bok Dropcertain
(@CGUID+28,24527,1,1,1,0,0,795.14,-4522.59,6.31052,5.20636,300,0,0,1004,0,0,0,0,0),
-- Drohn's Distillery Apprentice
(@CGUID+29,24501,530,1,1,22491,0,9333.7,-7269.67,13.7715,4.52047,300,0,0,2215,0,0,0,0,0),
-- Gordok Brew Apprentice <Gordok Brew Vendor>
(@CGUID+30,23511,530,1,1,0,0,-4020.13,-11855.6,0.0061873,1.0273,300,0,0,2215,0,0,0,0,0),
(@CGUID+31,23511,530,1,1,0,0,9313.83,-7281.3,13.8523,0.903714,300,0,0,2215,0,0,0,0,0),
-- T'chali's Voodoo Brewery Apprentice <Voodoo Brew Vendor>
(@CGUID+32,23533,530,1,1,22493,0,9330.11,-7285.87,13.7137,1.37103,300,0,0,2215,0,0,0,0,0),
-- Thunderbrew Apprentice
(@CGUID+33,23510,530,1,1,0,0,-4021.3,-11842.9,0.0212859,5.9439,300,0,0,2215,0,0,0,0,0);

-- Make the above spawns only happen if Brewfest is active
DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+33;
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES
(@EVENT,@CGUID+0),(@EVENT,@CGUID+1),(@EVENT,@CGUID+2),(@EVENT,@CGUID+3),
(@EVENT,@CGUID+4),(@EVENT,@CGUID+5),(@EVENT,@CGUID+6),(@EVENT,@CGUID+7),
(@EVENT,@CGUID+8),(@EVENT,@CGUID+9),(@EVENT,@CGUID+10),(@EVENT,@CGUID+11),
(@EVENT,@CGUID+12),(@EVENT,@CGUID+13),(@EVENT,@CGUID+14),(@EVENT,@CGUID+15),
(@EVENT,@CGUID+16),(@EVENT,@CGUID+17),(@EVENT,@CGUID+18),(@EVENT,@CGUID+19),
(@EVENT,@CGUID+20),(@EVENT,@CGUID+21),(@EVENT,@CGUID+22),(@EVENT,@CGUID+23),
(@EVENT,@CGUID+24),(@EVENT,@CGUID+25),(@EVENT,@CGUID+26),(@EVENT,@CGUID+27),
(@EVENT,@CGUID+28),(@EVENT,@CGUID+29),(@EVENT,@CGUID+30),(@EVENT,@CGUID+31),
(@EVENT,@CGUID+32),(@EVENT,@CGUID+33);

DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+20;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
-- Exodar
(@OGUID+0,178666,530,1,1,-4015.97,-11829.2,0.146814,2.80549,0,0,0.985913,0.167262,300,0,1),
(@OGUID+1,178666,530,1,1,-4024.94,-11840.7,-0.0137537,4.17208,0,0,0.870173,-0.492747,300,0,1),
(@OGUID+2,186259,530,1,1,-4029.42,-11849.1,-0.0817791,3.05053,0,0,0.998964,0.0455147,300,0,1),
(@OGUID+3,186260,530,1,1,-4008.1,-11835.5,0.186614,1.27632,0,0,0.595718,0.803194,300,0,1),
(@OGUID+4,186257,530,1,1,-4016.1,-11859.2,0.0441619,4.26476,0,0,0.846413,-0.532527,300,0,1),
(@OGUID+5,186221,530,1,1,-4008.42,-11850.7,0.144533,2.04601,0,0,0.853677,0.520803,300,0,1),
(@OGUID+6,186717,530,1,1,-4008.29,-11857.1,0.135722,5.47893,0,0,0.391378,-0.92023,300,0,1),
(@OGUID+7,186717,530,1,1,-4002.56,-11851,0.205429,5.13728,0,0,0.542116,-0.840304,300,0,1),
-- Darnassus
(@OGUID+8,186717,1,1,1,9962.87,2218.32,1329.82,1.77101,0,0,0.774236,0.632897,300,0,1),
(@OGUID+9,186717,1,1,1,9963.64,2192.59,1328.52,4.74374,0,0,0.695937,-0.718103,300,0,1),
-- Eversong Woods
(@OGUID+10,178666,530,1,1,9333.24,-7265.71,13.7149,3.15074,0,0,0.99999,-0.00457361,300,0,1),
(@OGUID+11,178666,530,1,1,9330.88,-7289.79,13.7388,0.18586,0,0,0.0927961,0.995685,300,0,1),
(@OGUID+12,186717,530,1,1,9319.23,-7265.19,13.7578,2.02761,0,0,0.84885,0.528633,300,0,1),
(@OGUID+13,186717,530,1,1,9310.25,-7291.41,14.4908,2.53027,0,0,0.953648,0.300923,300,0,1),
(@OGUID+14,186221,530,1,1,9318.17,-7291.17,14.4236,0.649241,0,0,0.318949,0.947772,300,0,1),
(@OGUID+15,186257,530,1,1,9318.61,-7289.66,14.436,0.782759,0,0,0.381464,0.924384,300,0,1),
(@OGUID+16,186256,530,1,1,9341.19,-7288.21,14.3979,4.71368,0,0,0.70665,-0.707563,300,0,1),
(@OGUID+17,186255,530,1,1,9343.07,-7265.55,14.691,1.48569,0,0,0.676387,0.736546,300,0,1),
(@OGUID+18,180037,530,1,1,9316.77,-7283.36,13.7084,3.63768,0,0,0.969394,-0.24551,300,0,1),
(@OGUID+19,180037,530,1,1,9313.62,-7285.06,13.9541,3.38636,0,0,0.992521,-0.122077,300,0,1),
(@OGUID+20,180037,530,1,1,9308.97,-7280.39,14.447,5.40091,0,0,0.426971,-0.904265,300,0,1);

-- Make the above game objects only spawn if Brewfest is active
DELETE FROM `game_event_gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+20;
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(@EVENT,@OGUID+0),(@EVENT,@OGUID+1),(@EVENT,@OGUID+2),(@EVENT,@OGUID+3),
(@EVENT,@OGUID+4),(@EVENT,@OGUID+5),(@EVENT,@OGUID+6),(@EVENT,@OGUID+7),
(@EVENT,@OGUID+8),(@EVENT,@OGUID+9),(@EVENT,@OGUID+10),(@EVENT,@OGUID+11),
(@EVENT,@OGUID+12),(@EVENT,@OGUID+13),(@EVENT,@OGUID+14),(@EVENT,@OGUID+15),
(@EVENT,@OGUID+16),(@EVENT,@OGUID+17),(@EVENT,@OGUID+18),(@EVENT,@OGUID+19),
(@EVENT,@OGUID+20);

-- [Q] [H] Catch the Wild Wolpertinger!
-- Alliance version already had this
DELETE FROM `creature_involvedrelation` WHERE `id`=24657 AND `quest`=11431;
INSERT INTO `creature_involvedrelation` (`id`,`quest`) VALUES (24657,11431);
DELETE FROM `creature_questrelation` WHERE `id`=24657 AND `quest`=11431;
INSERT INTO `creature_questrelation` (`id`,`quest`) VALUES (24657,11431);

-- [Q] [A/H] Did Someone Say "Souvenir?" (removed in 2.4.3) & Say, There Wouldn't Happen to be a Souvenir This Year, Would There?
DELETE FROM `creature_questrelation` WHERE `quest` IN (11321,11413,12193,12194);
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (11321,11413,12193,12194);

-- [Q] [A/H] Save Brewfest! should have pre-req Welcome to Brewfest!
UPDATE `quest_template` SET `PrevQuestId`=11442 WHERE `id`=12318;
-- [Q] [A/H] Save Brewfest! - removed in 2.4.3
DELETE FROM `creature_involvedrelation` WHERE `quest`=12318;
DELETE FROM `creature_questrelation` WHERE `quest`=12318;

-- [Q] [A/H] Another Year, Another Souvenir.
DELETE FROM `creature_involvedrelation` WHERE `id` IN (24495,23710) AND `quest` IN (13931,13932);
INSERT INTO `creature_involvedrelation` (`id`,`quest`) VALUES
(24495,13931), -- Horde
(23710,13932); -- Alliance
DELETE FROM `creature_questrelation` WHERE `id` IN (24510,24468) AND `quest` IN (13931,13932);
INSERT INTO `creature_questrelation` (`id`,`quest`) VALUES
(24510,13931), -- Horde
(24468,13932); -- Alliance

-- [Q] [A] Direbrew's Dire Brew - removed PrevQuestId in 2010
-- Horde version already had this
UPDATE `quest_template` SET `PrevQuestId`=0 WHERE `id`=12491;

-- Misc.
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=23698; -- Drunken Brewfest Reveler
UPDATE `creature_template_addon` SET `auras`='43905' WHERE `entry`=23698; -- Drunken Brewfest Reveler
UPDATE `creature_template` SET `AIName`='' WHERE `entry`=23698; -- Drunken Brewfest Reveler
UPDATE `creature` SET `spawntimesecs`=450 WHERE `id`=24484; -- Brewfest Reveler had 12 hour respawntime ...

-- Send a mail on quest complete "Brew of the Month Club" - there is no wait time so we won't use RewMailDelaySecs
-- Alliance quest missed quest texts
SET @MAIL_A := 209;
SET @MAIL_H := 210;
UPDATE `quest_template` SET `RewardMailTemplateId`=0 WHERE `id`=12278; -- old "Brew of the Month Club" quests
UPDATE `quest_template` SET `RewardMailTemplateId`=0 WHERE `id`=12306; -- old "Brew of the Month Club" quests
UPDATE `quest_template` SET `RewardMailTemplateId`=@MAIL_A,`OfferRewardText`="Your paperwork looks to be in order. Welcome to the club, $N!$B$BYou can expect to get our mail at the start of every month. If you like what you got, stop by and we can sell you some more. This is the club that keeps on giving.",`RequestItemsText`="Do you have your membership forms filled out?" WHERE `id`=12420;
UPDATE `quest_template` SET `RewardMailTemplateId`=@MAIL_H WHERE `id`=12421;

-- Ray'ma and Larkin were also finishing quest no longer available within the game.
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (12278,12306); -- old "Brew of the Month Club" quests
DELETE FROM `creature_involvedrelation` WHERE `id`=27489 AND `quest`=12421;
INSERT INTO `creature_involvedrelation` (`id`,`quest`) VALUES (27489,12421);

-- The alliance vendors were selling wrong item - Ray'ma already had one but Blix was missing
DELETE FROM `npc_vendor` WHERE `item` IN (37571,37736,37599,37737);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(23710,0,37736,0,0,2276), -- Belbi Quikswitch
(27478,0,37736,0,0,2276), -- Larkin Thunderbrew
(27489,0,37737,0,0,2276), -- Ray'ma
(24495,0,37737,0,0,2276); -- Blix Fixwidget

-- Insert missing Pint-Sized Pink Pachyderm for 100 tokens
DELETE FROM `npc_vendor` WHERE `item`=46707;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(23710,0,46707,0,0,2275), -- Belbi Quikswitch
(27478,0,46707,0,0,2275), -- Larkin Thunderbrew
(24495,0,46707,0,0,2275), -- Blix Fixwidget
(27489,0,46707,0,0,2275); -- Ray'ma

-- Insert missing Brewfest Dress for 200 tokens
DELETE FROM `npc_vendor` WHERE `item`=33863;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(23710,0,33863,0,0,2276), -- Belbi Quikswitch
(27478,0,33863,0,0,2276), -- Larkin Thunderbrew
(24495,0,33863,0,0,2276), -- Blix Fixwidget
(27489,0,33863,0,0,2276); -- Ray'ma

-- Insert missing Brewfest Regalia for 200 tokens
DELETE FROM `npc_vendor` WHERE `item`=33862;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(23710,0,33862,0,0,2276), -- Belbi Quikswitch
(27478,0,33862,0,0,2276), -- Larkin Thunderbrew
(24495,0,33862,0,0,2276), -- Blix Fixwidget
(27489,0,33862,0,0,2276); -- Ray'ma

-- Insert missing Wolpertinger's Tankard
DELETE FROM `npc_vendor` WHERE `item`=32233;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(23710,0,32233,0,0,0), -- Belbi Quikswitch
(27478,0,32233,0,0,0), -- Larkin Thunderbrew
(24495,0,32233,0,0,0), -- Blix Fixwidget
(27489,0,32233,0,0,0); -- Ray'ma

-- Coren Direbrew Horde Loot fix by dele (closes #7297)
DELETE FROM `creature_loot_template` WHERE `entry`=23872 AND `item`=38281;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(23872, 38281, 100, 1, 2, 1, 1);

-- This One Time, When I Was Drunk... (12020) Alliance quest giver fix by nelegalno (closes #7823)
UPDATE `gameobject_questrelation` SET `id`=189989 WHERE `quest`=12020;


UPDATE `quest_template` SET `SourceSpellId`=43883 WHERE `id` IN (11407,11408,11293,11294);
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (4769,4772,4770,4774,4801,4802,4803,4804) AND `ScriptName`='SmartTrigger';
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(4769,'SmartTrigger'),
(4772,'SmartTrigger'),
(4770,'SmartTrigger'),
(4774,'SmartTrigger'),
(4801,'SmartTrigger'),
(4802,'SmartTrigger'),
(4803,'SmartTrigger'),
(4804,'SmartTrigger');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (4769,4772,4770,4774,4801,4802,4803,4804) AND `source_type`=2;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(4769,2,0,0,46,0,100,0,4769,0,0,0,33,24202,0,0,0,0,0,7,0,0,0,0,0,0,0,'SW Bank - on trigger - give killcredit'),
(4772,2,0,0,46,0,100,0,4772,0,0,0,33,24203,0,0,0,0,0,7,0,0,0,0,0,0,0,'SW Military Ward - on trigger - give killcredit'),
(4770,2,0,0,46,0,100,0,4770,0,0,0,33,24204,0,0,0,0,0,7,0,0,0,0,0,0,0,'SW Hall of Explorers - on trigger - give killcredit'),
(4774,2,0,0,46,0,100,0,4774,0,0,0,33,24205,0,0,0,0,0,7,0,0,0,0,0,0,0,'SW Mystic Ward - on trigger - give killcredit'),
(4801,2,0,0,46,0,100,0,4801,0,0,0,33,24202,0,0,0,0,0,7,0,0,0,0,0,0,0,'OG Auction House - on trigger - give killcredit'),
(4802,2,0,0,46,0,100,0,4802,0,0,0,33,24203,0,0,0,0,0,7,0,0,0,0,0,0,0,'OG Valley of Honor - on trigger - give killcredit'),
(4803,2,0,0,46,0,100,0,4803,0,0,0,33,24204,0,0,0,0,0,7,0,0,0,0,0,0,0,'OG Valley of Wisdom - on trigger - give killcredit'),
(4804,2,0,0,46,0,100,0,4804,0,0,0,33,24205,0,0,0,0,0,7,0,0,0,0,0,0,0,'OG Valley of Spirits - on trigger - give killcredit');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry` IN (4769,4772,4770,4774,4801,4802,4803,4804) AND `SourceId`=2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,4769,2,0,1,0,43883,0,0,0,0,'',''),
(22,1,4772,2,0,1,0,43883,0,0,0,0,'',''),
(22,1,4770,2,0,1,0,43883,0,0,0,0,'',''),
(22,1,4774,2,0,1,0,43883,0,0,0,0,'',''),
(22,1,4801,2,0,1,0,43883,0,0,0,0,'',''),
(22,1,4802,2,0,1,0,43883,0,0,0,0,'',''),
(22,1,4803,2,0,1,0,43883,0,0,0,0,'',''),
(22,1,4804,2,0,1,0,43883,0,0,0,0,'','');

SET @GUID := NULL; -- set by TDB team

DELETE FROM `creature` WHERE `id`=27489;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@GUID,27489,1,1,1,0,0,1473.72,-4207.13,43.1862,4.53175,600,0,0,7500,1,0,0,0,0);

-- Brewfest Coren Direbrew
/* TODO
-- Faltante Loot. Chekear.
*/
DELETE FROM `gameobject` WHERE `id` = 188498; -- Spawn Mole- machine Consola en la entrada de Brd
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(188498, 230, 1, 1, 1133.59, -462.347, -103.659, 5.75403, 0, 0, 0.261501, -0.965203, 300, 0, 1);
DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` = 188498); -- Anadido al eventlink correspondiente.
INSERT INTO `game_event_gameobject` (`guid`, `eventEntry`) VALUES
((SELECT `guid` FROM `gameobject` WHERE `id` = 188498), 24);
DELETE FROM `creature` WHERE `id` IN (23872); -- Spawn Coren Direbrew
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(23872, 230, 1, 1, 0, 0, 890.38, -135.366, -49.7525, 5.19012, 300, 0, 0, 302400, 0, 0, 0, 0, 0);
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (23872));
INSERT INTO `game_event_creature` (`guid`, `eventEntry`) VALUES
((SELECT `guid` FROM `creature` WHERE `id` = 23872), 24);
-- Spawn de creatures por guid asignadas a correcto evento ID.
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (23872,26719,27584,28329)); -- Anadido al eventlink correspondiente.
-- Anadido ScriptNames
UPDATE `creature_template` SET `ScriptName` = 'npc_coren_direbrew', `flags_extra` = 0, `dmg_multiplier` = 20, `lootid` = 23872 WHERE `entry` = 23872;
UPDATE `creature_template` SET `ScriptName` = 'npc_brewmaiden' WHERE `entry` IN (26822,26764);
UPDATE `creature_template` SET `faction_A` = 736, `faction_H` = 736 WHERE `entry` = 26776;
UPDATE `gameobject_template` SET `ScriptName` = 'go_mole_machine_console' WHERE `entry` = 188498;
-- Limite Targets
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (47344, 47310);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES
(13, 47310, 18, 1, 0),-- Cast Disarm AOE
(13, 47344, 18, 1, 26764), 
(13, 47344, 18, 1, 26822);  
-- Spell scripts
DELETE FROM `spell_scripts` WHERE `id`=47344;
INSERT INTO `spell_scripts` (`id`, `effIndex`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`)
VALUES
(47344, 0, 0, 15, 47339, 3, 0, 0, 0, 0, 0); -- cast back "Send Second Mug" on "Request Second Mug" hit
-- Spell Auras Drinking Brew
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 47371;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(47371, -47376, 1, 'Remove Visual Buff'),
(47371, -47331, 1, 'Remove Has Brew Aura');
-- Inmunidades
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (23872,26822,26764);

UPDATE `quest_template` SET `SpecialFlags`=9 WHERE `Id`=25483;
UPDATE `creature_template` SET `npcflag`=3 WHERE `entry`=23872;

-- Tapper Swindlekeg SAI
SET @ENTRY := 24711;
SET @SPELL_DRINK := 50552;
SET @SPELL_FINISH := 50555;
SET @QUEST_DIRE_BREW := 12492;
UPDATE `creature_template` SET `AIName`='SmartAI',`flags_extra`=`flags_extra`|2 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,20,0,100,0,@QUEST_DIRE_BREW,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tapper Swindlekeg - On Quest Complete - Run Script"),
(@ENTRY*100+0,9,0,0,0,0,100,0,1500,1500,0,0,1,0,0,0,0,0,0,0,7,0,0,0,0,0,0,"Tapper Swindlekeg - On Script - Say Line 0"),
(@ENTRY*100+0,9,1,0,0,0,100,0,0,0,0,0,11,@SPELL_DRINK,0,0,0,0,0,0,1,0,0,0,0,0,0,"Tapper Swindlekeg - On Script - Cast Questgiver Tries Dire Brew"),
(@ENTRY*100+0,9,2,0,0,0,100,0,8500,8500,0,0,11,@SPELL_FINISH,0,0,0,0,0,0,1,0,0,0,0,0,0,"Tapper Swindlekeg - On Script - Cast Questgiver Finishes Drinking"),
(@ENTRY*100+0,9,3,0,0,0,100,0,0,0,0,0,28,@SPELL_DRINK,0,0,0,0,0,0,1,0,0,0,0,0,0,"Tapper Swindlekeg - On Script - Remove Growth Aura"),
(@ENTRY*100+0,9,4,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,0,7,0,0,0,0,0,0,"Tapper Swindlekeg - On Script - Say Line 1"),
(@ENTRY*100+0,9,5,0,0,0,100,0,3500,3500,0,0,1,2,0,0,0,0,0,0,7,0,0,0,0,0,0,"Tapper Swindlekeg - On Script - Say Line 2"),
(@ENTRY*100+0,9,6,0,0,0,100,0,3500,3500,0,0,1,3,0,0,0,0,0,0,7,0,0,0,0,0,0,"Tapper Swindlekeg - On Script - Say Line 3");
-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Well time's money, and time's wasting! Let's have that drink...",12,0,100,1,0,0,"Tapper Swindlekeg"),
(@ENTRY,1,0,"Wow! This really greases the steamplugs!",12,0,100,1,0,0,"Tapper Swindlekeg"),
(@ENTRY,2,0,"If I were an honest goblin, I'd say this was the best beer of the festival...",12,0,100,1,0,0,"Tapper Swindlekeg"),
(@ENTRY,3,0,"Too bad Coren's dead. If I could buy that brew from him and resell it - watered down and rebottled under my own label, of course - I'd be rich!",12,0,100,1,0,0,"Tapper Swindlekeg"),
-- These three are used in areatrigger script
(@ENTRY,4,0,"Hey there, and welcome to Brewfest. Come in and have a drink or three!",12,1,100,3,0,0,"Tapper Swindlekeg"),
(@ENTRY,4,1,"What's up, friend? Welcome to the Brewfest Grounds! Now go buy some drinks!",12,1,100,3,0,0,"Tapper Swindlekeg"),
(@ENTRY,4,2,"Hey hey, it's another $r! Welcome to my annual Brewfest celebration... now go feast and drink some!",12,1,100,3,0,0,"Tapper Swindlekeg");

-- Ipfelkofer Ironkeg SAI
SET @ENTRY := 24710;
SET @SPELL_DRINK := 50552;
SET @SPELL_FINISH := 50555;
SET @QUEST_DIRE_BREW := 11441;
UPDATE `creature_template` SET `AIName`='SmartAI',`flags_extra`=`flags_extra`|2 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,20,0,100,0,@QUEST_DIRE_BREW,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ipfelkofer Ironkeg - On Quest Complete - Run Script"),
(@ENTRY*100+0,9,0,0,0,0,100,0,1500,1500,0,0,1,0,0,0,0,0,0,0,7,0,0,0,0,0,0,"Ipfelkofer Ironkeg - On Script - Say Line 0"),
(@ENTRY*100+0,9,1,0,0,0,100,0,0,0,0,0,11,@SPELL_DRINK,0,0,0,0,0,0,1,0,0,0,0,0,0,"Ipfelkofer Ironkeg - On Script - Cast Questgiver Tries Dire Brew"),
(@ENTRY*100+0,9,2,0,0,0,100,0,8500,8500,0,0,11,@SPELL_FINISH,0,0,0,0,0,0,1,0,0,0,0,0,0,"Ipfelkofer Ironkeg - On Script - Cast Questgiver Finishes Drinking"),
(@ENTRY*100+0,9,3,0,0,0,100,0,0,0,0,0,28,@SPELL_DRINK,0,0,0,0,0,0,1,0,0,0,0,0,0,"Ipfelkofer Ironkeg - On Script - Remove Growth Aura"),
(@ENTRY*100+0,9,4,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,0,7,0,0,0,0,0,0,"Ipfelkofer Ironkeg - On Script - Say Line 1"),
(@ENTRY*100+0,9,5,0,0,0,100,0,3500,3500,0,0,1,2,0,0,0,0,0,0,7,0,0,0,0,0,0,"Ipfelkofer Ironkeg - On Script - Say Line 2"),
(@ENTRY*100+0,9,6,0,0,0,100,0,3500,3500,0,0,1,3,0,0,0,0,0,0,7,0,0,0,0,0,0,"Ipfelkofer Ironkeg - On Script - Say Line 3");

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Right! Let's try this so-called dire brew...",12,0,100,0,0,0,"Ipfelkofer Ironkeg"),
(@ENTRY,1,0,"Bronzebeard's beard! What a drink!",12,0,100,0,0,0,"Ipfelkofer Ironkeg"),
(@ENTRY,2,0,"$N, this beer... well, it might be the best of Brewfest!",12,0,100,15,0,0,"Ipfelkofer Ironkeg"),
(@ENTRY,3,0,"It is a shame Coren's Dire Brew can't quench more thirsting throats! It's blasphemy, I know, but I envy those Dark Iron dwarves!",12,0,100,274,0,0,"Ipfelkofer Ironkeg"),
-- These three are used in areatrigger script
(@ENTRY,4,0,"Ho there, and welcome to Brewfest!",12,7,100,3,0,0,"Ipfelkofer Ironkeg"),
(@ENTRY,4,1,"Hello, friend! Welcome to the Brewfest Grounds!",12,7,100,3,0,0,"Ipfelkofer Ironkeg"),
(@ENTRY,4,2,"Hail, good $c! Welcome to Ironforge's annual Brewfest celebration!",12,7,100,3,0,0,"Ipfelkofer Ironkeg");

-- Areatrigger scriptname
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (4829,4820);
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(4829,'at_brewfest'), -- Durotar
(4820,'at_brewfest'); -- Dun Morogh

-- [Q] Catch the Wild Wolpertinger!
-- [Q] [A/H] Catch the Wild Wolpertinger!
-- Conditions already exist with proper ErrorTextId
-- Wild Wolpertinger SAI
SET @ENTRY := 23487;
SET @SPELL_NET := 41621;
SET @SPELL_CREATE_ITEM := 41622;
UPDATE `creature_template` SET `AIName`='SmartAI',`unit_flags`=`unit_flags`|512 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,2,8,0,100,0,@SPELL_NET,0,0,0,11,@SPELL_CREATE_ITEM,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wild Wolpertinger - On Spellhit - Cast Create Stunned Wolpertinger Item"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,41,4000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wild Wolpertinger - On Spellhit - Forced Despawn");
-- Fix conejos para que la red no sea casteada en el player (by Kayserzero)
UPDATE `creature_template` SET `unit_flags`=640 WHERE entry=23487;

-- [Q] [A/H] Chug and Chuck
-- The chance of this event to occur is low according to videos!
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- Self-Turning and Oscillating Utility Target SAI
SET @ENTRY := 24108;
SET @SPELL_THROW_MUG := 42300;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,0,@SPELL_THROW_MUG,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Self-Turning and Oscillating Utility Target - On Spellhit - Quest Credit");
-- Condition for spell
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (13) AND `SourceEntry` IN (42436,42300);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,42436,0,18,1,0,0,0,'',"Spell Drink! targets player"),
(13,0,42300,0,18,24108,0,0,0,'',"Spell Brewfest - Throw Mug targets Self-Turning and Oscillating Utility Target");
-- Spell Drink! should make you throw a mug
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=42436 AND `spell_effect`=42300;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(42436,42300,1,'Drink! will now also cast Brewfest - Throw Mug');
-- [Q] [A/H] Pink Elekks On Parade
-- We were able to kill them for credits.. (faction).
-- Tirisfal Pink Elekk SAI
SET @ENTRY := 23530;
SET @SPELL_ELEKK_DISPERSION := 44654;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=35,`faction_H`=35 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,0,@SPELL_ELEKK_DISPERSION,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Tirisfal Pink Elekk - On Spellhit - Quest Credit"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tirisfal Pink Elekk - On Spellhit - Forced Despawn");
-- Eversong Pink Elekk SAI
SET @ENTRY := 23531;
SET @SPELL_ELEKK_DISPERSION := 44654;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=35,`faction_H`=35 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,0,@SPELL_ELEKK_DISPERSION,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Eversong Pink Elekk - On Spellhit - Quest Credit"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Eversong Pink Elekk - On Spellhit - Forced Despawn");
-- Mulgore Pink Elekk SAI
SET @ENTRY := 23529;
SET @SPELL_ELEKK_DISPERSION := 44654;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=35,`faction_H`=35 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,0,@SPELL_ELEKK_DISPERSION,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Mulgore Pink Elekk - On Spellhit - Quest Credit"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mulgore Pink Elekk - On Spellhit - Forced Despawn");
-- Elwynn Pink Elekk SAI
SET @ENTRY := 23507;
SET @SPELL_ELEKK_DISPERSION := 44654;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=35,`faction_H`=35 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,0,@SPELL_ELEKK_DISPERSION,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Elwynn Pink Elekk - On Spellhit - Quest Credit"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Elwynn Pink Elekk - On Spellhit - Forced Despawn");
-- Teldrassil Pink Elekk SAI
SET @ENTRY := 23527;
SET @SPELL_ELEKK_DISPERSION := 44654;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=35,`faction_H`=35 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,0,@SPELL_ELEKK_DISPERSION,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Teldrassil Pink Elekk - On Spellhit - Quest Credit"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Teldrassil Pink Elekk - On Spellhit - Forced Despawn");
-- Azuremyst Pink Elekk SAI
SET @ENTRY := 23528;
SET @SPELL_ELEKK_DISPERSION := 44654;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=35,`faction_H`=35 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,0,@SPELL_ELEKK_DISPERSION,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Azuremyst Pink Elekk - On Spellhit - Quest Credit"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Azuremyst Pink Elekk - On Spellhit - Forced Despawn");
-- Gordok Brew Barker SAI
SET @ENTRY := 23685;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,22,0,100,0,101,5000,5000,0,11,@SPELL_DRINK,2,0,0,0,0,7,0,0,0,0,0,0,0,"Gordok Brew Barker - Emote Receive 'Wave' - Cast Create Complimentary Brewfest Sampler"),
(@ENTRY,0,1,0,1,0,100,0,30000,45000,180000,240000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Gordok Brew Barker - Out of Combat - Yell Line 0 (random)");
-- Text
DELETE FROM `script_texts` WHERE `entry` BETWEEN -717 AND -719;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"YOU TRY DA' BEST, NOW TRY DA' REST! OGRE BREW!",14,0,100,1,0,0,"Gordok Brew Barker"),
(@ENTRY,0,1,"HEY YOU! DRINK OGRE BREWS! MAKE YOU BIG AND STRONG!",14,0,100,1,0,0,"Gordok Brew Barker"),
(@ENTRY,0,2,"YOU WANT DRINK? WE GOT DRINK!",14,0,100,1,0,0,"Gordok Brew Barker"),
-- Dark Iron Attack
(@ENTRY,1,0,"SOMEONE TRY THIS SUPER BREW!",14,0,100,1,0,0,"Gordok Brew Barker");
-- Blix Fixwidget SAI
SET @ENTRY := 24495;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,22,0,100,0,101,5000,5000,0,11,@SPELL_DRINK,2,0,0,0,0,7,0,0,0,0,0,0,0,"Blix Fixwidget - Emote Receive 'Wave' - Cast Create Complimentary Brewfest Sampler"),
(@ENTRY,0,1,0,1,0,100,0,30000,45000,180000,240000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Blix Fixwidget - Out of Combat - Say Line 0 (random)");
-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Whoah! Walk by again girl!",12,0,100,1,0,0,"Blix Fixwidget"),
(@ENTRY,0,1,"Hey! Sweet cheeks, over here!",12,0,100,1,0,0,"Blix Fixwidget"),
(@ENTRY,0,2,"Hey, hey sweet thing! Looking good!",12,0,100,1,0,0,"Blix Fixwidget"),
(@ENTRY,0,3,"Hey, hey! Nice build you got there honey!",12,0,100,1,0,0,"Blix Fixwidget"),
(@ENTRY,0,4,"Yo! Big lady! You think you're big enough to handle me?",12,0,100,1,0,0,"Blix Fixwidget");
-- Drohn's Distillery Barker SAI
SET @ENTRY := 24492;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,22,0,100,0,101,5000,5000,0,11,@SPELL_DRINK,2,0,0,0,0,7,0,0,0,0,0,0,0,"Drohn's Distillery Barker - Emote Receive 'Wave' - Cast Create Complimentary Brewfest Sampler"),
(@ENTRY,0,1,0,1,0,100,0,30000,45000,180000,240000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Drohn's Distillery Barker - Out of Combat - Say Line 0 (random)");
-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Drohn's brew is the stuff legends are made of! Come taste the legend!",12,0,100,1,0,0,"Drohn's Distillery Barker"),
(@ENTRY,0,1,"We drink for the Horde! Do you drink for the Horde? Come show us at Drohn's Distillery!",12,0,100,1,0,0,"Drohn's Distillery Barker"),
(@ENTRY,0,2,"Hey you, the tall one... Want to put some hair on your chest? Drohn's Distillery can help you out!",12,0,100,1,0,0,"Drohn's Distillery Barker"),
(@ENTRY,0,3,"Drohn's Distillery has the best brew money can buy! They were voted 'Outstanding Brew' by Monthly Goblin Brew!",12,0,100,1,0,0,"Drohn's Distillery Barker"),
-- Dark Iron Attack
(@ENTRY,1,0,"Chug and chuck! Chug and chuck!",14,0,100,1,0,0,"Drohn's Distillery Barker"),
(@ENTRY,2,0,"Down the free brew and pelt the Guzzlers with your mug!",14,0,100,1,0,0,"Drohn's Distillery Barker"),
(@ENTRY,3,0,"SOMEONE TRY THIS SUPER BREW!",14,0,100,1,0,0,"Drohn's Distillery Barker");
-- T'chali's Voodoo Brewery Barker SAI
SET @ENTRY := 24493;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,22,0,100,0,101,5000,5000,0,11,@SPELL_DRINK,2,0,0,0,0,7,0,0,0,0,0,0,0,"T'chali's Voodoo Brewery Barker - Emote Receive 'Wave' - Cast Create Complimentary Brewfest Sampler"),
(@ENTRY,0,1,0,1,0,100,0,30000,45000,180000,240000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"T'chali's Voodoo Brewery Barker - Out of Combat - Say Line 0 (random)");
-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Drohn's brew is the stuff legends are made of! Come taste the legend!",12,0,100,1,0,0,"T'chali's Voodoo Brewery Barker"),
(@ENTRY,0,1,"We drink for the Horde! Do you drink for the Horde? Come show us at Drohn's Distillery!",12,0,100,1,0,0,"T'chali's Voodoo Brewery Barker"),
(@ENTRY,0,2,"Hey you, the tall one... Want to put some hair on your chest? Drohn's Distillery can help you out!",12,0,100,1,0,0,"T'chali's Voodoo Brewery Barker"),
(@ENTRY,0,3,"Drohn's Distillery has the best brew money can buy! They were voted 'Outstanding Brew' by Monthly Goblin Brew!",12,0,100,1,0,0,"T'chali's Voodoo Brewery Barker"),
-- Dark Iron Attack
(@ENTRY,1,0,"Chug and chuck! Chug and chuck!",14,0,100,1,0,0,"T'chali's Voodoo Brewery Barker"),
(@ENTRY,2,0,"Down the free brew and pelt the Guzzlers with your mug!",14,0,100,1,0,0,"T'chali's Voodoo Brewery Barker"),
(@ENTRY,3,0,"SOMEONE TRY THIS SUPER BREW!",14,0,100,1,0,0,"T'chali's Voodoo Brewery Barker");
-- Brewfest Reveler SAI
SET @ENTRY := 24484;
SET @SPELL_CREATE_MUG := 42518;
SET @SPELL_TOAST := 41586;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,22,0,100,0,101,5000,5000,0,11,@SPELL_CREATE_MUG,2,0,0,0,0,7,0,0,0,0,0,0,0,"Brewfest Reveler - Emote Receive 'Wave' - Cast Create Complimentary Brewfest Sampler"),
(@ENTRY,0,1,0,22,0,100,0,34,5000,5000,0,11,@SPELL_TOAST,2,0,0,0,0,7,0,0,0,0,0,0,0,"Brewfest Reveler - Emote Receive 'Dance' - Cast Brewfest Toast");
-- Condition for spell
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=42518;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,42518,0,18,1,0,0,0,'',"Spell Create Complimentary Brewfest Sampler targets players"),
(13,0,42518,0,26,33096,0,0,0,'',"Spell Create Complimentary Brewfest Sampler targets players");

-- Fix Quest Chug and chuck (A/H) and Bark for... (Q 11294,11408,11293,11407)
UPDATE `quest_template` SET `PrevQuestId`='11409' WHERE (`Id`='12194');
UPDATE `quest_template` SET `PrevQuestId`='12191' WHERE (`Id`='12192');
DELETE FROM  `spell_linked_spell` WHERE `spell_trigger` = 42436;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`)
VALUES ('42436','47173','0','Brewfest Sampler');
UPDATE `item_template` SET `ScriptName`='item_brewfest_ChugAndChuck' WHERE (`entry`='33096');
UPDATE `creature_template` SET `scale`='0.01',`AIName`='',`flags_extra`='0',`ScriptName`='npc_brewfest_trigger' WHERE `entry` in (24202, 24203, 24204, 24205);
UPDATE `quest_template` SET `PrevQuestId`='0' WHERE (`Id`='12193');

-- Ram Barrel Run Quest
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (-43880, 42994, 42993, 42992, 43310, 43332, -43332);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES 
('-43880','-42994','0','Remove brewfest speed buffs when player dismounted'),
('-43880','-42993','0','Remove brewfest speed buffs when player dismounted'),
('-43880','-42992','0','Remove brewfest speed buffs when player dismounted'),
('-43880','-42146','0','Remove brewfest speed buffs when player dismounted'),
('-43880','-43310','0','Remove brewfest speed buffs when player dismounted'),
('-43880','-43492','0','Remove brewfest speed buffs when player dismounted'),
('-43880','-43332','0','Remove brewfest speed buffs when player dismounted'),
('-43880','-43052','0','Remove brewfest speed buffs when player dismounted'),
('42994','-42993','0','Switch brewfest speed buffs'),
('42994','-42992','0','Switch brewfest speed buffs'),
('42994','-43310','0','Switch brewfest speed buffs'),
('42994','-43332','0','Switch brewfest speed buffs'),
('42993','-42994','0','Switch brewfest speed buffs'),
('42993','-42992','0','Switch brewfest speed buffs'),
('42993','-43310','0','Switch brewfest speed buffs'),
('42993','-43332','0','Switch brewfest speed buffs'),
('42992','-42993','0','Switch brewfest speed buffs'),
('42992','-42994','0','Switch brewfest speed buffs'),
('42992','-43310','0','Switch brewfest speed buffs'),
('42992','-43332','0','Switch brewfest speed buffs'),
('43310','-42993','0','Switch brewfest speed buffs'),
('43310','-42992','0','Switch brewfest speed buffs'),
('43310','-42994','0','Switch brewfest speed buffs'),
('43310','-43332','0','Switch brewfest speed buffs'),
('43332','-42993','0','Switch brewfest speed buffs'),
('43332','-42992','0','Switch brewfest speed buffs'),
('43332','-43310','0','Switch brewfest speed buffs'),
('43332','-42994','0','Switch brewfest speed buffs'),    
('-43332','43310','0','Switch brewfest speed buffs');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_brewfest_speed';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
('43332','spell_brewfest_speed'),
('43310','spell_brewfest_speed'),
('42992','spell_brewfest_speed'),
('42993','spell_brewfest_speed'),
('42994','spell_brewfest_speed');

UPDATE `item_template` SET `Duration`='240' WHERE (`entry`='33797');
UPDATE `creature_template` SET `scale`='0.01',`flags_extra`='0',`ScriptName`='npc_brewfest_apple_trigger' WHERE (`entry`='24337');
UPDATE `creature_template` SET `flags_extra`='0',`ScriptName`='npc_brewfest_keg_thrower' WHERE (`entry`='24364');
UPDATE `creature_template` SET `flags_extra`='0',`ScriptName`='npc_brewfest_keg_thrower' WHERE (`entry`='24527');
UPDATE `creature_template` SET `flags_extra`='0',`ScriptName`='npc_brewfest_keg_receiver' WHERE (`entry`='24468');
UPDATE `creature_template` SET `flags_extra`='0',`ScriptName`='npc_brewfest_keg_receiver' WHERE (`entry`='24510');
UPDATE `creature_template` SET `flags_extra`='0',`ScriptName`='npc_brewfest_ram_master' WHERE (`entry`='23558');
UPDATE `creature_template` SET `flags_extra`='0',`ScriptName`='npc_brewfest_ram_master' WHERE (`entry`='24497');

DELETE FROM `creature` WHERE `id` IN (24364,24527,24337);
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) 
VALUES 
('24364','0','1','1','0','0','-5608.76','-460.569','403.345','5.74527','300','0','0','1003','0','0'),
('24527','1','1','1','0','0','856.609','-4497.95','6.43272','0.0600562','300','0','0','1003','0','0');
INSERT INTO `creature` 
(`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`curhealth`)
VALUES 
(24337, 0, 1, 1, '-5667.41', '-476.651', '396.275', '-2.00713', 180, 42),
(24337, 0, 1, 1, '-5355.3', '-527.423', '391.493', '-2.3911', 180, 42),
(24337, 0, 1, 1, '-5189.16', '-482.752', '387.244', '-1.65806', 180, 42),
(24337, 1, 1, 1, '1290.86', '-4433.25', '27.1411', '2.05949', 180, 42),
(24337, 1, 1, 1, '1096.65', '-4427.11', '20.2013', '2.3911', 180, 42),
(24337, 1, 1, 1, '1004.55', '-4479.3', '10.9096', '-0.244346', 180, 42),
(24337, 0, 1, 1, '-5498.16', '-511.732', '397.462', '1.85111', 300, 42);
DELETE FROM `gameobject` WHERE `id` = 186331;
INSERT INTO gameobject
(`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`)
VALUES
(186331, 0, 1, 1, '-5667.41', '-476.651', '396.275', '-2.00713', 0, 0, '0.843391', '-0.5373', 180, 100, 1),
(186331, 0, 1, 1, '-5355.3', '-527.423', '391.493', '-2.3911', 0, 0, '0.930418', '-0.366501', 180, 100, 1),
(186331, 0, 1, 1, '-5189.16', '-482.752', '387.244', '-1.65806', 0, 0, '0.737277', '-0.67559', 180, 100, 1),
(186331, 1, 1, 1, '1290.86', '-4433.25', '27.1411', '2.05949', 0, 0, '0.857167', '0.515038', 180, 100, 1),
(186331, 1, 1, 1, '1096.65', '-4427.11', '20.2013', '2.3911', 0, 0, '0.930418', '0.366501', 180, 100, 1),
(186331, 1, 1, 1, '1004.55', '-4479.3', '10.9096', '-0.244346', 0, 0, '0.121869', '-0.992546', 180, 100, 1),
(186331, 0, 1, 1, '-5498.16', '-511.732', '397.462', '1.85111', 0, 0, '0.798954', '0.601392', 300, 0, 1);

UPDATE `item_template` SET `ScriptName`='item_brewfest_ram_reins' WHERE (`entry`='33306');

-- Spell de quest faltante Rental Racing Ram al tomar la quest para quedar montado
UPDATE `quest_template` SET `SourceSpellId`=43883 WHERE `Id` IN (11293,11294,11407,11408,11409,11122,11412);

-- Cambio de Modelo(Uno invisible) y asociacion de script al npc Barker Bunny
UPDATE `creature_template` SET `modelid1`=11686, `ScriptName`='npc_brewfest_trigger' WHERE `entry`=24202;
UPDATE `creature_template` SET `modelid1`=11686, `ScriptName`='npc_brewfest_trigger' WHERE `entry`=24203;
UPDATE `creature_template` SET `modelid1`=11686, `ScriptName`='npc_brewfest_trigger' WHERE `entry`=24204;
UPDATE `creature_template` SET `modelid1`=11686, `ScriptName`='npc_brewfest_trigger' WHERE `entry`=24205;

-- Agrega bunnys para las quest de Barker
SET @GUID := 2420200;
DELETE FROM `creature` WHERE `guid` IN (@GUID,@GUID+1,@GUID+2,@GUID+3,@GUID+4,@GUID+5,@GUID+6,@GUID+7);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(@GUID,24202,0,1,1,0,0,-4912.327148,-948.907410,501.493164,5.5,600,0,0,1,0,0),
(@GUID+1,24203,0,1,1,0,0,-4969.666016,-1208.679565,501.77864,3.8,600,0,0,1,0,0),
(@GUID+2,24204,0,1,1,0,0,-4690.384766,-1235.180908,501.659607,2.3,600,0,0,1,0,0),
(@GUID+3,24205,0,1,1,0,0,-4661.659668,-955.10980,500.377472,3.8,600,0,0,1,0,0),
(@GUID+4,24202,1,1,1,0,0,1647.637939,-4409.758789,17.244448,5.06,600,0,0,1,0,0),
(@GUID+5,24203,1,1,1,0,0,1947.653931,-4686.246094,25.314669,4.2,600,0,0,1,0,0),
(@GUID+6,24204,1,1,1,0,0,1932.215698,-4298.459473,24.518383,4.99,600,0,0,1,0,0),
(@GUID+7,24205,1,1,1,0,0,1578.210327,-4199.839355,41.619968,5.1,600,0,0,1,0,0);
DELETE FROM `game_event_creature` WHERE `guid` IN (@GUID,@GUID+1,@GUID+2,@GUID+3,@GUID+4,@GUID+5,@GUID+6,@GUID+7);
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES
(24, @GUID),
(24, @GUID+1),
(24, @GUID+2),
(24, @GUID+3),
(24, @GUID+4),
(24, @GUID+5),
(24, @GUID+6),
(24, @GUID+7);

-- Agrega Dark Iron Mole Machine Wreckage (Noblizzlike pero da una daily)
SET @GUID := 189989;
DELETE FROM `gameobject` WHERE `guid` IN (@GUID,@GUID+1);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@GUID,189989,0,1,1,-5154.36,-609.284,398.452,2.13369,0,0,0.875682,0.482887,300,0,1),
(@GUID+1,189989,1,1,1,1198.66,-4297.37,21.3811,4.92821,0,0,0.626838,-0.77915,300,0,1);
DELETE FROM `game_event_gameobject` WHERE `guid` IN (@GUID,@GUID+1);
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(24, @GUID),
(24, @GUID+1);

-- Borrado de Dark Iron Plans (Quest removida)
DELETE FROM `gameobject` WHERE `guid` IN (11140);
DELETE FROM `gameobject` WHERE `guid` IN (18015);

-- respawn Core Direbrew
UPDATE `creature` SET `spawntimesecs` = 604800 WHERE `id`  = 23972;


/*Dark Iron Attack
Only show gossip X if player has aura 43156 after attack

They come every 30 minutes for 5 minutes.
1) During that time you should drink the freeze booze on the table (at least 1) while aiming at a Dark Dwarf. You'll throw the mug at them, and an NPC will throw you a new mug.
2) Map this to a key and spam it while turning left and right.
3) If they destroy all the kegs, you will not be able to loot the gear.
4) You can loot the gear once every 12 hours.
5) The gear will be available from :05 to :20 and :35 to :50 (eg 1:05 is when they stop attacking, it'll be there for 15 minutes)
6) This is worth 10 tokens
7) The "whirlwind" effect is picked up from big mugs that randomly appear on the ground
8) Stand on tables and you're less likely to be hit by a DD (serious knockback)


Spawn NPCs inside the kegs for keg arrow marker spell 42761

209 alliance mail
210 horde mail

23808 - [DND] Brewfest Keg Move to Target
24766 - [DND] Brewfest Face Me Bunny
24109 - [DND] Brewfest Target Dummy Move To Target
23894 - [DND] Brewfest Dark Iron Spawn Bunny
23703 - [DND] Brewfest Dark Iron Event Generator

188508 - Dark Iron Mole Machine (Minion Summoner)

42676 - Holiday - Brewfest - Dark Iron Knockback Aura


SCRIPT SUMMARY
We are scripting them on GUID because there's only one event generator which we use for both factions.
We are making the Event Generator run a script every 30 minutes. On this script it will summon plenty of Spawn Bunnies. All of those Spawn Bunnies will summon their Mole Machine after a specified time and also die and despawn 
on cast (TEMPSUMMON_TIMED_OR_DEAD_DESPAWN) to prevent there being cast more than once per bunny.  The reason the Dark Iron Guzzlers are always facing correctly is because we are setting orientation of every spawn dummy the 
exact same way, together with target_type 1 and target_0 it will always walk outside the 'door' of the Mole Machine

Brewers only throw in phase 1
*/
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Misc.
DELETE FROM `gameobject` WHERE `id`=186881; -- Dark Iron Dwarf Plans should be summoned by event
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=24109; -- [DND] Brewfest Target Dummy Move To Target
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|260 WHERE `entry` IN (23702,23700,23706,24373,24372); -- Thunderbrew/Barleybrew/Gordok/T'chalis's/Drohn's Festive Keg

-- Make the Event Generator spawns only spawn if Brewfest is active Brewfest
DELETE FROM `game_event_creature` WHERE `eventEntry`=24 AND `guid` IN (10045953);
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES
(24,10045953);

-- Add aura 'Brewfest - Dark Iron Attack - Keg Marker' to Thunderbrew/Barleybrew/Gordok/T'chalis's/Drohn's Festive Keg
DELETE FROM `creature_template_addon` WHERE `entry` IN (23702,23700,23706,24373,24372);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(23702,0,0,0,0,'42761'),
(23700,0,0,0,0,'42761'),
(23706,0,0,0,0,'42761'),
(24373,0,0,0,0,'42761'),
(24372,0,0,0,0,'42761');

-- Add Dark Iron Guzzler's equipment template (taken from sniff)
DELETE FROM `creature_equip_template` WHERE `entry`=2477 AND `itemEntry1`=33125;
INSERT INTO `creature_equip_template` (`entry`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES
(2477,33125,0,0);

-- Spawn [DND] Brewfest Dark Iron Event Generator
DELETE FROM `creature` WHERE `id`=23703 AND `guid`=10045953;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(10045953,23703,0,1,1,0,0,-5152.3,-603.529,398.356,2.50732,300,0,0,37800,0,0,0,0,0);

-- Drunken Master's triggered spells conditions
DELETE FROM `conditions` WHERE `SourceEntry` IN (42695,42794) AND `ConditionValue2` IN (23709);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,42695,0,18,1,23709,0,0,'',"Spell Holiday - Brewfest - Dark Iron Knock-down Power-up can only be cast at Dark Iron Guzzler"),
(13,0,42794,0,18,1,23709,0,0,'',"Spell Holiday - Brewfest - Random Mug Fling can only be cast at Dark Iron Guzzler");

-- Insert missing object template for spell Drunken Master's - it's a trap and these do not come from sniffs, so WDBVerified on 0.
DELETE FROM `gameobject_template` WHERE `entry`=186471;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`faction`,`flags`,`size`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`data0`,`data1`,`data2`,`data3`,`data4`,`data5`,`data6`,`data7`,`data8`,`data9`,`data10`,`data11`,`data12`,`data13`,`data14`,`data15`,`data16`,`data17`,`data18`,`data19`,`data20`,`data21`,`data22`,`data23`,`AIName`,`ScriptName`,`WDBVerified`) VALUES
(186471,6,0,'Super Brew Stein','','','',14,0,3,0,0,0,0,0,0,0,0,5,42696,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',0);

-- [DND] Brewfest Dark Iron Event Generator SAI
SET @ENTRY := 23703;
UPDATE `creature_template` SET `AIName`='SmartAI',`flags_extra`=`flags_extra`|128 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-10045953,@ENTRY*100,@ENTRY*100+1);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(-10045953,0,0,0,1,0,100,0,10000,10000,1800000,1800000,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"[DND] Brewfest Dark Iron Event Generator - Out of Combat - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,14000,14000,0,0,12,24536,1,300000000,0,0,0,1,0,0,0,0,0,0,0,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn Dark Iron Herald"),
(@ENTRY*100,9,1,0,0,0,100,0,14000,14000,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5168.79,-597.261,398.101,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"), -- Time this to give the Brewfest Revelers some time to run away
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5154.99,-589.22,397.346,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5168.34,-585.515,397.688,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5160.86,-606.37,398.063,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,5,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5163.08,-592.054,398.022,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,6,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5160.24,-579.148,397.18,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,7,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5172.88,-576.9,397.339,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,8,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5180.1,-583.465,397.775,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,9,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5176.84,-592.674,397.622,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,10,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5172.06,-606.161,397.352,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,11,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5162.5,-614.447,397.741,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,12,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5153.05,-618.085,398.125,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,13,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5148.92,-607.028,398.537,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,14,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5155.28,-598.89,398.092,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,15,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5146.97,-591.708,397.372,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,16,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5136.8,-598.046,397.426,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,17,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5162.125000,-599.126953,398.169250,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,18,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5155.227051,-611.064087,398.384796,5.58,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,19,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5172.685547,-617.705200,397.190582,0.80,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,20,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5165.557129,-602.531067,397.959229,2.48,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,21,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5162.540039,-596.897278,398.152252,5.58,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,22,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5171.027832,-590.153503,397.964874,0.80,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,23,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5177.630371,-600.892029,397.344421,2.48,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,24,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5175.105957,-585.409302,397.801575,5.58,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,25,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5160.901367,-585.973755,397.494049,0.80,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,26,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5149.727051,-598.186523,398.000702,2.48,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,27,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5140.413574,-606.157715,398.110840,0.80,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,28,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5148.443359,-613.181458,398.464478,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,29,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5139.434570,-612.224487,398.017578,5.58,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,30,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5160.227051,-622.226868,397.487183,2.53,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,31,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5165.484863,-608.644226,397.621552,3.85,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,32,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5154.422852,-605.168152,398.364655,1.23,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,33,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5156.091309,-594.039612,397.730194,0.32,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,34,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5151.526855,-593.310730,397.529968,0.32,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,35,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5143.669922,-603.026917,398.192719,0.80,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,36,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5142.348633,-595.296265,397.526245,3.32,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,37,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5154.107910,-582.890503,397.179108,6.32,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,38,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5166.127930,-578.236206,397.194489,4.12,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,39,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5182.114746,-589.290283,397.433838,3.21,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,40,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5173.672363,-598.698364,397.764160,5.21,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,41,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5170.576660,-612.272156,397.254028,1.12,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,42,0,0,0,100,0,0,0,0,0,12,23894,1,300000000,0,0,0,8,0,0,0,-5157.810059,-615.534058,398.061340,3.21,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn [DND] Brewfest Dark Iron Spawn Bunny"),
(@ENTRY*100,9,43,0,0,0,100,0,0,0,0,0,12,23702,1,300000000,0,0,0,8,0,0,0,-5159.85,-632.055,397.179,1.46772,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn Thunderbrew Festive Keg"),
(@ENTRY*100,9,44,0,0,0,100,0,0,0,0,0,12,23706,1,300000000,0,0,0,8,0,0,0,-5146.283691,-576.265930,397.176514,0.09009,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn Gordok Festive Keg"),
(@ENTRY*100,9,45,0,0,0,100,0,0,0,0,0,12,23700,1,300000000,0,0,0,8,0,0,0,-5186.539551,-599.753662,397.176453,0.024872,"[DND] Brewfest Dark Iron Event Generator - On Script - Spawn Barleybrew Festive Keg"),
(@ENTRY*100,9,46,0,0,0,100,0,0,0,0,0,45,1,1,0,0,0,0,11,24484,50,0,0,0,0,0,"[DND] Brewfest Dark Iron Event Generator - On Script - Set Data Brewfest Reveler"),
-- These are used to spawn Stein Traps
(@ENTRY*100,9,47,0,0,0,100,0,59000,79000,90000,90000,45,2,2,0,0,0,0,11,23685,50,0,0,0,0,0,"[DND] Brewfest Dark Iron Event Generator - On Script - Set Data Gordok Brew Baker"),
(@ENTRY*100,9,48,0,0,0,100,0,10000,29000,90000,90000,45,3,3,0,0,0,0,11,23683,50,0,0,0,0,0,"[DND] Brewfest Dark Iron Event Generator - On Script - Set Data Maeve Barleybrew"),
(@ENTRY*100,9,49,0,0,0,100,0,3000,11000,90000,90000,45,4,4,0,0,0,0,11,23684,50,0,0,0,0,0,"[DND] Brewfest Dark Iron Event Generator - On Script - Set Data Ita Thunderbrew");





-- (@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"[DND] Brewfest Dark Iron Event Generator - On Script - "),

-- [DND] Brewfest Dark Iron Spawn Bunny SAI
SET @ENTRY := 23894;
SET @SPELL_MOLE_MACHINE_SPAWN := 73071;
UPDATE `creature_template` SET `AIName`='SmartAI',`flags_extra`=`flags_extra`|128 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,1,0,100,1,5000,285000,270000,270000,11,@SPELL_MOLE_MACHINE_SPAWN,2,0,0,0,0,1,0,0,0,0,0,0,0,"[DND] Brewfest Dark Iron Spawn Bunny - Out of Combat - Cast Mole Machine Spawn"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"[DND] Brewfest Dark Iron Spawn Bunny - On Mole Machine Spawn - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,5000,5000,0,0,12,23709,1,300000000,0,0,0,1,0,0,0,0,0,0,3.85,"[DND] Brewfest Dark Iron Spawn Bunny - On Script - Spawn Dark Iron Guzzler"),
(@ENTRY*100,9,1,0,0,0,100,0,4000,4000,0,0,12,23709,1,300000000,0,0,0,1,0,0,0,0,0,0,5.58,"[DND] Brewfest Dark Iron Spawn Bunny - On Script - Spawn Dark Iron Guzzler"),
(@ENTRY*100,9,2,0,0,0,100,0,3000,3000,0,0,12,23709,1,300000000,0,0,0,1,0,0,0,0,0,0,0.80,"[DND] Brewfest Dark Iron Spawn Bunny - On Script - Spawn Dark Iron Guzzler"),
(@ENTRY*100,9,3,0,0,0,100,0,2000,2000,0,0,12,23709,1,300000000,0,0,0,1,0,0,0,0,0,0,2.48,"[DND] Brewfest Dark Iron Spawn Bunny - On Script - Spawn Dark Iron Guzzler");






-- Dark Iron Guzzler SAI
-- www.youtube.com/watch?v=4neherfsaEE&feature=related
-- 0:47 - attack keg
SET @ENTRY := 23709;
-- SET @SPELL_THROW_MUG := xx;
SET @SPELL_KNOCKBACK := 42299;
SET @SPELL_ATTACK_KEG := 42393;
UPDATE `creature_template` SET `AIName`='SmartAI',`unit_flags`=`unit_flags`|33024,`equipment_id`=2477 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN @ENTRY*100+0 AND @ENTRY*100+8;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,5000,9000,11000,11,@SPELL_KNOCKBACK,1,0,0,0,0,2,0,0,0,0,0,0,0,"Dark Iron Guzzler - In Combat - Cast Brewfest - Dark Iron Knockback"),
-- (@ENTRY,0,1,0,8,0,100,0,@SPELL_THROW_MUG,0,0,0,45,5,5,0,0,0,0,19,x,0,0,0,0,0,0,"Dark Iron Guzzler - On Spellhit - Set Data Ita Thunderbrew"),
(@ENTRY,0,1,0,1,0,20,1,5000,50000,50000,50000,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Guzzler - Out of Combat - Say Line 0 (random)"), -- We gotta time this REALLY randomly (5k-50k)
(@ENTRY,0,2,0,54,0,100,1,0,0,0,0,46,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Guzzler - On Spawn - Move Forward"),
(@ENTRY,0,3,0,1,0,100,0,1000,1000,7000,11000,88,@ENTRY*100+0,@ENTRY*100+8,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Guzzler - On Spawn - Run Random Range Script"),
(@ENTRY*100+0,9,0,0,0,0,100,0,0,0,0,0,53,0,@ENTRY,0,0,0,0,2,1,0,0,0,0,0,0,"Dark Iron Guzzler - On Script 0 - Start WP 0"),
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,53,0,@ENTRY+1,0,0,0,0,2,1,0,0,0,0,0,0,"Dark Iron Guzzler - On Script 1 - Start WP 1"),
(@ENTRY*100+2,9,0,0,0,0,100,0,0,0,0,0,53,0,@ENTRY+2,0,0,0,0,2,1,0,0,0,0,0,0,"Dark Iron Guzzler - On Script 2 - Start WP 2"),
(@ENTRY*100+3,9,0,0,0,0,100,0,0,0,0,0,53,0,@ENTRY+3,0,0,0,0,2,1,0,0,0,0,0,0,"Dark Iron Guzzler - On Script 3 - Start WP 3"),
(@ENTRY*100+4,9,0,0,0,0,100,0,0,0,0,0,53,0,@ENTRY+4,0,0,0,0,2,1,0,0,0,0,0,0,"Dark Iron Guzzler - On Script 4 - Start WP 4"),
(@ENTRY*100+5,9,0,0,0,0,100,0,0,0,0,0,53,0,@ENTRY+5,0,0,0,0,2,1,0,0,0,0,0,0,"Dark Iron Guzzler - On Script 5 - Start WP 5"),
(@ENTRY*100+6,9,0,0,0,0,100,0,0,0,0,0,53,0,@ENTRY+6,0,0,0,0,2,1,0,0,0,0,0,0,"Dark Iron Guzzler - On Script 6 - Start WP 6"),
(@ENTRY*100+7,9,0,0,0,0,100,0,0,0,0,0,53,0,@ENTRY+7,0,0,0,0,2,1,0,0,0,0,0,0,"Dark Iron Guzzler - On Script 7 - Start WP 7"),
(@ENTRY*100+8,9,0,0,0,0,100,0,0,0,0,0,53,0,@ENTRY+8,0,0,0,0,2,1,0,0,0,0,0,0,"Dark Iron Guzzler - On Script 8 - Start WP 8");


-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Did someone say 'Free Brew'?",12,0,100,0,0,0,"Dark Iron Guzzler"),
(@ENTRY,0,1,"DRINK! BRAWL! DRINK! BRAWL!",12,0,100,0,0,0,"Dark Iron Guzzler"),
(@ENTRY,0,2,"No one expects the Dark Iron Dwarves!",12,0,100,0,0,0,"Dark Iron Guzzler"),
(@ENTRY,0,3,"Drink it all boys!",12,0,100,0,0,0,"Dark Iron Guzzler"),
(@ENTRY,0,4,"It's not a party without some crashers!",12,0,100,0,0,0,"Dark Iron Guzzler");

-- Waypoints
DELETE FROM `waypoints` WHERE `entry` IN (@ENTRY+0,@ENTRY+1,@ENTRY+2,@ENTRY+3,@ENTRY+4,@ENTRY+5,@ENTRY+6,@ENTRY+7,@ENTRY+8);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ENTRY+0,1,-5146.489258,-605.807678,398.446594,'Dark Iron Guzzler WP 0'),
(@ENTRY+0,2,-5158.338379,-588.102844,397.464233,'Dark Iron Guzzler WP 0'),
(@ENTRY+0,3,-5175.240723,-587.899719,397.828186,'Dark Iron Guzzler WP 0'),
(@ENTRY+0,4,-5182.802734,-598.817505,397.188171,'Dark Iron Guzzler WP 0'),
(@ENTRY+1,1,-5160.037598,-628.135010,397.238342,'Dark Iron Guzzler WP 1'),
(@ENTRY+1,2,-5147.790527,-624.794861,397.458496,'Dark Iron Guzzler WP 1'),
(@ENTRY+1,3,-5146.746582,-580.459961,397.177063,'Dark Iron Guzzler WP 1'),
(@ENTRY+1,4,-5169.381348,-588.704102,397.934326,'Dark Iron Guzzler WP 1'),
(@ENTRY+2,1,-5148.005371,-580.531311,397.177277,'Dark Iron Guzzler WP 2'),
(@ENTRY+2,2,-5154.990234,-608.568787,398.423004,'Dark Iron Guzzler WP 2'),
(@ENTRY+2,3,-5140.381348,-608.689941,398.133859,'Dark Iron Guzzler WP 2'),
(@ENTRY+2,4,-5160.680176,-597.021606,398.129120,'Dark Iron Guzzler WP 2'),
(@ENTRY+3,1,-5140.218750,-595.395020,397.449127,'Dark Iron Guzzler WP 3'),
(@ENTRY+3,2,-5139.114258,-616.757080,397.802094,'Dark Iron Guzzler WP 3'),
(@ENTRY+3,3,-5164.573730,-614.278748,397.572937,'Dark Iron Guzzler WP 3'),
(@ENTRY+3,4,-5162.012695,-599.030029,398.166107,'Dark Iron Guzzler WP 3'),
(@ENTRY+3,5,-5182.972656,-599.895813,397.184326,'Dark Iron Guzzler WP 3'),
(@ENTRY+4,1,-5172.705566,-618.836182,397.180695,'Dark Iron Guzzler WP 4'),
(@ENTRY+4,2,-5175.108398,-600.439087,397.553497,'Dark Iron Guzzler WP 4'),
(@ENTRY+4,3,-5157.900879,-578.498596,397.177094,'Dark Iron Guzzler WP 4'),
(@ENTRY+4,4,-5141.636719,-589.796387,397.236328,'Dark Iron Guzzler WP 4'),
(@ENTRY+5,1,-5170.463379,-607.621582,397.349915,'Dark Iron Guzzler WP 5'),
(@ENTRY+5,2,-5182.373535,-601.089172,397.179413,'Dark Iron Guzzler WP 5'),
(@ENTRY+5,3,-5161.325195,-628.776978,397.210480,'Dark Iron Guzzler WP 5'),
(@ENTRY+5,4,-5140.576172,-594.936035,397.439728,'Dark Iron Guzzler WP 5'),
(@ENTRY+6,1,-5146.001953,-580.146606,397.176392,'Dark Iron Guzzler WP 6'),
(@ENTRY+6,2,-5165.176270,-593.882263,398.167328,'Dark Iron Guzzler WP 6'),
(@ENTRY+6,3,-5168.957031,-612.063538,397.331970,'Dark Iron Guzzler WP 6'),
(@ENTRY+6,4,-5143.728516,-617.111938,398.086945,'Dark Iron Guzzler WP 6'),
(@ENTRY+6,5,-5140.344238,-601.234619,397.896271,'Dark Iron Guzzler WP 6'),
(@ENTRY+7,1,-5168.468750,-623.256653,397.194763,'Dark Iron Guzzler WP 7'),
(@ENTRY+7,2,-5161.566406,-628.660950,397.211334,'Dark Iron Guzzler WP 7'), -- Thunderbrew
(@ENTRY+7,3,-5149.291016,-623.285828,397.648651,'Dark Iron Guzzler WP 7'),
(@ENTRY+7,4,-5138.262695,-602.349854,397.771912,'Dark Iron Guzzler WP 7'),
(@ENTRY+7,5,-5146.134766,-579.840759,397.177277,'Dark Iron Guzzler WP 7'), -- Gordok
(@ENTRY+8,1,-5137.287109,-593.654053,397.267273,'Dark Iron Guzzler WP 8'),
(@ENTRY+8,2,-5157.076660,-628.726929,397.259186,'Dark Iron Guzzler WP 8'), -- Thunderbrew
(@ENTRY+8,3,-5183.316406,-602.313110,397.177277,'Dark Iron Guzzler WP 8'); -- Barleybrew


-- Dark Iron Herald SAI
-- Shauren told me to use 0 because the counter is also bugged on retail atm :P
SET @ENTRY := 24536;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,1,11000,11000,20000,20000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Dark Iron Herald - On Spawn - Yell Line 0"),
(@ENTRY,0,1,0,1,0,100,0,30000,45000,60000,80000,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Dark Iron Herald - Out of Combat - Yell Line 1 (random)");

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"No one expects the Dark Iron dwarves!",14,0,100,0,0,0,"Dark Iron Herald"),
(@ENTRY,1,0,"We'll drink yer stout and lager,$BDrain all the pints and kegs!$BWe'll drink and brawl and brawl and drink,$B'til we can't feel our legs!",12,0,100,0,0,0,"Dark Iron Herald"),
(@ENTRY,1,1,"So lift a mug to Coren,$BAnd Hurley Blackbreath too!$BThis drink is weak, without much kick,$BBut oi! At least it's brew!",12,0,100,0,0,0,"Dark Iron Herald"),
(@ENTRY,1,2,"And when the brew's all missin'$BTa Shadowforge we'll hop,$BA bitter toast ta Ragnaros...$B... but bring him not a drop!",12,0,100,0,0,0,"Dark Iron Herald"),
(@ENTRY,1,3,"Oh, we're from Blackrock Mountain,$BWe've come ta drink yer brew!$BDark Iron dwarves, they do not lie,$BAnd so yeh know it's true!",12,0,100,0,0,0,"Dark Iron Herald"),
(@ENTRY,1,4,"Yeh will not try our bitter,$BYeh will not serve our ale!$BBut have Brewfest without our lot?$BJust try it, and ye'll fail!",12,0,100,0,0,0,"Dark Iron Herald"),
(@ENTRY,2,0,"We did it boys! Now back to the Grim Guzzler and we'll drink to the 0 that were injured!!",14,0,100,0,0,0,"Dark Iron Herald"),
(@ENTRY,2,1,"RETREAT! We've taken a beating and had 0 casualties! We can't keep taking these losses! FALL BACK!",14,0,100,0,0,0,"Dark Iron Herald");

-- Brewfest Reveler SAI
SET @ENTRY := 24484;
SET @SPELL_THROW_MUG := 50696;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY) AND `id` IN (3,4,5,6); -- We are adding new lines so don't remove complete SAI
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,3,0,58,0,100,0,3,@ENTRY,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On WP 3 - Despawn"),
(@ENTRY,0,4,5,38,0,100,0,1,1,0,0,53,1,@ENTRY,0,0,0,2,1,0,0,0,0,0,0,0,"Brewfest Reveler - On Data Set 1 1 - Start WP"),
(@ENTRY,0,5,6,61,0,10,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On Data Set 1 1 - Say Line 0 (random)"), -- Very low chance it seems
(@ENTRY,0,6,0,61,0,60,0,0,0,0,0,11,@SPELL_THROW_MUG,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On Data Set 1 1 - Cast Throw Mug"); -- Low chance it seems
-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Dark Iron dwarves!",12,0,100,0,0,0,"Brewfest Reveler"),
(@ENTRY,0,1,"Run! It's the Dark Iron dwarves!",12,0,100,0,0,0,"Brewfest Reveler"),
(@ENTRY,0,2,"They're after the beer!",12,0,100,0,0,0,"Brewfest Reveler"),
(@ENTRY,0,3,"Someone has to save the beer!",12,0,100,0,0,0,"Brewfest Reveler"),
(@ENTRY,0,4,"If you value your beer, run for it!",12,0,100,0,0,0,"Brewfest Reveler");

-- Waypoints
DELETE FROM `waypoints` WHERE `entry`=@ENTRY;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ENTRY,1,-5184.680176,-562.372009,397.260010,'Brewfest Reveler'),
(@ENTRY,2,-5192.152832,-547.358459,397.177094,'Brewfest Reveler'),
(@ENTRY,3,-5198.825684,-530.586243,392.940155,'Brewfest Reveler');




-- Gordok Brew Barker SAI
SET @ENTRY := 23685;
SET @SPELL_DRINK := 42518;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,22,0,100,0,101,5000,5000,0,11,@SPELL_DRINK,2,0,0,0,0,7,0,0,0,0,0,0,0,"Gordok Brew Barker - Emote Receive 'Wave' - Cast Create Complimentary Brewfest Sampler"),
(@ENTRY,0,1,0,1,0,100,0,30000,45000,180000,240000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Gordok Brew Barker - Out of Combat - Yell Line 0 (random)"),
(@ENTRY,0,2,3,38,0,100,0,2,2,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gordok Brew Barker - On Data Set - Yell Line 1"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,50,186478,15000,0,0,0,0,8,0,0,0,-5149.791992,-590.198792,397.323730,4.39,"Gordok Brew Barker - On Data Set 1 1 - Summon Super Brew Stein"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,50,186471,15000,0,0,0,0,8,0,0,0,-5149.791992,-590.198792,397.323730,4.39,"Gordok Brew Barker - On Data Set 1 1 - Summon Super Brew Stein Trap");

-- Text
DELETE FROM `script_texts` WHERE `entry` BETWEEN -717 AND -719;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"YOU TRY DA' BEST, NOW TRY DA' REST! OGRE BREW!",14,0,100,1,0,0,"Gordok Brew Barker"),
(@ENTRY,0,1,"HEY YOU! DRINK OGRE BREWS! MAKE YOU BIG AND STRONG!",14,0,100,1,0,0,"Gordok Brew Barker"),
(@ENTRY,0,2,"YOU WANT DRINK? WE GOT DRINK!",14,0,100,1,0,0,"Gordok Brew Barker"),
(@ENTRY,1,0,"SOMEONE TRY THIS SUPER BREW!",14,0,100,0,0,0,"Gordok Brew Barker");



-- Maeve Barleybrew SAI
SET @ENTRY := 23683;
SET @SPELL_DRINK := 42518;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,22,0,100,0,101,5000,5000,0,11,@SPELL_DRINK,2,0,0,0,0,7,0,0,0,0,0,0,0,"Maeve Barleybrew - Emote Receive 'Wave' - Cast Create Complimentary Brewfest Sampler"),
(@ENTRY,0,1,0,1,0,100,0,30000,45000,180000,240000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Maeve Barleybrew - Out of Combat - Yell Line 0 (random)"),
(@ENTRY,0,2,3,38,0,100,0,3,3,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Maeve Barleybrew - On Data Set - Yell Line 1"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,50,186478,15000,0,0,0,0,8,0,0,0,-5161.600586,-611.307861,397.917419,2.39,"Maeve Barleybrew - On Data Set 1 1 - Summon Super Brew Stein"),
(@ENTRY,0,4,5,61,0,100,0,0,0,0,0,50,186471,15000,0,0,0,0,8,0,0,0,-5161.600586,-611.307861,397.917419,2.39,"Maeve Barleybrew - On Data Set 1 1 - Summon Super Brew Stein Trap"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Maeve Barleybrew - On Data Set - Yell Line 2 (random)");

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Come try our Barleybrew Dark!",12,0,100,1,0,0,"Maeve Barleybrew"),
(@ENTRY,0,1,"Barleybrew, finest brewery in Azeroth!",12,0,100,1,0,0,"Maeve Barleybrew"),
(@ENTRY,0,2,"The Barleybrews have always been leaders in brewery innovation. Check out our newest creation, Barleybrew Clear!",12,0,100,1,0,0,"Maeve Barleybrew"),
(@ENTRY,1,0,"SOMEONE TRY THIS SUPER BREW!",14,0,100,0,0,0,"Maeve Barleybrew"),
(@ENTRY,2,0,"Chug and chuck! Chug and chuck!",12,0,100,1,0,0,"Maeve Barleybrew"),
(@ENTRY,2,1,"Down the free brew and pelt the Guzzlers with your mug!",12,0,100,1,0,0,"Maeve Barleybrew");



-- Ita Thunderbrew SAI
SET @ENTRY := 23684;
SET @SPELL_DRINK := 42518;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,22,0,100,0,101,5000,5000,0,11,@SPELL_DRINK,2,0,0,0,0,7,0,0,0,0,0,0,0,"Ita Thunderbrew - Emote Receive 'Wave' - Cast Create Complimentary Brewfest Sampler"),
(@ENTRY,0,1,0,1,0,100,0,30000,45000,180000,240000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Ita Thunderbrew - Out of Combat - Yell Line 0 (random)"),
(@ENTRY,0,2,3,38,0,100,0,3,3,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ita Thunderbrew - On Data Set - Yell Line 1"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,50,186478,15000,0,0,0,0,8,0,0,0,-5143.592285,-611.210510,398.339081,4.39,"Ita Thunderbrew - On Data Set 1 1 - Summon Super Brew Stein"),
(@ENTRY,0,4,5,61,0,100,0,0,0,0,0,50,186471,15000,0,0,0,0,8,0,0,0,-5149.791992,-590.198792,397.323730,4.39,"Ita Thunderbrew - On Data Set 1 1 - Summon Super Brew Stein Trap"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ita Thunderbrew - On Data Set - Yell Line 2 (random)");

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Thunderbrew, finest brewery in all the realms.",12,0,100,1,0,0,"Ita Thunderbrew"),
(@ENTRY,0,1,"THUNDER! THUNDER! THUNDER! THUNDERBREW, HO!",12,0,100,1,0,0,"Ita Thunderbrew"),
(@ENTRY,0,2,"You look like you could use a cold one. Thunderbrew's got ya covered!",12,0,100,1,0,0,"Ita Thunderbrew"),
(@ENTRY,1,0,"SOMEONE TRY THIS SUPER BREW!",14,0,100,0,0,0,"Ita Thunderbrew"),
(@ENTRY,2,0,"Chug and chuck! Chug and chuck!",12,0,100,1,0,0,"Ita Thunderbrew"),
(@ENTRY,2,1,"Down the free brew and pelt the Guzzlers with your mug!",12,0,100,1,0,0,"Ita Thunderbrew");

-- Quest 12491 y 12492 no tienen prerequisito en el 2010
UPDATE `quest_template` SET `PrevQuestId`=0 WHERE `Id`IN (12491,12492);

-- Fix Vendedores Blix Fixwidget y Ray'ma Horda
-- Fix Vendedores Belbi Quikswitch y Larkin Thunderbrew Alianza
DELETE FROM `npc_vendor` WHERE `entry` IN (24495,27489,23710,27478);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`ExtendedCost`) VALUES
(24495,1,33968,2274),
(24495,11,34008,2275),
(24495,12,39477,2424),
(24495,13,46707,2275),
(24495,14,33927,2275),
(24495,15,37750,2398),
(24495,16,37816,2399),
-- (24495,17,32233,0), Only appears on EU realms
(24495,2,33864,2274),
(24495,3,33967,2274),
(24495,4,33969,2274),
(24495,5,33863,2276),
(24495,6,33966,2275),
(24495,7,33862,2276),
(24495,8,33868,2275),
(24495,9,37599,2276),
(27489,1,33968,2274),
(27489,11,34008,2275),
(27489,12,39477,2424),
(27489,13,46707,2275),
(27489,14,33927,2275),
(27489,15,37750,2398),
(27489,16,37816,2399),
-- (27489,17,32233,0), Only appears on EU realms
(27489,2,33864,2274),
(27489,3,33967,2274),
(27489,4,33969,2274),
(27489,5,33863,2276),
(27489,6,33966,2275),
(27489,7,33862,2276),
(27489,8,33868,2275),
(27489,9,37599,2276),
(23710,1,33968,2274),
(23710,11,33047,2275),
(23710,12,39476,2424),
(23710,13,46707,2275),
(23710,14,33927,2275),
(23710,15,37750,2398),
(23710,16,37816,2399),
-- (23710,17,32233,0), Only appears on EU realms
(23710,2,33864,2274),
(23710,3,33967,2274),
(23710,4,33969,2274),
(23710,5,33863,2276),
(23710,6,33966,2275),
(23710,7,33862,2276),
(23710,8,33868,2275),
(23710,9,37736,2276),
(27478,1,33968,2274),
(27478,11,33047,2275),
(27478,12,39476,2424),
(27478,13,46707,2275),
(27478,14,33927,2275),
(27478,15,37750,2398),
(27478,16,37816,2399),
-- (27478,17,32233,0), Only appears on EU realms
(27478,2,33864,2274),
(27478,3,33967,2274),
(27478,4,33969,2274),
(27478,5,33863,2276),
(27478,6,33966,2275),
(27478,7,33862,2276),
(27478,8,33868,2275),
(27478,9,37736,2276);

-- Add la quest Catch the Wild Wolpertinger! al Npc Horda
-- Fix Quest Say, There Wouldn't Happen to be a Souvenir This Year, Would There? Alianza
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (11431, 12193);
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES
(24657, 11431),
(23710, 12193);
DELETE FROM `creature_questrelation` WHERE `quest` IN (11431);
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES
(24657, 11431);

SET @GUID := xxxx; -- Set by TDB team (4)
SET @POOL := xxxx; -- Set by TDB team (1)

DELETE FROM `gameobject` WHERE `id`=202083;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
-- http://pastebin.com/bhr50Ypv , https://www.youtube.com/watch?v=c1Dz_-ycIuU#t=160s
(@GUID+0, 202083, 0, 1, 1, -2944.07, -3276.32, 62.2180, 3.32798, 0, 0, 0.995661, -0.093059, 18000, 100, 1),
-- https://www.youtube.com/watch?v=c1Dz_-ycIuU#t=124s
(@GUID+1, 202083, 0, 1, 1, -3000.93, -3329.01, 64.9771, 4.10851, 0, 0, 0.885393, -0.464843, 18000, 100, 1),
-- https://www.youtube.com/watch?v=yWSvwdNHspY#t=30s , https://www.youtube.com/watch?v=c1Dz_-ycIuU#t=95s
(@GUID+2, 202083, 0, 1, 1, -3020.76, -3245.81, 58.8009, 5.38478, 0, 0, 0.434249, -0.900793, 18000, 100, 1),
-- https://www.youtube.com/watch?v=f0rCteF0Ras#t=200s , https://www.youtube.com/watch?v=yWSvwdNHspY#t=30s
(@GUID+3, 202083, 0, 1, 1, -2992.36, -3188.19, 55.1982, 3.01524, 0, 0, 0.998005, 0.0631367, 18000, 100, 1);

DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(@POOL,1,"Razormaw Matriarch's Nest (202083)");

DELETE FROM `pool_gameobject` WHERE `guid` IN (@GUID+0,@GUID+1,@GUID+2,@GUID+3);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(@GUID+0,@POOL,25,"Razormaw Matriarch's Nest (202083) P1"),
(@GUID+1,@POOL,25,"Razormaw Matriarch's Nest (202083) P2"),
(@GUID+2,@POOL,25,"Razormaw Matriarch's Nest (202083) P3"),
(@GUID+3,@POOL,25,"Razormaw Matriarch's Nest (202083) P4");

-- Twilight of the Dawn Runner (9437) quest fix by nelegalno
UPDATE `smart_scripts` SET `event_type`=62, `event_param1`=7371, `comment`='Ithania - On gossip select - run timed action list' WHERE (`entryorguid`=17119 AND `source_type`=0 AND `id`=0);
UPDATE `creature_template` SET `gossip_menu_id` = 7371 WHERE `entry` = 17119;

DELETE FROM `gossip_menu` WHERE `entry`=7371 AND `text_id`=8808;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES(7371,8808);

DELETE FROM `gossip_menu_option` WHERE `menu_id`=7371 AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(7371,0,0,'Balandar sent me to get you out of here and pick up his cargo. He is waiting for you in the Brackenwall.',1,1,0,0,0,0,NULL);

DELETE FROM `spell_proc_event` WHERE `entry` IN (71865,71868);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(71865, 0, 0, 0, 0, 0, 0x44000, 0, 0, 0, 0),
(71868, 0, 0, 0, 0, 0, 0x44000, 0, 0, 0, 0);

- Definitions
SET @QUEST1 := 7581; -- The Prison's Bindings (http://old.wowhead.com/quest=7581)
SET @QUEST2 := 7582; -- The Prison's Casing (http://old.wowhead.com/quest=7582)
SET @QUEST3 := 7583; -- Suppression (http://old.wowhead.com/quest=7583)
-- Query
UPDATE `quest_template` SET `NextQuestIdChain`=@QUEST2 WHERE `Id`=@QUEST1;
UPDATE `quest_template` SET `PrevQuestId`=@QUEST1, `NextQuestIdChain`=@QUEST3 WHERE `Id`=@QUEST2;
UPDATE `quest_template` SET `PrevQuestId`=@QUEST2 WHERE `Id`=@QUEST3;

SET @GUID := NULL; -- set by TDB team

DELETE FROM `gameobject` WHERE `guid`=@GUID;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID, 1684, 1, 1, 1, 1524.929, -4371.182, 17.94367, 1.62046, 0, 0, 0, 1, 300, 100, 1);

DELETE FROM `spell_proc_event` WHERE `entry` = 28305;
INSERT INTO `spell_proc_event` VALUES (28305, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0);

DELETE FROM `spell_proc_event` WHERE `entry`=16164;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(16164, 0x1C, 0x0B, 0x98101417, 0x80043000, 0x00002004, 0x00010000, 0x00000002, 0, 100, 0);


-- Molten Core + Ruins of Ahn'Qiraj + Blackwing Lair + Zul'Gurub + Temple of Ahn'Qiraj Boss Respawn Fix author armano2 closes #5883
UPDATE `creature` SET `spawntimesecs` = 604800 WHERE `Id` IN (12118,11982,12259,12057,12264,12056,11988,12098);
UPDATE `creature` SET `spawntimesecs` = 259200 WHERE `Id` IN (15348,15341,15340,15370,15369,15339);

-- Fix Fertile Spores Drop Chance authore exodius Closes #7727
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= 35 WHERE `item`=24449;

-- Fix quest Gammothra the tormentor author gacko Closes #7770
UPDATE `creature_template` SET `minlevel`=71,`maxlevel`=71,`faction_A`=14,`faction_H`=14 WHERE `entry`=25790;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=25789;
DELETE FROM `smart_scripts` WHERE `entryorguid`=25789 AND `source_type`=0;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=25789;
INSERT INTO `smart_scripts`(`entryorguid`,`event_type`,`event_param1`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(25789,8,46012,36,25790,1,'Gammothra the Tormentor - On spell hit - Update entry to Weakened Gammothra');

-- Disable Unfinished Gordok Business (1318) replaced with Disable Unfinished Gordok Business (7703) fix by nelegalno Closes #7819
DELETE FROM `disables` WHERE `sourceType`=1 AND `entry`=1318;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(1,1318,0,'','','Unfinished Gordok Business replaced by 7703');

-- Fix Plague Siphon ability (74074) in Lich King encounter in instance Icecrown Citadel, may only target LK (36597) author elron103 Closes #7729
DELETE FROM `conditions` WHERE `SourceEntry` = 74074 AND `SourceTypeOrReferenceId` = 13;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(13, 1, 74074, 0, 0, 31, 0, 3, 36597, 0, 0, 0, '', 'Plague Siphon may only target The Lich King');

-- Gurubashi Arena Grand Master (396) achievement fix by nelegalno Closes #7699
-- Short John Mithril (14508) gossip
UPDATE `creature_template` SET `gossip_menu_id` = 5921 WHERE `entry` = 14508;
DELETE FROM `gossip_menu` WHERE `entry`=5921 AND `text_id`=7074;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES(5921,7074);
-- Arena Master (18706) loot fix
UPDATE `item_template` SET `flagsCustom`=flagsCustom|2 WHERE `entry`=18706;
-- Arena Grandmaster (7838) quest is repeatable (players can get 2x Arena Grand Master trinkets)
-- https://www.youtube.com/watch?v=fkJ3vrwC4q4&feature=player_detailpage#t=170s
UPDATE `quest_template` SET `SpecialFlags` = 1 WHERE `Id` = 7838;

SET @CGUID:= xxxxx;
--  Spawn Dark Ranger Marrah author Vincent-Michael Closes #7681
DELETE FROM `creature` WHERE `id` = @ENTRY;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(@CGUID, 24137, 574, 3, 1, 183.8515, -76.50119, 15.84287, 3.455082, 7200, 0, 0);
DELETE FROM `creature_template_addon` WHERE `entry` = @ENTRY;
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(24137, 0, 0x20000, 0x1, '34189');

-- Update DisenchantID's to proper values for items from Satchel of Helpful Goods (51999) author Exodius Closes #7572
UPDATE `item_template` SET `DisenchantID`=41 WHERE `entry` IN (51964, 51968, 51978, 51994);

-- X Marks... Your Doom! (11166) quest fix by nelegalno Closes #7528
-- For some reason the script doesn't trigger if `flags_extra` = 128 is set
UPDATE `creature_template` SET `unit_flags` = 33554432, `flags_extra` = 0 WHERE `entry` = 23815;

-- Whitebark's Memory (10166) fix despawn timer author nelegalno Closes #7521
-- TODO: Find fix for one-shot kill by high level players
UPDATE `smart_scripts` SET `event_param1`=60000, `event_param2`=60000, `event_param3`=60000, `event_param4`=60000, `comment`="Whitebark's Spirit - after 60sec OOC - despawn" WHERE `entryorguid`=19456 AND `id`=5;

-- Armor of Darkness (12979) conditions fix by nelegalno Closes #7506
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=29380 AND `SourceEntry`=42203;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1,29380,42203,0,0,9,0,12978,0,0,0,0,'',"Dark Armor Plate drops if Facing the Storm taken"),
(1,29380,42203,0,1,8,0,12978,0,0,0,0,'',"Dark Armor Plate drops if Facing the Storm rewarded"),
(1,29380,42203,0,1,8,0,12979,0,0,1,0,'',"Dark Armor Plate drops if Armor of Darkness isn't rewarded");

-- Remove duplicate of Swirling Maelstrom (180669) GO author nelegalno Closes #7498
UPDATE `gameobject` SET `id` = 180669 WHERE `guid` = 99900;
DELETE FROM `gameobject_template` WHERE `entry`=300057;

-- The Scepter of the Shifting Sands quest chain fix by nelegalno based on http://www.wowwiki.com/The_Scepter_of_the_Shifting_Sands_quest_chain Closes #7473
-- What Tomorrow Brings > Only One May Rise
UPDATE `quest_template` SET `NextQuestIdChain` = 8288 WHERE `Id` = 8286;
-- A Pawn on the Eternal Board > The Charge of the Dragonflights
UPDATE `quest_template` SET `NextQuestIdChain` = 8555 WHERE `Id` = 8519;
-- The Nightmare's Corruption > The Nightmare Manifests
UPDATE `quest_template` SET `NextQuestIdChain` = 8736 WHERE `Id` = 8735;
-- Azuregos's Magical Ledger > Translating the Ledger
UPDATE `quest_template` SET `NextQuestIdChain` = 8576 WHERE `Id` = 8575;

-- Hive'Zora Scout Report (8534), Hive'Regal Scout Report (8738) and Hive'Ashi Scout Report (8739) quests fix by Raszagal (Inspired by Justiciar's fix drom #3311) 
-- TODO: Get sniffs for gossip_menu_option placeholder texts
-- Closes #3311 and Closes #7453

SET @GOSSIP1 := 6690; -- need confirmation
SET @GOSSIP2 := 6691; -- need confirmation
SET @GOSSIP3 := 6692; -- need confirmation
SET @NPC1 := 15609;
SET @NPC2 := 15610;
SET @NPC3 := 15611;

-- Update Cenarion Scout Landion's, Azenel's, & Jalia's gossip_menu and AI
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP1 WHERE `entry`=@NPC1;
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP2 WHERE `entry`=@NPC2;
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP3 WHERE `entry`=@NPC3;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@NPC1,@NPC2,@NPC3);
-- Gossips 
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP1 AND `text_id`=8063;
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP2 AND `text_id`=8064;
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP3 AND `text_id`=8065;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(@GOSSIP1,8063),
(@GOSSIP2,8064),
(@GOSSIP3,8065);
-- Gossip Options
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (@GOSSIP1,@GOSSIP2,@GOSSIP3);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP1,0,0,"May I have your report?",1,1,0,0,0,0,''), -- placeholder untill sniffed
(@GOSSIP2,0,0,"May I have your report?",1,1,0,0,0,0,''), -- placeholder untill sniffed
(@GOSSIP3,0,0,"May I have your report?",1,1,0,0,0,0,''); -- placeholder untill sniffed
-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (@GOSSIP1,@GOSSIP2,@GOSSIP3);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP1,0,0,0,2,0,21160,1,0,1,0,'',"Show gossip only if player dosn't have Hive'Regal Scout Report"),
(15,@GOSSIP1,0,0,0,9,0,8738,0,0,0,0,'',"Show gossip only if Hive'Regal Scout Report quest has been taken"),
(15,@GOSSIP2,0,0,0,2,0,21158,1,0,1,0,'',"Show gossip only if player dosn't have Hive'Zora Scout Report"),
(15,@GOSSIP2,0,0,0,9,0,8534,0,0,0,0,'',"Show gossip only if Hive'Zora Scout Report quest has been taken"),
(15,@GOSSIP3,0,0,0,2,0,21161,1,0,1,0,'',"Show gossip only if player dosn't have Hive'Ashi Scout Report"),
(15,@GOSSIP3,0,0,0,9,0,8739,0,0,0,0,'',"Show gossip only if Hive'Ashi Scout Report quest has been taken");
-- Scripts
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@NPC1,@NPC2,@NPC3) AND source_type=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@NPC1,0,0,1,62,0,100,0,@GOSSIP1,0,0,0,11,25847,1,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Landion – on gossip option select – cast Create Hive'Regal Scout Report"),
(@NPC1,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Landion – Link – close gossip"),
(@NPC2,0,0,1,62,0,100,0,@GOSSIP2,0,0,0,11,25843,1,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Azenel – on gossip option select – cast Create Hive'Zora Scout Report"),
(@NPC2,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Azenel – Link – close gossip"),
(@NPC3,0,0,1,62,0,100,0,@GOSSIP3,0,0,0,11,25845,1,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Jalia – on gossip option select – ast Create Hive'Ashi Scout Report"),
(@NPC3,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Jalia – Link – close gossip");

UPDATE `gameobject_template` SET `faction` = 0, `flags` = 6553632 WHERE `entry` IN (190356,190357,190358);
UPDATE `gameobject_template` SET `faction` = 0, `flags` = 32 WHERE `entry` IN (190221,190373,190377,190378);

DELETE FROM `gameobject` WHERE `id`=188488;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(245, 188488, 571, 1, 1, 1237.301, -4948.268, 36.02063, 2.495818, 0, 0, 0.9483232, 0.3173059, 300, 0, 1);

-- Area conditions for Plant Chieftains Totem
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=56765;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ErrorTextId`,`Comment`) VALUES
(17,56765,29,30446,15,64,'Plant Chieftains Totem only useable next to Rift');

-- Apply Close Rift to The Chieftain's Totem
DELETE FROM `creature_template_addon` WHERE `entry`=30444;
INSERT INTO `creature_template_addon`(`entry`,`auras`) VALUES
(30444,'56763');

-- Assign aura script to Close Rift
DELETE FROM `spell_script_names` WHERE `spell_id`=56763;
INSERT INTO `spell_script_names`(`spell_id`,`ScriptName`) VALUES
(56763,'spell_close_rift');

-- Target conditions for spell triggered by Close Rift Periodic
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (56764,61665);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(13,1,56764,31,3,30446,'Close Rift Periodic targets Frostfloe Rift'),
(13,1,61665,31,3,30446,'Despawn Rift targets Frostfloe Rift');

-- Assign SmartAI to Frostfloe Rift
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=30446;

-- Create SAI for Frostfloe Rift
DELETE FROM `smart_scripts` WHERE `entryorguid`=30446 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`id`,`link`,`event_type`,`event_param1`,`action_type`,`action_param1`,`action_param2`,`target_type`,`comment`) VALUES
(30446,1,2,8,61665,45,1,1,7,'Frostfloe Rift - On spell hit - Set data of invoker'),
(30446,2,0,61,0,41,0,0,1,'Frostfloe Rift - On spell hit - Despawn');

-- Assign SmartAI to Chieftain's Totem
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=30444;

-- Create SAI for Chieftain's Totem
DELETE FROM `smart_scripts` WHERE `entryorguid`=30444 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`event_type`,`event_param1`,`event_param2`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(30444,38,1,1,33,30444,23,'Chieftains Totem - On data set - Give quest credit');

UPDATE `creature_template` SET `InhabitType`=7 WHERE  `entry` in (28499, 32446, 32446, 38266, 36853, 37755, 38265);

update npc_spellclick_spells set cast_flags=1 where npc_entry=30236;
update npc_spellclick_spells set spell_id=46598 where npc_entry=30236;
update creature_template set speed_walk=0, speed_run=0 where entry=30236;
update creature_model_info set gender=2=0 where modelid=27101;
update creature_template_addon set bytes1=0 where entry=30236;
-- Update position for Koltira Deathweaver
UPDATE `creature_transport` SET `TransOffsetX`=45.50927,`TransOffsetY`=6.679555,`TransOffsetZ`=30.17881,`TransOffsetO`=5.445427 WHERE `guid`=36;

-- Set proper name and period timers for icecrown ships
UPDATE `transports` SET `name`= 'Alliance gunship patrolling above Icecrown (\"The Skybreaker\")',`period`=1051388 WHERE `entry`=192242;
UPDATE `transports` SET `name`= 'Horde gunship patrolling above Icecrown (\"Orgrim''s Hammer\")',`period`=1431158 WHERE `entry`=192241;

-- Gnomeregan/Blastmaster Emi Shortfuse's event
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1090028 AND -1090000;
DELETE FROM `creature_text` WHERE `entry` IN (7361,7998);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
-- Emi Shortfuse
(7998,0,0, 'With your help, I can evaluate these tunnels.',12,0,100,0,0,0, 'SAY_BLASTMASTER_0'),
(7998,1,0, 'Let''s see if we can find out where these Troggs are coming from... and put a stop to the invasion!',12,0,100,0,0,0, 'SAY_BLASTMASTER_1'),
(7998,2,0, 'Such devastation... what horrible mess...',12,0,100,0,0,0, 'SAY_BLASTMASTER_2'),
(7998,3,0, 'It''s quiet here...',12,0,100,0,0,0, 'SAY_BLASTMASTER_3'),
(7998,4,0, '...too quiet.',12,0,100,0,0,0, 'SAY_BLASTMASTER_4'),
(7998,5,0, 'Look! Over there at the tunnel wall!',12,0,100,0,0,0, 'SAY_BLASTMASTER_5'),
(7998,6,0, 'Trogg incrusion! Defend me while I blast the hole closed!',12,0,100,0,0,0, 'SAY_BLASTMASTER_6'),
(7998,7,0, 'The charges are set. Get back before they blow!',12,0,100,0,0,0, 'SAY_BLASTMASTER_7'),
(7998,8,0, 'Incoming blast in 10 seconds!',14,0,100,0,0,0, 'SAY_BLASTMASTER_8'),
(7998,9,0, 'Incoming blast in 5 seconds. Clear the tunnel!',14,0,100,0,0,0, 'SAY_BLASTMASTER_9'),
(7998,10,0, 'FIRE IN THE HOLE!',14,0,100,0,0,0, 'SAY_BLASTMASTER_10'),
(7998,11,0, 'Well done! Without your help I would have never been able to thwart that wave of troggs.',12,0,100,0,0,0, 'SAY_BLASTMASTER_11'),
(7998,12,0, 'Did you hear something?',12,0,100,0,0,0, 'SAY_BLASTMASTER_12'),
(7998,13,0, 'I heard something over there.',12,0,100,0,0,0, 'SAY_BLASTMASTER_13'),
(7998,14,0, 'More troggs! Ward them off as I prepare the explosives!',12,0,100,0,0,0, 'SAY_BLASTMASTER_14'),
(7998,15,0, 'The final charge is set. Stand back!',12,0,100,0,0,0, 'SAY_BLASTMASTER_15'),
(7998,16,0, 'The final charge is set. Stand back!',12,0,100,0,0,0, 'SAY_BLASTMASTER_16'),
(7998,17,0, 'Incoming blast in 10 seconds!',14,0,100,0,0,0, 'SAY_BLASTMASTER_17'),
(7998,18,0, 'Incoming blast in 5 seconds. Clear the tunnel!',14,0,100,0,0,0, 'SAY_BLASTMASTER_18'),
(7998,19,0, 'I don''t think one charge is going to cut it. Keep fending them off!',12,0,100,0,0,0, 'SAY_BLASTMASTER_19'),
(7998,20,0, 'FIRE IN THE HOLE!',14,0,100,0,0,0, 'SAY_BLASTMASTER_20'),
(7998,21,0, 'Well done! Without your help I would have never been able to thwart that wave of troggs.',12,0,100,0,0,0, 'SAY_BLASTMASTER_21'),
(7998,22,0, 'Did you hear something?',12,0,100,0,0,0, 'SAY_BLASTMASTER_22'),
(7998,23,0, 'I heard something over there.',12,0,100,0,0,0, 'SAY_BLASTMASTER_23'),
(7998,24,0, 'More troggs! Ward them off as I prepare the explosives!',12,0,100,0,0,0, 'SAY_BLASTMASTER_24'),
(7998,25,0, 'The final charge is set. Stand back!',12,0,100,0,0,0, 'SAY_BLASTMASTER_25'),
(7998,26,0, '10 seconds to blast! Stand back!!!',14,0,100,0,0,0, 'SAY_BLASTMASTER_26'),
(7998,27,0, '5 seconds until detonation!!',14,0,100,0,0,0, 'SAY_BLASTMASTER_27'),
(7998,28,0, 'Superb! Because of your help, my people stand a chance of re-taking our belowed city. Three cheers to you!',12,0,100,0,0,0, 'SAY_BLASTMASTER_28'),
-- Grubbis
(7361,0,0, 'We come from below! You can never stop us!',14,0,100,0,0,0, 'SAY_GRUBBIS');

DELETE FROM `battleground_template` WHERE `id` = 6; -- all Bgs
SET @GUID = 74685;
SET @MAP = 571;
DELETE FROM `gameobject` WHERE (`id` IN (192254,192255,192269,192284,192285,192336,192338,192339,192349,192350,192351,192352,192353,192354,192355,192356,192357,192358,192359,192360,192361,192362,192363,192364,192366,192367,192368,192369,192370,192371,192372,192373,192374,192375,192378,192379,192416,192488,192501) AND `guid` != 67250) OR `guid` BETWEEN @GUID AND @GUID+87;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(@GUID+0, 192488, @MAP, 64, 5262.540039, 3047.949951, 432.054993, 3.106650),   -- Flag on tower 
(@GUID+1, 192501, @MAP, 128, 5262.540039, 3047.949951, 432.054993, 3.106650),   -- Flag on tower
(@GUID+2, 192374, @MAP, 64, 5272.939941, 2976.550049, 444.492004, 3.124120),   -- Flag on Wall Intersect 
(@GUID+3, 192416, @MAP, 128, 5272.939941, 2976.550049, 444.492004, 3.124120),   -- Flag on Wall Intersect
(@GUID+4, 192375, @MAP, 64, 5235.189941, 2941.899902, 444.278015, 1.588250),   -- Flag on Wall Intersect 
(@GUID+5, 192416, @MAP, 128, 5235.189941, 2941.899902, 444.278015, 1.588250),   -- Flag on Wall Intersect
(@GUID+6, 192488, @MAP, 64, 5163.129883, 2952.590088, 433.502991, 1.535890),   -- Flag on tower 
(@GUID+7, 192501, @MAP, 128, 5163.129883, 2952.590088, 433.502991, 1.535890),   -- Flag on tower
(@GUID+8, 192488, @MAP, 64, 5145.109863, 2935.000000, 433.385986, 3.141590),   -- Flag on tower 
(@GUID+9, 192501, @MAP, 128, 5145.109863, 2935.000000, 433.385986, 3.141590),   -- Flag on tower
(@GUID+10, 192488, @MAP, 64, 5158.810059, 2883.129883, 431.618011, 3.141590),   -- Flag on wall 
(@GUID+11, 192416, @MAP, 128, 5158.810059, 2883.129883, 431.618011, 3.141590),   -- Flag on wall
(@GUID+12, 192336, @MAP, 64, 5154.490234, 2862.149902, 445.011993, 3.141590),   -- Flag on Wall Intersect 
(@GUID+13, 192416, @MAP, 128, 5154.490234, 2862.149902, 445.011993, 3.141590),   -- Flag on Wall Intersect
(@GUID+14, 192255, @MAP, 64, 5154.520020, 2853.310059, 409.183014, 3.141590),   -- Flag on the floor 
(@GUID+15, 192269, @MAP, 128, 5154.520020, 2853.310059, 409.183014, 3.141590),   -- Flag on the floor
(@GUID+16, 192254, @MAP, 64, 5154.459961, 2828.939941, 409.188995, 3.141590),   -- Flag on the floor 
(@GUID+17, 192269, @MAP, 128, 5154.459961, 2828.939941, 409.188995, 3.141590),   -- Flag on the floor
(@GUID+18, 192349, @MAP, 64, 5155.310059, 2820.739990, 444.979004, -3.13286),   -- Flag on wall intersect 
(@GUID+19, 192416, @MAP, 128, 5155.310059, 2820.739990, 444.979004, -3.13286),   -- Flag on wall intersect
(@GUID+20, 192488, @MAP, 64, 5160.339844, 2798.610107, 430.769012, 3.141590),   -- Flag on wall 
(@GUID+21, 192416, @MAP, 128, 5160.339844, 2798.610107, 430.769012, 3.141590),   -- Flag on wall
(@GUID+22, 192488, @MAP, 64, 5146.040039, 2747.209961, 433.584015, 3.071770),   -- Flag on tower 
(@GUID+23, 192501, @MAP, 128, 5146.040039, 2747.209961, 433.584015, 3.071770),   -- Flag on tower
(@GUID+24, 192488, @MAP, 64, 5163.779785, 2729.679932, 433.394012, -1.58825),   -- Flag on tower 
(@GUID+25, 192501, @MAP, 128, 5163.779785, 2729.679932, 433.394012, -1.58825),   -- Flag on tower
(@GUID+26, 192366, @MAP, 64, 5236.270020, 2739.459961, 444.992004, -1.59698),   -- Flag on wall intersect 
(@GUID+27, 192416, @MAP, 128, 5236.270020, 2739.459961, 444.992004, -1.59698),   -- Flag on wall intersect
(@GUID+28, 192367, @MAP, 64, 5271.799805, 2704.870117, 445.183014, -3.13286),   -- Flag on wall intersect 
(@GUID+29, 192416, @MAP, 128, 5271.799805, 2704.870117, 445.183014, -3.13286),   -- Flag on wall intersect
(@GUID+30, 192488, @MAP, 64, 5260.819824, 2631.800049, 433.324005, 3.054330),   -- Flag on tower 
(@GUID+31, 192501, @MAP, 128, 5260.819824, 2631.800049, 433.324005, 3.054330),   -- Flag on tower
(@GUID+32, 192488, @MAP, 64, 5278.379883, 2613.830078, 433.408997, -1.58825),   -- Flag on tower 
(@GUID+33, 192501, @MAP, 128, 5278.379883, 2613.830078, 433.408997, -1.58825),   -- Flag on tower
(@GUID+34, 192364, @MAP, 64, 5350.879883, 2622.719971, 444.686005, -1.57080),   -- Flag on wall intersect 
(@GUID+35, 192416, @MAP, 128, 5350.879883, 2622.719971, 444.686005, -1.57080),   -- Flag on wall intersect
(@GUID+36, 192370, @MAP, 64, 5392.270020, 2639.739990, 435.330994, 1.509710),   -- Flag on wall intersect 
(@GUID+37, 192416, @MAP, 128, 5392.270020, 2639.739990, 435.330994, 1.509710),   -- Flag on wall intersect
(@GUID+38, 192369, @MAP, 64, 5350.950195, 2640.360107, 435.407990, 1.570800),   -- Flag on wall intersect 
(@GUID+39, 192416, @MAP, 128, 5350.950195, 2640.360107, 435.407990, 1.570800),   -- Flag on wall intersect
(@GUID+40, 192368, @MAP, 64, 5289.459961, 2704.679932, 435.875000, -0.01745),   -- Flag on wall intersect 
(@GUID+41, 192416, @MAP, 128, 5289.459961, 2704.679932, 435.875000, -0.01745),   -- Flag on wall intersect
(@GUID+42, 192362, @MAP, 64, 5322.120117, 2763.610107, 444.973999, -1.55334),   -- Flag on wall intersect 
(@GUID+43, 192416, @MAP, 128, 5322.120117, 2763.610107, 444.973999, -1.55334),   -- Flag on wall intersect
(@GUID+44, 192363, @MAP, 64, 5363.609863, 2763.389893, 445.023987, -1.54462),   -- Flag on wall intersect 
(@GUID+45, 192416, @MAP, 128, 5363.609863, 2763.389893, 445.023987, -1.54462),   -- Flag on wall intersect
(@GUID+46, 192379, @MAP, 64, 5363.419922, 2781.030029, 435.763000, 1.570800),   -- Flag on wall intersect 
(@GUID+47, 192416, @MAP, 128, 5363.419922, 2781.030029, 435.763000, 1.570800),   -- Flag on wall intersect
(@GUID+48, 192378, @MAP, 64, 5322.020020, 2781.129883, 435.811005, 1.570800),   -- Flag on wall intersect 
(@GUID+49, 192416, @MAP, 128, 5322.020020, 2781.129883, 435.811005, 1.570800),   -- Flag on wall intersect
(@GUID+50, 192355, @MAP, 64, 5288.919922, 2820.219971, 435.721008, 0.017452),   -- Flag on wall intersect 
(@GUID+51, 192416, @MAP, 128, 5288.919922, 2820.219971, 435.721008, 0.017452),   -- Flag on wall intersect
(@GUID+52, 192354, @MAP, 64, 5288.410156, 2861.790039, 435.721008, 0.017452),   -- Flag on wall intersect 
(@GUID+53, 192416, @MAP, 128, 5288.410156, 2861.790039, 435.721008, 0.017452),   -- Flag on wall intersect
(@GUID+54, 192358, @MAP, 64, 5322.229980, 2899.429932, 435.808014, -1.58825),   -- Flag on wall intersect 
(@GUID+55, 192416, @MAP, 128, 5322.229980, 2899.429932, 435.808014, -1.58825),   -- Flag on wall intersect
(@GUID+56, 192359, @MAP, 64, 5364.350098, 2899.399902, 435.838989, -1.57080),   -- Flag on wall intersect 
(@GUID+57, 192416, @MAP, 128, 5364.350098, 2899.399902, 435.838989, -1.57080),   -- Flag on wall intersect
(@GUID+58, 192338, @MAP, 64, 5397.759766, 2873.080078, 455.460999, 3.106650),   -- Flag on keep 
(@GUID+59, 192416, @MAP, 128, 5397.759766, 2873.080078, 455.460999, 3.106650),   -- Flag on keep
(@GUID+60, 192339, @MAP, 64, 5397.390137, 2809.330078, 455.343994, 3.106650),   -- Flag on keep 
(@GUID+61, 192416, @MAP, 128, 5397.390137, 2809.330078, 455.343994, 3.106650),   -- Flag on keep
(@GUID+62, 192284, @MAP, 64, 5372.479980, 2862.500000, 409.049011, 3.141590),   -- Flag on floor 
(@GUID+63, 192269, @MAP, 128, 5372.479980, 2862.500000, 409.049011, 3.141590),   -- Flag on floor
(@GUID+64, 192285, @MAP, 64, 5371.490234, 2820.800049, 409.177002, 3.141590),   -- Flag on floor 
(@GUID+65, 192269, @MAP, 128, 5371.490234, 2820.800049, 409.177002, 3.141590),   -- Flag on floor
(@GUID+66, 192371, @MAP, 64, 5364.290039, 2916.939941, 445.330994, 1.579520),   -- Flag on wall intersect 
(@GUID+67, 192416, @MAP, 128, 5364.290039, 2916.939941, 445.330994, 1.579520),   -- Flag on wall intersect
(@GUID+68, 192372, @MAP, 64, 5322.859863, 2916.949951, 445.153992, 1.562070),   -- Flag on wall intersect 
(@GUID+69, 192416, @MAP, 128, 5322.859863, 2916.949951, 445.153992, 1.562070),   -- Flag on wall intersect
(@GUID+70, 192373, @MAP, 64, 5290.350098, 2976.560059, 435.221008, 0.017452),   -- Flag on wall intersect 
(@GUID+71, 192416, @MAP, 128, 5290.350098, 2976.560059, 435.221008, 0.017452),   -- Flag on wall intersect
(@GUID+72, 192360, @MAP, 64, 5352.370117, 3037.090088, 435.252014, -1.57080),   -- Flag on wall intersect 
(@GUID+73, 192416, @MAP, 128, 5352.370117, 3037.090088, 435.252014, -1.57080),   -- Flag on wall intersect
(@GUID+74, 192361, @MAP, 64, 5392.649902, 3037.110107, 433.713013, -1.52716),   -- Flag on wall intersect 
(@GUID+75, 192416, @MAP, 128, 5392.649902, 3037.110107, 433.713013, -1.52716),   -- Flag on wall intersect
(@GUID+76, 192356, @MAP, 64, 5237.069824, 2757.030029, 435.795990, 1.518440),   -- Flag on wall intersect 
(@GUID+77, 192416, @MAP, 128, 5237.069824, 2757.030029, 435.795990, 1.518440),   -- Flag on wall intersect
(@GUID+78, 192352, @MAP, 64, 5173.020020, 2820.929932, 435.720001, 0.017452),   -- Flag on wall intersect 
(@GUID+79, 192416, @MAP, 128, 5173.020020, 2820.929932, 435.720001, 0.017452),   -- Flag on wall intersect
(@GUID+80, 192353, @MAP, 64, 5172.109863, 2862.570068, 435.721008, 0.017452),   -- Flag on wall intersect 
(@GUID+81, 192416, @MAP, 128, 5172.109863, 2862.570068, 435.721008, 0.017452),   -- Flag on wall intersect
(@GUID+82, 192357, @MAP, 64, 5235.339844, 2924.340088, 435.040009, -1.57080),   -- Flag on wall intersect 
(@GUID+83, 192416, @MAP, 128, 5235.339844, 2924.340088, 435.040009, -1.57080),   -- Flag on wall intersect
(@GUID+84, 192350, @MAP, 64, 5270.689941, 2861.780029, 445.058014, -3.11539),   -- Flag on wall intersect 
(@GUID+85, 192416, @MAP, 128, 5270.689941, 2861.780029, 445.058014, -3.11539),   -- Flag on wall intersect
(@GUID+86, 192351, @MAP, 64, 5271.279785, 2820.159912, 445.200989, -3.13286),   -- Flag on wall intersect 
(@GUID+87, 192416, @MAP, 128, 5271.279785, 2820.159912, 445.200989, -3.13286);   -- Flag on wall intersect

UPDATE `creature_loot_template` SET `chanceOrQuestChance`=-50 WHERE `item`=23239;
UPDATE `spell_proc_event` SET `procflags`=0x15510 WHERE `entry`=53386;

DELETE FROM `spell_group` WHERE `id`=1037;
INSERT INTO `spell_group`(`id`,`spell_id`) VALUES
(1037,22959),
(1037,17800),
(1037,12579);

DELETE FROM `spell_group_stack_rules` WHERE `group_id`=1037;
INSERT INTO `spell_group_stack_rules`(`group_id`,`stack_rule`) VALUES (1037,3);

-- Blood Frenzy (Warrior) and Savage Combat effect should not stack
DELETE FROM `spell_group` WHERE `id`=1119;
INSERT INTO `spell_group`(`id`,`spell_id`) VALUES
(1119,30069),
(1119,58684);

DELETE FROM `spell_group_stack_rules` WHERE `group_id`=1119;
INSERT INTO `spell_group_stack_rules`(`group_id`,`stack_rule`) VALUES (1119,3);

-- Remove invalid spell_groups
DELETE FROM `spell_group` WHERE `id` IN (1038,1039);

SET @GROUP := 1120;
-- Totem of Wrath and Heart of the Crusader effect should not stack
DELETE FROM `spell_group` WHERE `id`=@GROUP;
INSERT INTO `spell_group`(`id`,`spell_id`) VALUES
(@GROUP,21183),
(@GROUP,30708);

DELETE FROM `spell_group_stack_rules` WHERE `group_id`=@GROUP;
INSERT INTO `spell_group_stack_rules`(`group_id`,`stack_rule`) VALUES (@GROUP,3);

ALTER TABLE `spell_area` ADD COLUMN `quest_start_status` INT(11) NOT NULL DEFAULT 64; -- default is QUEST_STATUS_REWARDED
ALTER TABLE `spell_area` ADD COLUMN `quest_end_status` INT(11) NOT NULL DEFAULT 11; -- default is QUEST_STATUS_COMPLETE | QUEST_STATUS_NONE | QUEST_STATUS_INCOMPLETE
UPDATE spell_area SET `quest_start_status` = (1 << 6) | (1 << 3) | (1 << 1) WHERE `quest_start_active` = 1;
ALTER TABLE spell_area DROP COLUMN `quest_start_active`;

-- Orb rotation focus
UPDATE `creature_template` SET `modelid1`=11868,`modelid2`=169,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`speed_walk`=2.2,`speed_run`=0.785714,`baseattacktime`=2000,`unit_flags`=33554688 WHERE `entry` IN(43280,43281,43282);
UPDATE `creature_template` SET `difficulty_entry_1`=43280, `difficulty_entry_2`=43281,`difficulty_entry_3`=43282 WHERE `entry`=40091;

-- Orb carrier
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`faction_A`=14,`faction_H`=14,`speed_walk`=1.2,`speed_run`=1.14286,`baseattacktime`=2000 WHERE `entry` IN(40470,40471,40472);
UPDATE `creature_template` SET `difficulty_entry_1`=40470, `difficulty_entry_2`=40471,`difficulty_entry_3`=40472 WHERE `entry`=40081;

-- Saviana Ragefire
UPDATE `creature_template` SET `exp`=2 WHERE `entry`=39823;

-- General Zarithrian
UPDATE `creature_template` SET `exp`=2 WHERE `entry`=39805;

-- Twilight Halion
UPDATE `creature_template` SET `difficulty_entry_1`=40143, `difficulty_entry_2`=40144,`difficulty_entry_3`=40145 WHERE `entry`=40142;
UPDATE `creature_template` SET `minlevel`=83,`maxlevel`=83,`speed_walk`=1.6,`speed_run`=1.42857,`baseattacktime`=1800,`unit_flags`=559168,`dynamicflags`=12 WHERE `entry` IN(40143,40144,40145);

-- Halion
UPDATE `creature_template` SET `speed_walk`=1.6,`speed_run`=1.42857,`baseattacktime`=1500,`unit_flags`=32832,`dynamicflags`=12,`flags_extra`=1 WHERE `entry` IN(39864,39944,39945);
UPDATE `creature_template` SET `dmg_multiplier`=50 WHERE `entry`=39944;
UPDATE `creature_template` SET `dmg_multiplier`=85 WHERE `entry`=39945;

-- Onyx Flamecaller
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`faction_A`=103,`faction_H`=103,`exp`=2,`speed_walk`=0.88888,`speed_run`=1.42857,`baseattacktime`=2000,`unit_flags`=32768,`equipment_id`=2468 WHERE `entry`=39815;

DELETE FROM `trinity_string` WHERE `entry` IN (9986, 9987, 9989, 9990, 9991, 9992, 9993, 9994, 9995, 9996, 9997, 9998, 9999);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`)
VALUES
  (9986, 'Error', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9987, 'None', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9988, 'Leader', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9989, 'Dps', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9990, 'Healer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9991, 'Tank', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9992, 'Raid browser', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9993, 'Finished dungeon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9994, 'In dungeon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9995, 'Vote kick', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9996, 'Proposal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9997, 'Queued', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9998, 'Role check', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9999, 'None', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
  
  -- Gnomeregan/Blastmaster Emi Shortfuse's event
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1090028 AND -1090000;
DELETE FROM `creature_text` WHERE `entry` IN (7361,7998);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
-- Emi Shortfuse
(7998,0,0, 'With your help, I can evaluate these tunnels.',12,0,100,0,0,0, 'SAY_BLASTMASTER_0'),
(7998,1,0, 'Let''s see if we can find out where these Troggs are coming from... and put a stop to the invasion!',12,0,100,0,0,0, 'SAY_BLASTMASTER_1'),
(7998,2,0, 'Such devastation... what horrible mess...',12,0,100,0,0,0, 'SAY_BLASTMASTER_2'),
(7998,3,0, 'It''s quiet here...',12,0,100,0,0,0, 'SAY_BLASTMASTER_3'),
(7998,4,0, '...too quiet.',12,0,100,0,0,0, 'SAY_BLASTMASTER_4'),
(7998,5,0, 'Look! Over there at the tunnel wall!',12,0,100,0,0,0, 'SAY_BLASTMASTER_5'),
(7998,6,0, 'Trogg incrusion! Defend me while I blast the hole closed!',12,0,100,0,0,0, 'SAY_BLASTMASTER_6'),
(7998,7,0, 'The charges are set. Get back before they blow!',12,0,100,0,0,0, 'SAY_BLASTMASTER_7'),
(7998,8,0, 'Incoming blast in 10 seconds!',14,0,100,0,0,0, 'SAY_BLASTMASTER_8'),
(7998,9,0, 'Incoming blast in 5 seconds. Clear the tunnel!',14,0,100,0,0,0, 'SAY_BLASTMASTER_9'),
(7998,10,0, 'FIRE IN THE HOLE!',14,0,100,0,0,0, 'SAY_BLASTMASTER_10'),
(7998,11,0, 'Well done! Without your help I would have never been able to thwart that wave of troggs.',12,0,100,0,0,0, 'SAY_BLASTMASTER_11'),
(7998,12,0, 'Did you hear something?',12,0,100,0,0,0, 'SAY_BLASTMASTER_12'),
(7998,13,0, 'I heard something over there.',12,0,100,0,0,0, 'SAY_BLASTMASTER_13'),
(7998,14,0, 'More troggs! Ward them off as I prepare the explosives!',12,0,100,0,0,0, 'SAY_BLASTMASTER_14'),
(7998,15,0, 'The final charge is set. Stand back!',12,0,100,0,0,0, 'SAY_BLASTMASTER_15'),
(7998,16,0, 'The final charge is set. Stand back!',12,0,100,0,0,0, 'SAY_BLASTMASTER_16'),
(7998,17,0, 'Incoming blast in 10 seconds!',14,0,100,0,0,0, 'SAY_BLASTMASTER_17'),
(7998,18,0, 'Incoming blast in 5 seconds. Clear the tunnel!',14,0,100,0,0,0, 'SAY_BLASTMASTER_18'),
(7998,19,0, 'I don''t think one charge is going to cut it. Keep fending them off!',12,0,100,0,0,0, 'SAY_BLASTMASTER_19'),
(7998,20,0, 'FIRE IN THE HOLE!',14,0,100,0,0,0, 'SAY_BLASTMASTER_20'),
(7998,21,0, 'Well done! Without your help I would have never been able to thwart that wave of troggs.',12,0,100,0,0,0, 'SAY_BLASTMASTER_21'),
(7998,22,0, 'Did you hear something?',12,0,100,0,0,0, 'SAY_BLASTMASTER_22'),
(7998,23,0, 'I heard something over there.',12,0,100,0,0,0, 'SAY_BLASTMASTER_23'),
(7998,24,0, 'More troggs! Ward them off as I prepare the explosives!',12,0,100,0,0,0, 'SAY_BLASTMASTER_24'),
(7998,25,0, 'The final charge is set. Stand back!',12,0,100,0,0,0, 'SAY_BLASTMASTER_25'),
(7998,26,0, '10 seconds to blast! Stand back!!!',14,0,100,0,0,0, 'SAY_BLASTMASTER_26'),
(7998,27,0, '5 seconds until detonation!!',14,0,100,0,0,0, 'SAY_BLASTMASTER_27'),
(7998,28,0, 'Superb! Because of your help, my people stand a chance of re-taking our belowed city. Three cheers to you!',12,0,100,0,0,0, 'SAY_BLASTMASTER_28'),
-- Grubbis
(7361,0,0, 'We come from below! You can never stop us!',14,0,100,0,0,0, 'SAY_GRUBBIS');

-- Wickerman Festival
SET @GO_GUID       := xxxxxx; -- set by TDB team (14)
SET @CREATURE_GUID := xxxxxx; -- set by TDB team (5)

UPDATE `gameobject_template` SET `flags` = 17 WHERE `entry` = 180433;
DELETE FROM gameobject WHERE id IN (180432,180433,180434,180437,180405,180406) AND guid BETWEEN @GO_GUID+00 AND @GO_GUID+13;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
-- Forsaken Banner
(@GO_GUID+00,180432,0,1,1,1749.28,507.611,39.2312,1.49635,0,0,0.680301,0.732933,300,0,1),
(@GO_GUID+01,180432,0,1,1,1712.63,507.05,38.2495,1.58824,0,0,0.713246,0.700914,300,0,1),
-- The Wickerman
(@GO_GUID+02,180433,0,1,1,1734.04,504.05,42.2861,1.4131,0,0,0.649213,0.760607,300,0,0),
-- Bonfire
(@GO_GUID+03,180434,0,1,1,1758.89,513.276,35.8655,1.28897,0,0,0.600788,0.799409,300,0,1),
(@GO_GUID+04,180434,0,1,1,1704.48,518.689,35.4045,1.30704,0,0,0.607984,0.793949,300,0,1),
(@GO_GUID+05,180434,0,1,1,1739.78,473.238,61.6565,1.59371,0,0,0.71516,0.698961,300,0,1),
(@GO_GUID+06,180434,0,1,1,1717.32,472.723,61.6566,1.59371,0,0,0.71516,0.698961,300,0,1),
-- Wickerman Ember
(@GO_GUID+07,180437,0,1,1,1744.62,504.954,40.8518,1.23403,0,0,0.578603,0.81561,300,0,1),
(@GO_GUID+08,180437,0,1,1,1729.13,510.378,40.8719,1.23403,0,0,0.578603,0.81561,300,0,1),
(@GO_GUID+09,180437,0,1,1,1721.77,503.938,41.1381,1.23403,0,0,0.578603,0.81561,300,0,1),
(@GO_GUID+10,180437,0,1,1,1744.96,496.25,41.44,1.24581,0,0,0.583397,0.812187,300,0,1),
-- G_Pumpkin_01
(@GO_GUID+11,180405,0,1,1,1746.07,517.066,38.936,2.83466,0,0,0.988247,0.152864,300,0,1),
(@GO_GUID+12,180405,0,1,1,1728,475.099,63.6779,3.08363,0,0,0.99958,0.0289791,300,0,1),
-- G_Pumpkin_02
(@GO_GUID+13,180406,0,1,1,1719.67,522.979,36.8828,2.93283,0,0,0.994557,0.10419,300,0,1);

DELETE FROM `creature` WHERE `id` IN (15195,15197,15199) AND `guid` BETWEEN @CREATURE_GUID+00 AND @CREATURE_GUID+04;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
-- Wickerman Guardian
(@CREATURE_GUID+00,15195,0,1,1,0,0,1713.1,511.295,37.2005,1.48063,300,0,0,45780,0,0,0,0,0),
(@CREATURE_GUID+01,15195,0,1,1,0,0,1750.57,511.697,37.7587,1.25444,300,0,0,45780,0,0,0,0,0),
(@CREATURE_GUID+02,15195,0,1,1,0,0,1732.31,520.874,36.3326,1.30942,300,0,0,45780,0,0,0,0,0),
-- Darkcaller Yanka
(@CREATURE_GUID+03,15197,0,1,1,0,0,1734.6,508.803,41.2847,1.6173,300,0,0,15260,0,0,0,0,0),
-- Sergeant Hartman
(@CREATURE_GUID+04,15199,0,1,1,0,0,-813.614,-547.184,15.6377,1.69193,300,0,0,15260,0,0,0,0,0);

DELETE FROM `game_event_gameobject` WHERE `guid` BETWEEN @GO_GUID+00 AND @GO_GUID+13;
INSERT INTO `game_event_gameobject` VALUES
(12,@GO_GUID+00),
(12,@GO_GUID+01),
(12,@GO_GUID+02),
(12,@GO_GUID+03),
(12,@GO_GUID+04),
(12,@GO_GUID+05),
(12,@GO_GUID+06),
(12,@GO_GUID+07),
(12,@GO_GUID+08),
(12,@GO_GUID+09),
(12,@GO_GUID+10),
(12,@GO_GUID+11),
(12,@GO_GUID+12),
(12,@GO_GUID+13);

DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @CREATURE_GUID+00 AND @CREATURE_GUID+04;
INSERT INTO `game_event_creature` VALUES
(12,@CREATURE_GUID+00),
(12,@CREATURE_GUID+01),
(12,@CREATURE_GUID+02),
(12,@CREATURE_GUID+03),
(12,@CREATURE_GUID+04);

-- Wickerman Ashes
DELETE FROM `gossip_menu` WHERE `entry` = 6535;
INSERT INTO `gossip_menu` VALUES
(6535,7737),
(6535,7738);
DELETE FROM `gossip_menu_option` WHERE `menu_id`=6535 AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(6535,0,0,"Smear the ash on my face like war paint!",1,1,0,0,0,0,"");
-- gossip conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=6535;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,6535,7738,0,0,1,0,24705,0,0,0,0,"","Wickerman Ember - Show different gossip if player is affected by aura 24705"),
(14,6535,7737,0,0,1,0,24705,0,0,1,0,"","Wickerman Ember - Show different gossip if player is affected by aura 24705"),
(15,6535,   0,0,0,1,0,24705,0,0,1,0,"","Wickerman Ember - Show different gossip option if player is affected by aura 24705");
-- GO smart script
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=180437;
DELETE FROM `smart_scripts` WHERE `entryorguid`=180437 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(180437, 1, 0, 1, 62, 0, 100, 0, 6535, 0, 0, 0, 85, 24705, 34, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Wickerman Ember - on Gossip Select - Cast Invocation of the Wickerman'),
(180437, 1, 1, 0, 61, 0, 100, 0,    0, 0, 0, 0, 72,     0,  0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Wickerman Ember - on Link - Close gossip');
