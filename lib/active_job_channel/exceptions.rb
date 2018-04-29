module ActiveJobChannel
  class Error < StandardError; end

  class NoIdentifierError < ::ActiveJobChannel::Error
    MESSAGE = 'ActiveJobChannel has been configured to broadcast privately ' \
        'for %<job_class>s, but an `ajc_identifier` has not been set.'.freeze

    def initialize(job_class)
      super(format MESSAGE, job_class: job_class)
    end
  end

  class UnnecessaryIdentifierError < ::ActiveJobChannel::Error
    MESSAGE = 'ActiveJobChannel has been configured to broadcast globally' \
      'for %<job_class>s, but an `ajc_identifier` has been set.'.freeze

    def initialize(job_class)
      super(format MESSAGE, job_class: job_class)
    end
  end
end
