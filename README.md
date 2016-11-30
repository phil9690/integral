# Integral [![Build Status](https://travis-ci.org/patricklindsay/integral.svg?branch=master)][travis-ci] [![Code Climate](https://codeclimate.com/github/patricklindsay/integral/badges/gpa.svg)][code-climate] [![Dependency Status](https://gemnasium.com/patricklindsay/integral.svg)][gemnasium] [![Inline docs](http://inch-ci.org/github/patricklindsay/integral.svg?branch=master)][inch-ci] [![Error Tracking](https://d26gfdfi90p7cf.cloudfront.net/rollbar-badge.144534.o.png)][roll-bar]

## Website in a box
This engine packages together  all the tools and utilities integral for the foundation of any website.

Backend features include;
* Styled with [Material Design][material-design] in mind using [Materialize-sass][materialize]
* User authentication & authorization
* Page & Post management with full [WYSWIYG editing][ckeditor]
* Image management
* List management
* Settings management
* Turbolinks 5

Frontend features include;
* Styled with [Foundation 6][foundation]
* SEO Ready
* Turbolinks 5

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'integral'
```

And then execute:

    $ bundle

    Or install it yourself as:

        $ gem install integral

## Usage

1. TODO

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patricklindsay/integral. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

### Future works
* Super admin (able to view & undelete soft-deleted items)
* Improved image management
* Delayed image compression
* Fully dynamic page routing (no restart required for Heroku)
* Backend Auditing (Who did what now?)
* Handle multi-user (Object Locking)
* Improved backend UI - Navigation should be at least partially visible on medium/large screens at all times
* Improved backend UI - Dashboard should contain stats and information

### Technical Debt
* Move list models into subfolder
* Tidy up implementation and create full specs for ListRenderer & ListItemRenderer
* Feature specs for all controller actions at the minimum checking for 200 status
* Add specs for frontend controllers
* Add specs for all configuration options
* All TODOs :)

##

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[material-design]: https://www.google.com/design/spec/material-design/introduction.html
[materialize]: https://github.com/mkhairi/materialize-sass
[roll-bar]: https://rollbar.com
[travis-ci]: https://travis-ci.org/patricklindsay/integral
[code-climate]: https://codeclimate.com/github/patricklindsay/integral
[inch-ci]: http://inch-ci.org/github/patricklindsay/integral
[gemnasium]: https://gemnasium.com/patricklindsay/integral
[foundation]: http://foundation.zurb.com/sites
[ckeditor]: http://ckeditor.com
