# ActiveJobNotifier
Uses ActionCable to alert front-end users of finished ActiveJobs

## Requirements
* Persisted, asychronous [subscription adapter](http://guides.rubyonrails.org/action_cable_overview.html#subscription-adapter) -
Postgres or Redis

## Usage
TBD

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'active_job_notifier'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install active_job_notifier
```

## Caveats
`ActiveJobNotifier` depends on `ActiveJob` and `ActionCable`, and, as such, is subject
to their limitations.

* A persisted, asynchronous [subscription adapter](http://guides.rubyonrails.org/action_cable_overview.html#subscription-adapter)
is required for `ActionCable` to handle notifications from background 
`ActiveJob` processes
* Because `ActiveJob` does not know when a job has permanently failed, 
`ActiveJobNotifier` sends notfications for each failure, retried or final

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
