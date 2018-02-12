require 'active_job_channel/broadcaster'
require 'active_job_channel/engine'
require 'active_job_channel/exceptions'
require 'active_support/concern'

module ActiveJobChannel
  extend ActiveSupport::Concern
  include ::ActiveJobChannel::Broadcaster
end
