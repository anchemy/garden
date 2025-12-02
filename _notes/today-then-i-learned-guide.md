---
title: Today I Learned & Then I Learned Guide
status: draft
topics:
    - documentation
---

# Today I Learned & Then I Learned Features

## Overview

The "Today I Learned" and "Then I Learned" features provide views of your changelog entries over time, helping you track what you've learned and changed across your digital garden.

- **Today I Learned** (`/til`) - Shows all changelog entries updated today
- **Then I Learned** (`/til-archive`) - Calendar view of all changelog entries with a modal for dates with 3+ entries

## How It Works

### Automatic Data Extraction

The `changelog_entries_extractor.rb` plugin automatically:

1. **Scans all changelog files** in the `_changelogs/` directory
2. **Extracts changelog entries** from the Liquid template syntax
3. **Parses dates** from each entry (date_published and date_updated)
4. **Groups entries by date** for the calendar view
5. **Identifies today's entries** for the Today I Learned page

### Data Structure

Each extracted changelog entry contains:
- `note_title` - The title of the note being tracked
- `entry_title` - The title of the changelog entry
- `date_published` - When the change was first published
- `date_updated` - When the change was last updated
- `sort_date` - Used for sorting (defaults to date_updated)

## Today I Learned (`/til`)

### What It Shows

A simple list of changelog entries updated on the current date, formatted as:

```
- Note Title - Changelog Entry Title
- Another Note - Another Entry
```

### Example

If you have these changelog entries with `date_updated="2025-12-02"`:
- "Example Note with Changelog" - "Fixed Formatting"
- "Your first seed" - "Improved examples and formatting"
- "Your first seed" - "Added navigation improvements"
- "Your first seed" - "Revised code examples"

The Today I Learned page will display:
```
Changes made on December 2, 2025:
- Example Note with Changelog - Fixed Formatting
- Your first seed - Improved examples and formatting
- Your first seed - Added navigation improvements
- Your first seed - Revised code examples
```

## Then I Learned (`/til-archive`)

### What It Shows

A calendar view of the current month with all changelog entries. Each calendar cell shows:
- **Date number** (bold)
- **Changelog entries** as a list of "Note Title - Entry Title"
- **View More button** (if 3+ entries) - shows a "View More..." link with count

### Calendar Features

1. **Visual Highlighting**
   - Dates with entries have a light purple background (#efefff)
   - Dates without entries have a light gray background (#fafafa)
   - Days from other months are grayed out

2. **Entry Display**
   - Shows up to 3 entries per day in the calendar cell
   - If 3+ entries exist, a "View More..." button appears
   - Button shows count of additional entries: "View More... (X more)"

3. **Modal for Additional Entries**
   - Clicking "View More..." opens a modal dialog
   - Modal displays all entries for that date
   - Shows entry title, note title, and date range

### Modal Interactions

Users can close the modal by:
- **Clicking the X button** in the top right corner
- **Clicking outside** the modal (on the semi-transparent background)
- **Pressing the Escape key**

### Example Calendar Display

```
If December 2, 2025 has 5 entries:

Calendar cell shows:
  2
  Example Note - Fixed Formatting
  Your first seed - Improved examples
  Your first seed - Added navigation
  View More... (2 more)

Clicking "View More..." opens modal with all 5 entries:
  December 2, 2025
  ─────────────────
  ✕
  
  [Entry 1] Example Note - Fixed Formatting
  [Entry 2] Your first seed - Improved examples
  [Entry 3] Your first seed - Added navigation
  [Entry 4] Your first seed - Revised code
  [Entry 5] Another Note - Some change
```

## How to Create Changelog Entries

### Step 1: Add changelog_url to Your Note

Update your note's front matter:

```yaml
---
title: Your Note Title
changelog_url: /changelogs/your-note-slug/
---
```

### Step 2: Create a Changelog File

Create `_changelogs/your-note-slug.md`:

```yaml
---
layout: changelog
title: Changelog - Your Note Title
note_title: Your Note Title
note_url: /your-note-slug/
permalink: /changelogs/your-note-slug/
---

{% include changelog_entry.html 
  title="Entry Title"
  date_published="2025-12-01"
  date_updated="2025-12-02"
  actions='[{"type": "Added", "description": "What was added"}]'
%}
```

### Step 3: Add Changelog Entries

Use the `changelog_entry` include with:
- `title` - Changelog entry title
- `date_published` - Initial publish date (YYYY-MM-DD)
- `date_updated` - Last update date (YYYY-MM-DD)
- `actions` - JSON array of action objects

The `date_updated` field determines when the entry appears in Today I Learned and the calendar.

## Date Format

All dates in changelog entries must be in **ISO 8601 format**: `YYYY-MM-DD`

Examples:
- `2025-12-02` ✓ Correct
- `12-02-2025` ✗ Incorrect
- `December 2, 2025` ✗ Incorrect

## Files

### Created Files
- `_plugins/changelog_entries_extractor.rb` - Plugin to extract and organize changelog data
- `_layouts/today-i-learned.html` - Layout for Today I Learned page
- `_layouts/then-i-learned.html` - Layout for Then I Learned calendar (modified)

### Updated Files
- `_layouts/note.html` - Added changelog link to note header

## Tips & Best Practices

1. **Update Dates Consistently** - Use `date_updated` to control when entries appear
2. **Group Related Changes** - Multiple related changes can be one entry with multiple actions
3. **Regular Updates** - Update `date_updated` when you modify an entry
4. **Clear Titles** - Use descriptive entry titles that explain the change at a glance
5. **Test Today's Entries** - Add a changelog entry with today's date to see it appear in Today I Learned

## Troubleshooting

### Entries Not Appearing

1. Check that changelog files are in `_changelogs/` directory
2. Verify front matter has correct `layout: changelog`
3. Ensure dates are in YYYY-MM-DD format
4. Confirm `note_title` matches what you want displayed

### Calendar Not Loading

1. Rebuild your Jekyll site
2. Check browser console for JavaScript errors
3. Verify modal HTML is being generated
4. Clear browser cache

### Modal Not Opening

1. Check that entry count is 4 or more for the date
2. Verify JavaScript isn't blocked
3. Check browser console for errors
4. Try pressing Escape to see if modal is open but invisible
