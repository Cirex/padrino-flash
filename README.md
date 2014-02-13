**Code merged into Padrino. This gem will no longer be maintained**

### Overview

Padrino Flash is a plugin for the [Padrino](https://github.com/padrino/padrino-framework) web framework which adds support for [Rails](https://github.com/rails/rails) like flash messages.

### Setup & Installation

Include it in your project's `Gemfile`:

``` ruby
gem 'padrino-flash'
```

Modify your `app/app.rb` file to register the plugin:

``` ruby
class ExampleApplication < Padrino::Application
  register Padrino::Flash
end
```

### Dependencies

* [Padrino-Core](https://github.com/padrino/padrino-framework) and [Padrino-Helpers](https://github.com/padrino/padrino-framework)
* [Ruby](http://www.ruby-lang.org/en) >= 1.8.7

### Copyright

Copyright &copy; 2012 Benjamin Bloch (Cirex). See LICENSE for details.
