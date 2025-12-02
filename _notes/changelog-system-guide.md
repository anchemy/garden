---
title: Changelog System Guide
status: draft
topics:
    - documentation
---

# Changelog System for Your Digital Garden

## Overview

The changelog system allows you to document all changes made to your notes over time. Each note can have an associated changelog that tracks what was added, revised, or deleted.

## Structure

### 1. Note Front Matter

Add a `changelog_url` field to your note's front matter to link it to a changelog:

```yaml
---
title: Your Note Title
status: wip
topics:
    - your-topic
changelog_url: /changelogs/your-note-slug/
---
```

The `changelog_url` should point to where your changelog page will be published.

### 2. Changelog File Location

Create changelog files in the `_changelogs/` directory:

```
_changelogs/
  ├── your-first-note.md
  ├── example-note.md
  └── another-note.md
```

### 3. Changelog Front Matter

Each changelog file should have the following front matter:

```yaml
---
layout: changelog
title: Changelog - Your Note Title
note_title: Your Note Title
note_url: /your-note-slug/
permalink: /changelogs/your-note-slug/
---
```

- `layout`: Always use `changelog`
- `title`: The title of the changelog page
- `note_title`: The title of the associated note
- `note_url`: The URL to the associated note
- `permalink`: The URL where the changelog will be published

### 4. Changelog Entry Structure

Changelog entries are created using the `changelog_entry` include component. Each entry can contain multiple actions:

```liquid
{% include changelog_entry.html 
  title="Entry Title"
  date_published="2025-11-15"
  date_updated="2025-11-20"
  actions='[
    {"type": "Added", "description": "Description of what was added"},
    {"type": "Revised", "description": "Description of what was revised"},
    {"type": "Deleted", "description": "Description of what was deleted"}
  ]'
%}
```

#### Parameters:

- `title` (string): The title of this changelog entry
- `date_published` (date): When this change was first published (YYYY-MM-DD format)
- `date_updated` (date): When this change was last updated (YYYY-MM-DD format)
- `actions` (JSON array): Array of action objects

#### Action Types:

- **Added**: Use when new content or features are introduced
- **Revised**: Use when existing content is modified or improved
- **Deleted**: Use when content or features are removed

### 5. Example Changelog Entry

```liquid
{% include changelog_entry.html 
  title="Initial Publication" 
  date_published="2025-11-10"
  date_updated="2025-11-10"
  actions='[
    {"type": "Added", "description": "Initial note creation"},
    {"type": "Added", "description": "Added basic structure"}
  ]'
%}

{% include changelog_entry.html 
  title="Expanded Examples" 
  date_published="2025-11-10"
  date_updated="2025-11-25"
  actions='[
    {"type": "Added", "description": "Added more detailed examples"},
    {"type": "Revised", "description": "Improved explanation clarity"}
  ]'
%}

{% include changelog_entry.html 
  title="Fixed Typos" 
  date_published="2025-11-10"
  date_updated="2025-12-02"
  actions='[
    {"type": "Revised", "description": "Fixed typos in code blocks"},
    {"type": "Deleted", "description": "Removed outdated information"}
  ]'
%}
```

## How It Works

1. **On the Note**: The note displays "Created on {Date} | Updated on {Date} | Changelog" in the header
2. **Clicking the Changelog Link**: Takes you to the note's changelog page
3. **On the Changelog**: Shows all entries documenting changes to the note over time
4. **Back Link**: A "Back to note" link on the changelog allows easy navigation back

## Visual Design

- Changelog entries have a light gray background with a purple left border
- Each action is displayed in its own box with the action type highlighted in purple
- Dates are formatted as "Month Day, Year" for consistency
- The layout is responsive and follows your garden's design system

## Tips

1. **Keep Entries Organized**: Group related changes in a single entry
2. **Use Clear Descriptions**: Make it easy for readers to understand what changed
3. **Consistent Dates**: Use ISO format (YYYY-MM-DD) for dates to ensure proper parsing
4. **Link to Notes**: The changelog automatically links back to the note
5. **Multiple Actions**: You can have as many actions as needed in one entry

## Files Modified/Created

- `_layouts/changelog.html` - Layout for changelog pages
- `_includes/changelog_entry.html` - Component for individual changelog entries
- `_changelogs/` - Directory for changelog files
- `_layouts/note.html` - Updated to include changelog link
