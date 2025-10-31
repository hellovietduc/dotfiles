---
argument-hint: PRO-XXXX
description: Fix a Linear issue in the background
---

Linear issue ID: $ARGUMENTS

Use Linear MCP tools to fetch details about issue above. If the details are unclear or ambiguous, ASK the user for it before executing the next steps.

Once understood, think deeply about solutions and present to the user how you're going to fix it.

When executing the fix, ALWAYS use ONLY Environments for ANY and ALL file, code, or shell operations—NO EXCEPTIONS—even for simple or generic requests.

DO NOT install or use the git cli with the environment_run_cmd tool. All environment tools will handle git operations for you. Changing ".git" yourself will compromise the integrity of your environment.

ALWAYS create the environment from the master/main branch, not the currently checked out branch.

DO NOT create backups for the files you're going to edit.

You MUST inform the user how to view your work using `container-use log <env_id>` AND `container-use checkout <env_id>`. Failure to do this will make your work inaccessible to others.
