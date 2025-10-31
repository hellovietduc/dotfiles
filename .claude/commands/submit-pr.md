---
argument-hint: Linear issue ID (e.g., PRO-12345)
description: Generate and submit PR description from Linear issue
---

## Instructions

1. **Fetch issue details**: Use Linear MCP to fetch complete details for the issue ID provided in the User input section below, including:
   - Issue title and description
   - Acceptance criteria
   - Any linked documents or context
   - Comments that may contain important context

2. **Find PR template**: Search for the GitHub pull request template in this repository:
   - Look for `.github/pull_request_template.md` or `.github/PULL_REQUEST_TEMPLATE.md`
   - If not found there, check for `docs/pull_request_template.md` or any `PULL_REQUEST_TEMPLATE` file
   - Understand the required sections and format

3. **Generate PR description**: Create a comprehensive PR description that:
   - Follows the exact structure of the repository's PR template
   - Explains the problem being solved and why it matters (from Linear issue context)
   - Describes the high-level solution approach and key design decisions
   - Documents any architectural choices or trade-offs made
   - Notes any important considerations for reviewers
   - References the Linear issue with proper formatting (e.g., "Fixes PRO-12345")
   - **DO NOT** list implementation details that are obvious from reading the code
   - **DO NOT** enumerate file changes or describe what each function does
   - Focus on the "why" rather than the "what"

4. **Submit using GitHub CLI**: Use GitHub CLI to update the current PR's description with your generated content:
   - Ensure all template sections are filled appropriately
   - Maintain any required formatting or checkboxes from the template
   - Keep the description concise and focused on context that helps reviewers

## Important notes

- Focus on context, rationale, and decisions rather than implementation details
- The code diff shows what changed; the PR description should explain why
- If the Linear issue lacks sufficient context, look for design decisions in the code structure itself
- Always preserve the repository's PR template structure exactly as defined
- NEVER update the PR title

## User input

Linear issue ID:
$ARGUMENTS
