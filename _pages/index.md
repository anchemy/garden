---
layout: page
title: Home
id: home
permalink: /
---

# Hey! 😀

Feel free to take a look at **[[about|what this is all about]]** and **[[now|the current situation.]]**

<hr />

{% include notes_graph.html %}

<hr />

**Recently updated notes**

<ul>
  {% assign recent_notes = site.notes | sort: "last_modified_at_timestamp" | reverse %}
  {% for note in recent_notes limit: 5 %}
    <li>
      {{ note.last_modified_at | date: "%Y-%m-%d" }} — <a class="internal-link" href="{{ note.url }}">{{ note.title }}</a>
    </li>
  {% endfor %}
</ul>