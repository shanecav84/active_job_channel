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
        "#{job_class}, but an `ajc_identifier` has not been set."
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
        "#{job_class}, but an `ajc_identifier` has been set."
    end
  end
end
