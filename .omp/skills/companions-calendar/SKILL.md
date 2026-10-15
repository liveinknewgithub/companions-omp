---
name: companions-calendar
description: Calendar for the companions — read/create/update/delete events. No Google connector ships with the omp pack; uses a calendar MCP if the session has one, else local .ics files in vault/calendar/. Never emit <cal_create>-style tags; nothing intercepts them.
---

# Calendar

There is no server intercepting tags here — `<cal_create>` and friends do nothing in omp. Never emit them.

## Source of truth, in order

1. **A calendar MCP/tool available in this session** (check your tool list). If present, use it for reads *and* writes.
2. **Local files**: `vault/calendar/*.ics` and `vault/calendar/events/*.ics`. Read with `read`/`grep` (`DTSTART`, `SUMMARY`). This is the fallback and the only option without an MCP.

## Rules

- Dates are `YYYY-MM-DD`, times `HH:MM` 24h. Duration defaults to 60 min; omit time for all-day.
- Ambiguous date → ask. Never guess a date to be helpful.
- **Confirm before creating or deleting** (describe title/date/time, wait for yes) — with either backend. Updates to time/duration: state the change, then apply.
- After a write, confirm in one line ("Done — added to your calendar."). Don't echo file contents or JSON back.

## Local .ics write format

Create `vault/calendar/events/YYYY-MM-DD-<slug>.ics`:

```
BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VEVENT
UID:YYYY-MM-DD-<slug>@companions
DTSTAMP:YYYYMMDDTHHMMSS
DTSTART:YYYYMMDDTHHMMSS
DTEND:YYYYMMDDTHHMMSS
SUMMARY:Title
DESCRIPTION:Optional notes
LOCATION:Optional
END:VEVENT
END:VCALENDAR
```

Delete = delete the file (after confirmation). Update = edit the fields in place. Set `DTSTAMP` from `date +%Y%m%dT%H%M%S`.
