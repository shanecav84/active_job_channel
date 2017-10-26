(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer('cable/pendant');

}).call(this);
