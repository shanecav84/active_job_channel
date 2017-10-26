const CHANNEL = "PendantChannel"

document.addEventListener("DOMContentLoaded", function(_event) {
  App.pendant = App.cable.subscriptions.create({ channel: CHANNEL },
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
        console.log('Successfully received data from' + CHANNEL);
        console.log(data);
      }
    }
  );
});
