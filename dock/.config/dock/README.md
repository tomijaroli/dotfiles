# Dock Profiles

This directory stores Dock configuration profiles used by the Dock Profile Manager.

## Structure

```
.config/dock/
└── profiles/
    ├── dock-default.plist
    ├── dock-dev.plist
    └── dock-studio.plist
```

Each profile file represents an exported Dock layout.

## Naming Convention

Profiles **must** follow this pattern:

```
dock-<profile>.plist
```

Examples:
- `dock-default.plist`
- `dock-dev.plist`
- `dock-studio.plist`

## Usage

Switch profiles:

```bash
dock default
dock dev
dock studio
```

Export current Dock to a profile file:

```bash
dock-export default
```

## Behaviour
- Only the target profile is checked during switching
- Missing apps are detected & reported
- Dock restarts automatically after switch
- No backups are auto-created (profiles are tracked via Git)

## Tip
If you install new apps later, update profile with:

```bash
dock-export <profile>
```

This keeps your profiles clean and always synced with your system.
