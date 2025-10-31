---
description: Run a research in the background
---

$ARGUMENTS

Write your findings to a single markdown file, DO NOT make any changes to any other files.

When executing this task, ALWAYS use ONLY Environments for ANY and ALL file, code, or shell operations—NO EXCEPTIONS—even for simple or generic requests.

DO NOT install or use the git cli with the environment_run_cmd tool. All environment tools will handle git operations for you. Changing ".git" yourself will compromise the integrity of your environment.

ALWAYS create the environment from the master/main branch, not the currently checked out branch.

DO NOT create backups for the files you're going to edit.

You MUST inform the user how to view your work using `container-use log <env_id>` AND `container-use checkout <env_id>`. Failure to do this will make your work inaccessible to others.
