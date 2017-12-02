# `ActiveJobNotifier`
Uses `ActionCable` to alert front-end users of finished `ActiveJobs`

## Requirements
* `ActionCable`
    * Persisted [subscription adapter](http://guides.rubyonrails.org/action_cable_overview.html#subscription-adapter) -
    currently only PostgreSQL and Redis are supported
* `ActiveJob`

## Installation
1. Install in your Gemfile

    ```ruby
    gem 'active_job_notifier'
    ```

2. Setup an [`ActionCable` subscription adapter](http://edgeguides.rubyonrails.org/action_cable_overview.html#subscription-adapter)
3. Include `active_job_notifier.js` in your layouts

    ```ruby
    javascript_include_tag 'active_job_notifier'
    ```

    or include it in your `app/assets/javascripts/application.js`

    ```javascript
      //= require active_job_notifer
    ```

## Usage
For each job you'd like to be notified about, enable `active_job_notifier`

```ruby
class MyJob < ActiveJob::Base
  active_job_notifier
end
```

To customize the client-side notification, define `ActiveJobNotifer.notify`
after including `active_job_notifer.js`

```javascript
  //= require notifyjs
  //= require active_job_notifier

  ActiveJobNotifer.notify = function(data) {
    var status = data.status;
    var job_name = data.job_name;
    if (status === 'success') { $.notify(job_name + ' succeeded!') }
    else if (status === 'failure') { $.notify(job_name + ' failed!') }
  }
```

## Caveats
`ActiveJobNotifier` depends on `ActiveJob` and `ActionCable`, and, as such, is
subject to their limitations:

* A persisted[subscription adapter](http://guides.rubyonrails.org/action_cable_overview.html#subscription-adapter)
is required for `ActionCable` to handle notifications from background 
`ActiveJob` processes
* Because `ActiveJob` does not know when a job has permanently failed, 
`ActiveJobNotifier` sends notfications for each failure, retried or final

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
