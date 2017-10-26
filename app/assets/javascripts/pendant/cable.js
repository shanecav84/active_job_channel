(function() {
  this.App || (this.App = {});

  App.pendant = ActionCable.createConsumer('cable/pendant');

}).call(this);
