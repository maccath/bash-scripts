#Bash Scripts

A selection of simple but useful bash scripts I use, primarily at work.

To configure, please rename the existing `etc/sample.cfg` file to `etc/configuration.cfg` and edit it to fit your own 
configuration.

To create aliases for the functions, edit your bash profile with something similar to the following:

    bash_scripts='/path/to/this/project/'
    alias scriptalias="${bash_scripts}bin/script_filename.sh"
    
## Available Scripts

### checkoutall.sh

Check out a given branch for all git repositories in `$project_path`

    checkoutall.sh [branchName]
    
### pullall.sh

Pull the current branch and all given branches for all git repositories in `$project_path`

    pullall.sh [branchName] [branchName] ...
    
###  ct.sh

Change directory to the given project in the `$project_path` directory (partial names accepted)

    . ct.sh [projectName]
    
### phinx.sh

Create a new Phinx migration in `$db_migrations_path`

    phinx.sh [scriptName] [migrationName]