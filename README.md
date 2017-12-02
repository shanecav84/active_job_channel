# `ActiveJobChannel`
Uses `ActionCable` to alert front-end users of finished `ActiveJobs`

## Installation
1. Install in your Gemfile

    ```ruby
    gem 'active_job_channel'
    ```

2. Setup an [`ActionCable` subscription adapter](http://edgeguides.rubyonrails.org/action_cable_overview.html#subscription-adapter)
    * Note: A persisted subscription adapter is required for handling notifications
    from background `ActiveJob` processes. Currently only PostgreSQL and Redis
    are supported.

3. Include `active_job_channel.js` in your layouts

    ```ruby
    javascript_include_tag 'active_job_channel'
    ```

    or include it in your `app/assets/javascripts/application.js`

    ```javascript
      //= require active_job_channel
    ```

## Usage
For each job you'd like to be notified about, enable `active_job_channel`

```ruby
class MyJob < ActiveJob::Base
  active_job_channel
end
```

To customize the client-side notification, define `ActiveJobChannel.received`
after including `active_job_channel.js`. The current default simply logs the 
job status to the javascript console.

```javascript
  //= require notifyjs
  //= require active_job_channel

  ActiveJobChannel.received = function(data) {
    var status = data.status;
    var job_name = data.job_name;
    if (status === 'success') { $.notify(job_name + ' succeeded!') }
    else if (status === 'failure') { $.notify(job_name + ' failed!') }
  }
```

## Caveats
`ActiveJobChannel` depends on `ActiveJob` and `ActionCable`, and, as such, is
subject to their limitations:

* A persisted [subscription adapter](http://guides.rubyonrails.org/action_cable_overview.html#subscription-adapter)
is required for `ActionCable` to handle notifications from background 
`ActiveJob` processes
* Because `ActiveJob` does not know when a job has permanently failed, 
`ActiveJobChannel` sends notfications for each failure, retried or final

## Todo
- Handle connection authorization
- Better default front-end notification behavior

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
