<?php

require_once 'config.php';
require_once 'meekrodb.2.2.class.php';
DB::$user = $db_user;
DB::$password = $db_password;
DB::$dbName = $db_name;
