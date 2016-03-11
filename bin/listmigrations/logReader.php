<?php

/**
 * Class LogReader
 *
 * Reads given git log input
 */
class LogReader
{
    /**
     * Directory where database migration files are located
     *
     * @var string
     */
    private $migrationsPath;

    /**
     * Feature object
     *
     * @var Feature
     */
    private $feature;

    /**
     * LogReader constructor.
     *
     * @param $migrationsPath
     * @param Feature $feature
     */
    public function __construct($migrationsPath, Feature $feature)
    {
        $this->migrationsPath = $migrationsPath;
        $this->feature = $feature;
    }

    /**
     * Read the given log input
     *
     * @param $input
     */
    public function readLog($input)
    {
        $issues = [];
        foreach ($input as $line) {
            $line = new Line($this->migrationsPath, trim($line));

            if ( ! $line->isFile()) {
                $issues = $line->getIssues();
            } else {
                if ($line->fileExists()) {
                    $migration = new Migration($line->getRaw(), $issues);
                    $this->feature->addMigration($migration);
                }
            }
        }
    }

    /**
     * Get the log results in given format
     *
     * @param $format string
     * @return string
     */
    public function listLog($format)
    {
        return $this->feature->listMigrations($format);
    }
}