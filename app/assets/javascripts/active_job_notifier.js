//= require action_cable

(function() {
  // Setup ActionCable connection
  this.App || (this.App = {});
  App.active_job_notifier_cable = ActionCable.createConsumer('/cable/active_job_notifier');

  // Setup up ActiveJobNotifer notifier method
  this.ActiveJobNotifier || (this.ActiveJobNotifier = {});
  ActiveJobNotifier.notify = ActiveJobNotifier.notify || function(data) {
    var status = data.status;
    var job_name = data.job_name;
    if (status === 'success') { console.log(job_name + ' succeeded!'); }
    else if (status === 'failure') { console.log(job_name + ' failed!'); }
    else { console.error('Job status could not be determined'); }
  }

}).call(this);

// Setup ActionCable subscriber
document.addEventListener("DOMContentLoaded", function (_event) {
  const CHANNEL = "::ActiveJobNotifierChannel";
  App.active_job_notifier = App.active_job_notifier_cable.subscriptions.create(
    { channel: CHANNEL },
    { received: function (data) { ActiveJobNotifier.notify(data); } }
  );
});
