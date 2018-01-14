# ActiveJobChannel
Use ActionCable to alert front-end users of finished ActiveJobs

## Installation
1. Install in your Gemfile

    ```ruby
    gem 'active_job_channel'
    ```

## Setup
1. [Create ActionCable Connection](#create-actioncable-connection-optional) (optional)
2. [Enable ActiveJobChannel for a job](#enable-activejobchannel-for-a-job)
3. [Handle ActiveJobChannel broadcasts](#handle-activejobchannel-broadcasts)

### Create ActionCable Connection (optional)

You can skip this step if you're not concerned with authorizing or brodcasting 
privately to ActionCable connections

1. Setup an [ActionCable subscription adapter](http://edgeguides.rubyonrails.org/action_cable_overview.html#subscription-adapter)
    * Note: A persisted subscription adapter is required for handling notifications
    from background ActiveJob processes. Currently only PostgreSQL and Redis
    are supported.
2. Follow the [official guide for setting up an ActionCable Connection](http://guides.rubyonrails.org/action_cable_overview.html#server-side-components-connections)
3. If you would like notifications broadcast privately to ActionCable 
    connections, set up a connection identifier for your connection using 
    `identified_by`. The identifier you use will also need to be passed to your 
    job.

### Enable ActiveJobChannel for a job
1. For each job you'd like to be notified about, call `active_job_channel` in 
    its class
2. To broadcast notifications privately, set the identifier you configured in
    your ActionCable Connection setup to either the instance variable 
    `@ajc_identifier` or the method `ajc_identifier`

```ruby
class MyJob < ActiveJob::Base
  active_job_channel

  def perform(current_user)
    @ajc_identifier = current_user
  end

  private

  # def ajc_identifier
  #   User.find_by(key: value)
  # end
end
```

#### Configuration

##### global_broadcast

Notifications will be broadcast to `ajc_identifier` by default. To broadcast
all notifications for a job to all ActionCable connections, pass 
`{ global_broadcast: true }` to `active_job_channel`.

### Handle ActiveJobChannel broadcasts

1. Include `active_job_channel.js` in your layouts

    ```ruby
    javascript_include_tag 'active_job_channel'
    ```

    or include it in your `app/assets/javascripts/application.js`

    ```javascript
      //= require active_job_channel
    ```

2. Customize the callbacks for broadcasted notifications:

    ```javascript
    //= require notifyjs

    ActiveJobChannel.onJobSuccess = function(job) { $.notify(job.name + ' succeeded!') }; 
    ActiveJobChannel.onJobFailure = function(job) { $.notify(job.name + ' failed!') };
    ```

    `job` has the attributes `name` and `status`. A failed `job` includes an 
    `error` attribute. `status` is one of `success` or `failure`. 


## Caveats
ActiveJobChannel depends on ActiveJob and ActionCable, and, as such, is
subject to their limitations:

* A persisted [subscription adapter](http://guides.rubyonrails.org/action_cable_overview.html#subscription-adapter)
is required for ActionCable to handle notifications from background 
ActiveJob processes
* Because ActiveJob does not know when a job has permanently failed, 
ActiveJobChannel sends notfications for each failure, retried or final

## Todo
- Better default front-end notification behavior

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
