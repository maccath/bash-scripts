<?php

require 'feature.php';
require 'migration.php';
require 'logReader.php';
require 'line.php';

$db = $argv[1];
$branch = $argv[2];
$format = $argv[3];
$migrationsPath = $argv[4];

$input = file("php://stdin");

$currentIssues = false;

$feature = new Feature($branch, $db);
$logReader = new LogReader($migrationsPath, $feature);

// Read the input
$logReader->readLog($input);

// Echo the output
echo $logReader->listLog($format);