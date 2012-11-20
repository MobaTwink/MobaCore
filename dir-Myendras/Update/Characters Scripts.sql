/*Characters.sql Updates
 *Myendras Characters Updates
 *LastUpdate: Phailure
 *http://wow.urnaweb.cz/wotlk/web/index.php
 */


ALTER TABLE `characters`
	CHANGE COLUMN `drunk` `drunks` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `watchedFaction`;


ALTER TABLE character_glyphs CHANGE glyph1 glyph1 smallint(5) unsigned DEFAULT '0';

 ALTER TABLE `gm_tickets`
    ADD COLUMN `response` text NOT NULL AFTER `comment`,
    ADD COLUMN `haveTicket` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `viewed`;