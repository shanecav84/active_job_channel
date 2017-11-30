require 'active_job_notifier/engine'
require 'active_job_notifier/notifier'

# Top-level namespace
module ActiveJobNotifier
end

ActiveJob::Base.send :extend, ActiveJobNotifier::Notifier::ClassMethods
