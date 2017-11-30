//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.active_job_notifier_cable = ActionCable.createConsumer('/cable/active_job_notifier');

}).call(this);
