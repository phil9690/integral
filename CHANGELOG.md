## NEXT
- Add URL to file inputs (This helps indicate that a file has actually been previously uploaded)
- Backend now handles date and time picker (add `datepicker` or `timepicker` class to the relevant input)
- Fix incorrect page URLs being generated in the page listing
- Fix when authorization fails now redirects user to backend_dashboard_path rather than root_path

## 0.1.2 (December 17, 2016)
Locked down open ended dependancies

Bugfixes:
  - Host applications now able to use Engines factories

## 0.1.1 (December 13, 2016)

Bugfixes:
  - Fixes WiceGrid filters with Turbolinks 5
Performance:
  - Reduces DB calls when rendering list items with an associated object
