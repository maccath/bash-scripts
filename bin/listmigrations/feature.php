<?php

/**
 * Class Feature
 *
 * Represents a feature branch
 */
class Feature
{
    /**
     * Feature branch name
     *
     * @var string
     */
    private $name;

    /**
     * Database name
     *
     * @var string
     */
    private $db;

    /**
     * Array of migrations in feature
     *
     * @var array
     */
    private $migrations;

    /**
     * Feature constructor.
     *
     * @param $name feature name
     * @param $db database to check
     */
    public function __construct($name, $db)
    {
        $this->name = $name;
        $this->db = $db;
        $this->migrations = [];
    }

    /**
     * Get the feature name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Get the DB
     *
     * @return string
     */
    public function getDb()
    {
        return $this->db;
    }

    /**
     * Get the migrations in feature
     *
     * @return array
     */
    public function getMigrations()
    {
        return $this->migrations;
    }

    /**
     * Add migration to feature
     *
     * @param Migration $migration the migration to add
     */
    public function addMigration(Migration $migration)
    {
        $migration->setFeature($this);

        // Don't add duplicate migrations
        if (in_array($migration, $this->migrations) === false) {
            $this->migrations[] = $migration;
        }
    }

    /**
     * List migrations in feature
     *
     * @param string $format the format to list migrations in
     * @return string the list of migrations
     */
    public function listMigrations($format)
    {
        $output = '';

        foreach ($this->migrations as $migration) {
            $output .= $migration->output($format);
        }

        return $output;
    }
}