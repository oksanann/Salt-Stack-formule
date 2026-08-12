# Generation flow checklist

Use this flow for every request.

## Step 1: parse request
- Extract formula name.
- Extract target OS list.
- Determine whether repository flow is required.
- Determine install strategy for Windows (if requested).

## Step 2: normalize targets
- Map Astra Linux -> Debian.
- Map ALT Linux -> RedHat.
- Keep Windows as Windows.

## Step 3: build script plan
- Define mandatory files.
- Define optional files (`map.jinja`, docs, repository states).
- Define state IDs and include order.

## Step 4: generate script
- Add strict Bash preamble.
- Validate input parameters.
- Generate directory tree.
- Write FORMULA, pillar.example, states, templates.

## Step 5: self-validation
- Verify required files exist.
- Verify metadata keys exist in FORMULA.
- Print created path and success message.

## Step 6: return answer
- Return one complete script.
- Add minimal run instructions.
