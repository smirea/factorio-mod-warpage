Modules are a way of co-locating prototypes (data.ts), behavior (control.ts), shareable constants (constants.ts) and any other functionality pertraining to a particular feature or concept. It's meant to keep things organized and standardized where possible but we don't need to force it

Each module folder can contain:
- `data.ts` For defining any entity, technology, prototype etc. included in the data stage, must be imported inside `src/data.ts`
- `control.ts` for defining behavior, events or any other business logic. runtime stage, must be imported inside `src/control.ts` (see `src/utils.ts` for event utilities that help separate events by modules)
- `data-final-fixes.ts` and `data-updates.ts` are the other common factorio data stages, which also need to be imported in their respective `src/*.ts` file
