<?php

$db = $argv[1];
$input = file("php://stdin");

$currentIssues = 'UNKNOWN';

foreach ($input as $line) {
    $matches = [];
    if (preg_match("/(?<=#)?[A-Z]+-[0-9]+/", $line, $matches) >= 1) {
        $matches = array_slice($matches, 0);
        $currentIssues = join(", ", $matches);
    } else if (preg_match("/migrations/", $line)) {
        echo $currentIssues . " " . preg_replace("/migrations\/" . $db . "\//", "", $line);
    } else {
        $currentIssues = "UNKNOWN";
    }
}