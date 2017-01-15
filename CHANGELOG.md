## NEXT
- Add URL to file inputs (This helps indicate that a file has actually been previously uploaded)
- Add Inviter name to invitation email when available
- Add hidden Integral version to the top of backend layout
- Backend now handles date and time pickers (add `datepicker` or `timepicker` class to the relevant input)
- Moved backend header and side navigation list items into seperate partials to allow for easy overridding
### Fixes
- Correct page URLs are now generated in the page listing
- Authorization fail redirection - now redirects user to backend_dashboard_path rather than root_path
- Include CKEditor Flat skin and extra plugins
### Dependancies
- Temporarily lock CKEditor to 4.2.0 until production asset digesting is fixed

## 0.1.2 (December 17, 2016)
Locked down open ended dependancies

Bugfixes:
  - Host applications now able to use Engines factories

## 0.1.1 (December 13, 2016)

Bugfixes:
  - Fixes WiceGrid filters with Turbolinks 5
Performance:
  - Reduces DB calls when rendering list items with an associated object
