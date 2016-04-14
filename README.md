#Bash Scripts

A selection of simple but potentially useful bash scripts I use, primarily at work. Items marked with a :warning: 
require a specific set-up beyond what can be configured here, but they may be of use to you. I make no guarantees!

To configure, please rename the existing `etc/sample.cfg` file to `etc/configuration.cfg` and edit it to fit your own 
configuration.

To create aliases for the functions, edit your bash profile with something similar to the following:

    bash_scripts='/path/to/this/project/'
    alias scriptalias="${bash_scripts}bin/script_filename.sh"
    
## Available Scripts

### checkoutall.sh 

Check out a given branch for all git repositories in `$project_path`

To force fetch from remote, use the second parameter `force`

    checkoutall.sh [branchName] [force]
    
### fetchall.sh 

Fetch from remote for all repositories in `$project_path`

    fetchall.sh
    
### pullall.sh

Pull the current branch and all given branches for all git repositories in `$project_path`

    pullall.sh [branchName branchName ...]
    
###  ct.sh

Change directory to the given project in the `$project_path` directory (partial names accepted)

    . ct.sh [projectName]
    
### :warning: phinx.sh

Create a new Phinx migration in `$db_migrations_path`

    phinx.sh [scriptName] [migrationName]
    
### :warning: deploy.sh

Deploy [repos] to the given [feature] on [server] using [branch] or develop branch if it doesn't exist

    ./deploy.sh [feature] [server] [branch] [repos]

### :warning: setschema.sh

Set the schemaPrefix XML attribute for the local configuration in all applications

    ./setschema.sh [schemaName]
