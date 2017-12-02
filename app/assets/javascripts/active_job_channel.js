//= require action_cable

(function() {
  // Setup ActionCable connection
  this.App || (this.App = {});
  App.active_job_channel_cable = ActionCable.createConsumer('/cable/active_job_channel');

  // Setup up ActiveJobChannel received method
  this.ActiveJobChannel || (this.ActiveJobChannel = {});
  ActiveJobChannel.received = ActiveJobChannel.received || function(data) {
    var status = data.status;
    var job_name = data.job_name;
    if (status === 'success') { console.log(job_name + ' succeeded!'); }
    else if (status === 'failure') { console.log(job_name + ' failed!'); }
    else { console.error('Job status could not be determined'); }
  }

}).call(this);

// Setup ActionCable subscriber
document.addEventListener("DOMContentLoaded", function (_event) {
  const CHANNEL = "::ActiveJobChannel";
  App.active_job_channel = App.active_job_channel_cable.subscriptions.create(
    { channel: CHANNEL },
    { received: function (data) { ActiveJobChannel.received(data); } }
  );
});
