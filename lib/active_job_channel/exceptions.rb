module ActiveJobChannel
  class Error < StandardError; end

  class NoIdentifierError < ::ActiveJobChannel::Error
    attr_reader :job_class

    def initialize(job_class)
      @job_class = job_class
      super(generate_message)
    end

    private

    def generate_message
      'ActiveJobChannel has been configured to broadcast privately for ' \
        "#{job_class}, but an `ajc_identifier` has not been set. The " \
        'identifier should be made available in your job via a method or an ' \
        'instance variable, either named `ajc_identifier`. For details about ' \
        'setting up an identifier in your ActionCable Connection, visit ' \
        'http://guides.rubyonrails.org/' \
        "action_cable_overview.html#connection-setup\n\nTo broadcast " \
        'publically without an identifier, pass in ' \
        '`{ public_broadcast: true }` to `active_job_channel` as part of an ' \
        'options hash.'
    end
  end

  class UnnecessaryIdentifierError < ::ActiveJobChannel::Error
    attr_reader :job_class

    def initialize(job_class)
      @job_class = job_class
      super(generate_message)
    end

    private

    def generate_message
      'ActiveJobChannel has been configured to broadcast globally for ' \
        "#{job_class}, but an `ajc_identifier` has been set. If the job " \
        'information should be broadcast publically, remove the ' \
        '`ajc_identifier`. Otherwise, pass in `{ public_broadcast: true } ` ' \
        'to `active_job_channel` as part of an options hash'
    end
  end
end
