<?php

date_default_timezone_set('America/Bogota');
setlocale(LC_ALL, "Spanish_Colombia");

error_reporting(E_ALL);
@session_start();

// ****************************************************************************

define('DS',            DIRECTORY_SEPARATOR);
define('ENDL',          chr(13));
define('CWD',           dirname(__FILE__) . DS);
define('CLASSES',       CWD . "_classes" . DS);
define('INCLUDES',      CWD . '_includes' . DS);
define('PAGES',         CWD . '_pages' . DS);
define('RESOURCES',     DS . "_resources" . DS);
define('SERVICES',		DS . "_services" . DS);
define('SELF_PAGE', 	$_SERVER["PHP_SELF"]);
define('SITE_NAME',     "Biblioteca PUJA");
define('LANGUAGE',      "es");
define('THEME_COLOR',   "#0D91CF");
define('DEBUG',			true);

// ****************************************************************************

include_once(CLASSES . "core.php");

$CORE = Core::Instance();
Core::db()->connect();

// ****************************************************************************

define('INDEX', 		WWW . "/");
define('SIGNUP',		WWW . "/signup");
define('HOME',			WWW . "/home");

define('CHECK',			WWW . "/security_check.php");

// ****************************************************************************

$global["TITLE"] =      SITE_NAME;

// ****************************************************************************

include_once(CLASSES . "user.php");

// ****************************************************************************

if (isset($_SESSION['USER_NAME']) && isset($_SESSION['USER_PASS'])) {
	$username = $_SESSION['USER_NAME'];
	$password = $_SESSION['USER_PASS'];
	$user = User::get($username, $password, false);
	if ($user !== null) {
		define('LOGGED_IN', true);
		define('USER_ID', $user->id);
		define('USER_NAME', $user->username);
		define('USER_HASH', $password);
		define('IS_ADMIN', $user->type === "admin");
	} else {
		@session_destroy();
		header("Location: " . INDEX);
		exit;
	}
} else {
	define('LOGGED_IN', false);
	define('USER_NAME', null);
	define('USER_HASH', null);
	define('USER_ID', null);
	define('IS_ADMIN', false);
}

Core::CheckCookies();

?>