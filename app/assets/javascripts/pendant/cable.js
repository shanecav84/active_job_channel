//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.pendant_cable = ActionCable.createConsumer('cable/pendant');

}).call(this);
