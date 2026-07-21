# Seqera Containers Reference

Use this reference when operating `seqera containers` from an agent or automation loop.

## Primary repo docs

- `cli/src/containers/SKILL.md` — agent-oriented operating guidance
- `cli/docs/beta/containers.md` — command reference and examples

## Safety defaults

- Prefer `--dry-run` first for mutating operations.
- Never use `--freeze` without explicit user confirmation.
- Prefer explicit `--await <duration>` for long async jobs.
- Keep `--containerfile` and `--context` paths inside the repo/workspace.

## Output defaults

- Prefer `--json` for machine parsing.
- Use `--fields` to narrow responses.
- Use text output only when the user wants human-readable output.

## Recommended command flow

1. Discovery: `seqera containers --describe`
2. Dry run first: `seqera containers build ... --dry-run --json`
3. Execute for real after confirmation
4. Narrow output with `--fields`

## Command notes

### build

- Use exactly one source mode: `--image`, `--containerfile`, `--conda-*`, or `--cran-*`.
- If using `--context`, also provide `--containerfile`.

### inspect

- Prefer `--fields container.image,manifest.mediaType,config` for focused output.

### scan

- Prefer explicit severity filters for policy checks.
- Use `--await` and parse structured status fields.

### mirror

- Requires `--build-repo` and auth.
- Confirm destination registry before executing.

### logs

- Prefer `--json` if another tool consumes the output.

## Error handling

If a command used `--json`, parse structured error payload fields such as:
`error`, `hint`, `statusCode`, `detailsUri`, `reason`, and `requestId`.
