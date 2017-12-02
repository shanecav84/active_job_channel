# ActiveJobNotifier
Uses ActionCable to alert front-end users of finished ActiveJobs

## Requirements
* Persisted, asychronous [subscription adapter](http://guides.rubyonrails.org/action_cable_overview.html#subscription-adapter) -
Postgres or Redis

## Installation
1. Add to Gemfile

    ```ruby
    gem 'active_job_notifier'
    ```
2. Setup an [`ActionCable` adapter](http://edgeguides.rubyonrails.org/action_cable_overview.html#subscription-adapter)
3. Include the javascript in your layout

    ```ruby
    javascript_include_tag 'active_job_notifier/application'
    ```
    
## Usage
For each job you'd like to be notified about, enable `active_job_notifier`

```ruby
class MyJob < ActiveJob::Base
  active_job_notifier
end
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
