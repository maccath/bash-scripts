<?php

/**
 * Class Line
 *
 * Represents a line of log input
 */
class Line
{
    /**
     * Raw line data
     *
     * @var string
     */
    private $raw;

    /**
     * Directory where database migration files are located
     *
     * @var string
     */
    private $migrationsPath;

    /**
     * Line constructor.
     *
     * @param $migrationsPath string path to DB migrations
     * @param $raw string line input
     */
    public function __construct($migrationsPath, $raw)
    {
        $this->migrationsPath = $migrationsPath;
        $this->raw = $raw;
    }

    /**
     * Get raw line contents
     *
     * @return mixed
     */
    public function getRaw()
    {
        return $this->raw;
    }

    /**
     * Get an array of referenced JIRA issues
     *
     * @return array
     */
    public function getIssues()
    {
        $matches = [];
        preg_match("/(?<=#)?[A-Z]+-[0-9]+/", $this->raw, $matches);

        return array_slice($matches, 0);
    }

    /**
     * Is the line referring to a migration file?
     *
     * @return boolean
     */
    public function isFile()
    {
        return (boolean) preg_match("/migrations\//", $this->raw) == 1;
    }

    /**
     * Does the stated migration file still exist?
     *
     * @return boolean
     */
    public function fileExists()
    {
        return (boolean) file_exists($this->migrationsPath . '/' . $this->raw);
    }
}