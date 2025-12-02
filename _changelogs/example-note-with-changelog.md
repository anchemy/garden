---
layout: changelog
title: Changelog - Example Note with Changelog
note_title: Example Note with Changelog
note_url: /example-note-with-changelog/
permalink: /changelogs/example-note-with-changelog/
---

## Overview

This changelog tracks all changes made to the "Example Note with Changelog" note. Each entry documents what was added, revised, or deleted.

---

{% capture actions_1 %}
- type: Added
  description: Initial note creation
- type: Added
  description: Added changelog_url to front matter
{% endcapture %}

{% include changelog_entry.html 
  title="Initial Creation"
  date_published="2025-11-10"
  date_updated="2025-11-10"
  actions='[{"type": "Added", "description": "Initial note creation"}, {"type": "Added", "description": "Added changelog_url to front matter"}]'
%}

{% include changelog_entry.html 
  title="Added Documentation"
  date_published="2025-11-10"
  date_updated="2025-11-25"
  actions='[{"type": "Added", "description": "Added examples of how to use changelog feature"}, {"type": "Revised", "description": "Improved explanation text"}]'
%}

{% include changelog_entry.html 
  title="Fixed Formatting"
  date_published="2025-11-10"
  date_updated="2025-12-02"
  actions='[{"type": "Revised", "description": "Fixed code block formatting"}, {"type": "Added", "description": "Added visual improvements to changelog entries"}]'
%}
