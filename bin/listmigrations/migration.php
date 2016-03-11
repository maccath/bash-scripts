<?php

/**
 * Class Migration
 */
class Migration
{
    /**
     * Raw migration string
     *
     * @var string
     */
    private $raw;

    /**
     * Array of issues associated with the migration
     *
     * @var Array
     */
    private $issues;

    /**
     * The migration's feature
     *
     * @var Feature
     */
    private $feature;

    /**
     * Migration constructor
     *
     * @param $raw
     * @param $issues
     */
    public function __construct($raw, $issues)
    {
        $this->raw = trim($raw);
        $this->issues = $issues;
    }

    /**
     * Set the migration's feature
     *
     * @param Feature $feature
     */
    public function setFeature(Feature $feature)
    {
        $this->feature = $feature;
    }
    
    /**
     * Get raw migration
     *
     * @return string
     */
    public function getRaw()
    {
        return $this->raw;
    }

    /**
     * Get migration name
     *
     * @return string
     */
    public function getName()
    {
        return preg_replace("/migrations\/" . $this->feature->getDb() . "\//", "", $this->raw);
    }

    /**
     * Get migration number
     *
     * @return string
     */
    public function getNumber()
    {
        return substr($this->getName(), 0, 14);
    }

    /**
     * Get human-readable migration name
     *
     * @return string
     */
    public function getHumanName()
    {
        return str_replace(['_'], [' '], substr($this->getName(), 14));
    }

    /**
     * Get human-readable issues string
     *
     * @return string
     */
    public function getHumanIssues()
    {
        return $this->issues ? join(', ', $this->issues) : '';
    }

    /**
     * Generate HTML output
     *
     * @return string
     */
    private function htmlOutput()
    {
        $html = <<<EOT
<tr>
    <td colspan="1"><a href="%s">%s</a></td>
    <td colspan="1">%s</td>
    <td colspan="1">%s</td>
    <td colspan="1">%s</td>
    <td colspan="1">
        <ac:link><ri:user ri:userkey=""/></ac:link>
    </td>
</tr>\n
EOT;

        return sprintf($html, $this->getHumanIssues(), $this->getHumanIssues(), $this->feature->getName(), $this->feature->getDb(), trim($this->raw));
    }

    /**
     * Generate plain output
     *
     * @return string
     */
    private function plainOutput()
    {
        return sprintf(
            "%s %s\n",
            $this->getHumanIssues(),
            $this->raw
        );
    }

    /**
     * Generate output
     *
     * @param $format
     * @return string
     */
    public function output($format)
    {
        if ($format == 'html') {
            return $this->htmlOutput();
        }

        return $this->plainOutput();
    }
}