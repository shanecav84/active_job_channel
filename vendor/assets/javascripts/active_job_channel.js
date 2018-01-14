//= require action_cable

(function() {
  // Setup ActionCable connection
  this.App || (this.App = {});
  App.cable = ActionCable.createConsumer('/cable/active-job-channel');

  // Setup up ActiveJobChannel object
  this.ActiveJobChannel || (this.ActiveJobChannel = {});
  ActiveJobChannel.onJobSuccess = ActiveJobChannel.onJobSuccess || function(job) {};
  ActiveJobChannel.onJobFailure = ActiveJobChannel.onJobFailure || function(job) {};
  ActiveJobChannel.onUnknownJobStatus = ActiveJobChannel.onUnknownJobStatus || function(job) {};
  ActiveJobChannel.received = ActiveJobChannel.received || function(job) {
    var status = job.status;
    if (status === 'success') { ActiveJobChannel.onJobSuccess(job); }
    else if (status === 'failure') { ActiveJobChannel.onJobFailure(job); }
    else { ActiveJobChannel.onUnknownJobStatus(job); }
  }
}).call(this);

// Setup ActionCable subscriber
document.addEventListener("DOMContentLoaded", function (_event) {
  const CHANNEL = "::ActiveJobChannel::Channel";
  App.activeJobChannel = App.cable.subscriptions.create(
    { channel: CHANNEL },
    { received: function (job) { ActiveJobChannel.received(job); } }
  );
});
