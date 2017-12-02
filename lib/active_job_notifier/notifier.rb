module ActiveJobNotifier
  module Notifier
    module ClassMethods
      def active_job_notifier
        after_perform :broadcast_success
        rescue_from '::StandardError' do |exception|
          broadcast_failure
          raise exception
        end

        include ActiveJobNotifier::Notifier::InstanceMethods
      end
    end

    module InstanceMethods
      def broadcast_failure
        ActiveJobNotifierChannel.broadcast_to(
          'active_job_notifier_channel',
          status: 'failure',
          job_name: self.class.to_s
        )
      end

      def broadcast_success
        ActiveJobNotifierChannel.broadcast_to(
          'active_job_notifier_channel',
          status: 'success',
          job_name: self.class.to_s
        )
      end
    end
  end
end
