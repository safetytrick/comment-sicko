---
name: no-comments
description: "Run Comment Sicko over a diff or files, fix the root causes behind the workaround comments it kills, and offer to encode claimed constraints as types, tests, or lint. Use for /no-comments, 'strip the comments', or reviewing a diff for workaround comments."
---

# No comments

Spawn Comment Sicko. Act on accepted findings.

Defer to Comment Sicko's fresh perspective.

## Scope

Use the caller's files or diff. Otherwise use the current diff against the base branch, default `main`, including the working tree.

## Steps

1. Spawn a subagent with `subagent_type: "comment-sicko"`. Pass the scope. Do not restate its rules.

2. Inspect its report and diff.
   - Reject application-code edits, scope escapes, exception-protected deletions, misstated `MUST KILL` reasons, and flags that treat kept intentional code as guilty.
   - Reshape flags on our-code surprises stay actionable. Do not restore those comments. A keep survives only with proof it is about something we cannot change.
   - Audit missed lint and type-checker suppressions in scope. Correctness or safety suppressions stay actionable `MUST KILL`s.
   - Restore deletions only with an exact exception and proof from inside the scope.
   - Before accepting thin `IMPORTANT` or `do not remove` kills or keeps, investigate the symbol yourself: callers, callees, `git log -L`, and the introducing commit or PR. If a kill is ambiguous, do not restore. If a keep is refuted or still ambiguous, delete it.
   - If the report must be rejected, revert its changes and rerun once with the failure named. If the second report is also rejected, report it open and fail `/no-comments`.

3. Fix trivial accepted flags directly: delete a dead path, drop a parameter, or use the real API. If any fix needs a new shape, sketch it once for the whole accepted set and the code around it: types, signatures, and module boundaries, with stub bodies. Stop at the sketch. Step 4 implements against it.

4. Implement the smallest root-cause fix in scope. Remove every named workaround.
   - Ask why until you reach the root cause. A workaround that needs a paragraph to justify it means the code is wrong; fix the code, not the comment.
   - Never bolt on symptom guards. A nil check that silences a crash is not a fix.
   - Redesign as if the real requirement had been there from the start, rather than patching around the old shape. Propagate the change through every reference in scope: types, call sites, tests, docs.
   - These rules guide intent only. They do not authorize widening the scope or fixing other instances outside it. Grep for the same pattern elsewhere and list those instances as open work instead.
   - If the root cause is out of scope, land the smallest in-scope fix and report the rest open.

5. Constraint comments say `do not remove`, `do not change wording`, or `talk to X before changing`. Leave keeps about things we cannot change. For the rest, offer the cheapest in-scope type, runtime check, test, or CI lint that enforces the constraint. Wait for interactive approval; unattended runs require the caller's approval up front. If approved, encode the constraint, then delete the comment. Otherwise delete the comment, report the constraint open, and sketch the out-of-scope work.

6. Report the deletion count, restored comments, reruns, sketch, fixes, encoding offers, encodings, unenforced constraints, and other open work.
