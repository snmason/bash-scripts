# Requires the gh CLI client configured. See @https://cli.github.com/
# will need to run gh auth refresh -h github.com -s delete_repo to grand delete permissions

#!/bin/bash

gh_repos=( $(gh repo list DRE-IaC -L 600 | awk '{print $1}' ) )

for str in ${gh_repos[@]}; do
    echo cloning $str
    gh repo clone $str
    echo deleting $str
    gh repo delete $str --yes
done
