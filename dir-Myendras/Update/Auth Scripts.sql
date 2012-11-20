/*Auth.sql Updates
 *Myendras Auth Updates
 *LastUpdate: Phailure
 *http://wow.urnaweb.cz/wotlk/web/index.php
 */


CREATE TABLE logs (
	`time` INT(10) UNSIGNED NOT NULL,
	`realm` INT(10) UNSIGNED NOT NULL,
	`type` TINYINT(3) UNSIGNED NOT NULL,
	`level` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
	`string` TEXT NULL COLLATE 'latin1_swedish_ci'
)



