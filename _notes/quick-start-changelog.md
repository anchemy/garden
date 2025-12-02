---
title: Getting Started with Changelog Features
status: draft
topics:
    - guides
    - changelog
---

# Quick Start: Today I Learned & Then I Learned

## 🚀 30-Second Setup

1. **Add to your note's front matter:**
   ```yaml
   changelog_url: /changelogs/your-note-slug/
   ```

2. **Create `_changelogs/your-note-slug.md`:**
   ```yaml
   ---
   layout: changelog
   title: Changelog - Your Note Title
   note_title: Your Note Title
   note_url: /your-note-slug/
   permalink: /changelogs/your-note-slug/
   ---

   {% include changelog_entry.html 
     title="What Changed"
     date_published="2025-12-02"
     date_updated="2025-12-02"
     actions='[{"type": "Added", "description": "New feature"}]'
   %}
   ```

3. **Done!** Entries will now appear in:
   - `/til` - Today I Learned page (for today's entries)
   - `/til-archive` - Then I Learned calendar (all entries)

## 📍 Two Views

### Today I Learned (`/til`)
- Shows entries from **today only**
- Simple bullet list format: `Note Title - Entry Title`
- Perfect for daily reflection

### Then I Learned (`/til-archive`)
- Calendar view of **current month**
- Entries colored with light purple background
- Up to 3 entries per day in calendar
- Click "View More..." to see all entries for busy days
- Modal closes with X, Escape, or outside click

## 🎯 Key Requirements

### Date Format
**Must be**: `YYYY-MM-DD`
- ✓ `2025-12-02` 
- ✗ `12-02-2025`

### Action Types
- `Added` - New content/features
- `Revised` - Modified/improved content
- `Deleted` - Removed content

## 📚 Examples in Your Garden

Already set up and ready to explore:
- **Your first seed** - Note with changelog
- **Example Note with Changelog** - Another example
- **Then I Learned** - View the calendar to see entries

Visit `/til` today to see what's been learned!

## 🔗 Full Documentation

- [Changelog System Guide](./changelog-system-guide.md)
- [Today I Learned & Then I Learned Guide](./today-then-i-learned-guide.md)
- [Implementation Details](./til-implementation.md)

## ⚙️ How It Works

A Jekyll plugin (`changelog_entries_extractor.rb`) automatically:
1. Scans all changelog files
2. Extracts entry titles and dates
3. Groups by date
4. Makes available to layouts

No manual configuration needed after initial setup!
