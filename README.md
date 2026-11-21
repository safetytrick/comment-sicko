# comment-sicko

A Claude Code agent and skill that delete comments and push the code to explain itself instead. A workaround comment is treated as a confession: the comment goes, the code behind it gets flagged `MUST KILL`, and the root cause gets fixed.

- `agents/comment-sicko.md`: a fresh-context reviewer that deletes comments outside a short keep list and flags the symbols behind them. It never edits application code.
- `skills/no-comments/SKILL.md`: `/no-comments` runs the agent, audits its report, fixes the flagged root causes within the diff, and offers to turn "do not remove" comments into types, tests, or lint.

## Install

```sh
./install.sh
```

This symlinks both files into `~/.claude/agents/` and `~/.claude/skills/`, so edits here take effect right away. Existing files with the same names are left alone.

## Use

```
/no-comments                 # current diff against main, including the working tree
/no-comments src/billing/    # specific files or folders
```

## What it keeps

License headers, public API doc comments, issue or RFC links, `prettier-ignore`, and explanations of behavior forced by something you can't change (a vendor, platform, or protocol). When it's unsure, it deletes.

## Origin

Trimmed from [pstack](https://github.com/ahmedbenaw/pstack) (Lauren Tan's engineering-workflow skills, MIT). Changes from upstream:

- The skill spawns `comment-sicko`, matching the agent's name. Upstream asks for `"Comment Sicko"`, which doesn't match.
- The `/how` and `/why` skills are replaced by direct investigation (callers, `git log -L`, the introducing commit or PR).
- The `/architect` step is replaced by a one-pass sketch, which drops the dependency on `arena` and its multi-model config.
- The two principle skills it referenced (fix root causes, redesign from first principles) are folded into step 4.
- Python and Go suppressions are added to the agent's list.
