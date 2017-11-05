module Pendant
  module WorkAsPendant
    module ClassMethods

      def work_as_pendant(options = {})
        mattr_accessor(:job_name) { options[:job_name] }

        after_perform :broadcast_success
        rescue_from '::StandardError' do |exception|
          broadcast_failure
          raise exception
        end

        include Pendant::WorkAsPendant::InstanceMethods
      end
    end

    module InstanceMethods
      def broadcast_failure
        PendantChannel.broadcast_to(
          'pendant_channel',
          status: 'failure',
          job_name: self.class.job_name
        )
      end

      def broadcast_success
        PendantChannel.broadcast_to(
          'pendant_channel',
          status: 'success',
          job_name: self.class.job_name
        )
      end
    end
  end
end
