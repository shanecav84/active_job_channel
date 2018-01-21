module ActiveJobChannel
  class Error < StandardError; end

  class NoIdentifierError < ::ActiveJobChannel::Error
    MESSAGE = 'ActiveJobChannel expects an ActionCable Connection ' \
        'identifier to broadcast to. The identifier should be made available ' \
        'in your job via a method or an instance variable, either named ' \
        '`ajc_identifier`. For details about setting up an identifier in ' \
        'your ActionCable Connection, visit http://guides.rubyonrails.org/' \
        "action_cable_overview.html#connection-setup\n\nTo broadcast " \
        'globally without an identifier, pass in ' \
        '`{ global_broadcast: true } ` to `active_job_channel` as part of an ' \
        'options hash.'.freeze

    def initialize(msg = MESSAGE)
      super
    end
  end

  class UnnecessaryIdentifierError < ::ActiveJobChannel::Error
    MESSAGE = 'ActiveJobChannel has been configured to broadcast globally, ' \
        'but an `ajc_identifier` has been set. If the job information should ' \
        'be broadcast globally, remove the `ajc_identifier`. Otherwise, pass ' \
        'in `{ global_broadcast: true } ` to `active_job_channel` as part of ' \
        'an options hash'.freeze

    def initialize(msg = MESSAGE)
      super
    end
  end
end
