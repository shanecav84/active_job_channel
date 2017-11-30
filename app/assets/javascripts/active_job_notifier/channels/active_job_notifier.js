document.addEventListener("DOMContentLoaded", function (_event) {
  const CHANNEL = "::ActiveJobNotifierChannel";
  console.log('Subscribing to ' + CHANNEL);

  App.active_job_notifier = App.active_job_notifier_cable.subscriptions.create(
    {
      channel: CHANNEL
    },
    {
      connected: function () {
        // Called when the subscription is ready for use on the server
        console.log('Successfully connected to ' + CHANNEL);
      },

      disconnected: function () {
        // Called when the subscription has been terminated by the server
        console.log('Successfully disconnected from ' + CHANNEL);
      },

      received: function (data) {
        // Called when there's incoming data on the websocket for this channel
        console.log('Successfully received data from ' + CHANNEL);
        var status = data.status;
        var job_name = data.job_name;
        if (status === 'success') { console.log(job_name + ' completed'); }
        else if (status === 'failure') { console.log(job_name + ' failed'); }
        else { console.error('Job status could not be determined'); }
      }
    }
  );
});
