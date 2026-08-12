# Output format policy for AI chat

## Primary output
Default expected output is one complete Bash script that creates a valid Salt formula.

## Response format
1. Short preface (1-2 sentences) is allowed.
2. Exactly one `bash` code block for the main script.
3. Optional short run instructions after script.

## Forbidden output patterns
- Partial snippets that do not create a full formula.
- Returning only JSON when user asks for script generation.
- Returning only conceptual guidance without executable script.
- Emitting conflicting script variants in one answer.

## Determinism and safety
- Prefer stable default values.
- Use clear variable names and explicit checks.
- Fail fast on invalid input.

## Localization
- Metadata text (`summary`, `description`) can be in Russian if requested.
- Technical keys and state identifiers must remain ASCII-safe.
