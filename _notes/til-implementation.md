---
title: Today I Learned & Then I Learned Implementation
status: complete
topics:
    - changelog
    - learning-log
changelog_url: /changelogs/til-implementation/
---

# Today I Learned & Then I Learned Features

Your digital garden now has two new ways to view and track your learning journey!

## 🎯 Quick Overview

| Feature | URL | Purpose |
|---------|-----|---------|
| **Today I Learned** | `/til` | List all changelog entries from today |
| **Then I Learned** | `/til-archive` | Calendar view of all changelog entries with modal for busy days |

## 📅 Today I Learned (`/til`)

Shows what you learned and changed **today** in an easy-to-scan list format.

### Display Format
```
Changes made on December 2, 2025:
- Note Title - Changelog Entry Title
- Another Note - Another Entry Title
```

### How It Works
- The plugin scans all changelog files for entries with `date_updated` matching today's date
- Entries are displayed in the order they appear in the changelog files
- Perfect for daily reflection on what you've been working on

## 📊 Then I Learned (`/til-archive`) - Calendar View

A beautiful calendar showing your learning history across time.

### Key Features

#### 1. Calendar Display
- Current month calendar with entries for each day
- Dates with entries highlighted in light purple (#efefff)
- Dates without entries shown in light gray (#fafafa)

#### 2. Entry Previews
- Up to 3 entries shown per day
- Format: `Note Title - Entry Title`
- Small font to fit multiple entries in the calendar cell

#### 3. View More Modal
- When a day has **4 or more** entries, a "View More..." button appears
- Shows count: "View More... (2 more)" when 2 additional entries exist
- **Opens a modal** when clicked displaying all entries for that day

#### 4. Modal Interactions
Users can close the modal by:
- ✕ Clicking the X button in the top right corner
- Clicking outside the modal (semi-transparent background)
- Pressing the **Escape** key
- All interactions are intuitive and user-friendly

## 🔧 How to Use

### Step 1: Create a Changelog File
Create a file in `_changelogs/your-note-slug.md`:

```yaml
---
layout: changelog
title: Changelog - Your Note Title
note_title: Your Note Title
note_url: /your-note-slug/
permalink: /changelogs/your-note-slug/
---

{% include changelog_entry.html 
  title="First Change"
  date_published="2025-12-01"
  date_updated="2025-12-02"
  actions='[{"type": "Added", "description": "New feature"}]'
%}
```

### Step 2: Add Changelog Link to Note
Update your note's front matter:

```yaml
---
title: Your Note Title
changelog_url: /changelogs/your-note-slug/
---
```

### Step 3: Add Changelog Entries
Use the `changelog_entry` include for each change:

```liquid
{% include changelog_entry.html 
  title="What you changed"
  date_published="2025-12-01"
  date_updated="2025-12-02"
  actions='[
    {"type": "Added", "description": "What was added"},
    {"type": "Revised", "description": "What was revised"},
    {"type": "Deleted", "description": "What was deleted"}
  ]'
%}
```

### Important: Date Format
All dates must be in **ISO 8601 format**: `YYYY-MM-DD`
- ✓ Correct: `2025-12-02`
- ✗ Wrong: `12-02-2025` or `December 2, 2025`

## 📊 Behind the Scenes

### Plugin: `changelog_entries_extractor.rb`
This Jekyll plugin automatically:
1. **Scans** all files in `_changelogs/` directory
2. **Extracts** changelog entry data from Liquid templates
3. **Parses** dates from each entry
4. **Groups** entries by date (using `date_updated`)
5. **Stores** data in `site.data` for layouts to use

### Data Available
- `site.data.changelog_entries` - All entries sorted by date (newest first)
- `site.data.changelog_entries_by_date` - Entries grouped by date
- `site.data.today_changelog_entries` - Only today's entries

## 🎨 Styling

### Colors
- Purple accent: `#8b88e6`
- Light purple background: `#efefff`
- Light gray background: `#fafafa`

### Responsive Design
- Calendar is responsive and works on mobile
- Modal adjusts to screen size
- Touch-friendly on mobile devices

## 📝 Example

See these examples in your garden:
- [Example Note with Changelog](./example-note-with-changelog.md) - Shows changelog linking
- [Your first seed](./your-first-note.md) - Updated with changelog link
- [Your first note changelog](/changelogs/your-first-note/) - Live changelog example

These already have entries dated today (2025-12-02) so you can see them in action on the Today I Learned page!

## 🧪 Testing

### Test Today I Learned
1. Add a changelog entry with today's date
2. Visit `/til`
3. You should see your new entry listed

### Test Then I Learned
1. Visit `/til-archive`
2. Look for the current month calendar
3. Click any "View More..." button to test the modal
4. Press Escape to close the modal

## ❓ FAQ

**Q: How often does the data update?**
A: Every time you rebuild your Jekyll site. When developing locally, the plugin runs on each file save (with watch mode).

**Q: Can I view past months?**
A: Currently shows the current month. Future enhancement could add month navigation.

**Q: What happens if I have duplicate entries?**
A: Each unique entry in the changelog files is processed separately. Duplicates in source files will appear as duplicates.

**Q: Can entries span multiple dates?**
A: Entries are grouped by `date_updated` only. Each entry appears once on its update date.

**Q: How do I export/backup changelog data?**
A: All data is stored in your markdown files in `_changelogs/`. Regular git backups will preserve everything.

## 🚀 Advanced Tips

1. **Sort by Creation vs Update**: Currently sorts by `date_updated`. To sort by `date_published`, modify the plugin.

2. **Custom Date Ranges**: The plugin stores all dates; you could create additional layouts showing specific date ranges.

3. **Export to JSON**: The plugin could be extended to generate a JSON export of all entries.

4. **Weekly Digest**: Could create a layout showing entries from the past week.

## 📚 Related Docs

- [Changelog System Guide](./changelog-system-guide.md) - Detailed changelog setup
- [Today I Learned & Then I Learned Guide](./today-then-i-learned-guide.md) - Complete feature documentation
