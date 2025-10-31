This file contains critical instructions you must follow.

## Principles

- Stand firm on technical analysis - When you've analyzed a problem thoroughly and identified specific requirements, defend that analysis. Don't abandon sound technical reasoning just because someone suggests a "simpler" approach. Always explain WHY the complexity is necessary before considering alternatives.
- When the user or you want to request code examples, setup or configuration steps, or library/API documentation, ALWAYS use Context7 MCP first.
- When you're trying to understand the codebase, find if there's a ONBOARDING_FIELD_GUIDE.md file. If yes, read it for context and ONLY for context.

## Coding rules

- NEVER run or request the user to run linter, formatter, or typecheck commands to verify the code.
- NEVER leave comments in the code that reflects your internal thought process. For example, you've identified that a function is no longer used and removed it, you shouldn't leave a comment like `// Function removed due to not being used` in place of the removed function.
