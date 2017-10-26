module Pendant
  module WorkAsPendant
    module ClassMethods

      def work_as_pendant
        class_eval do
          after_perform :broadcast_success
          rescue_from '::StandardError' do |exception|
            broadcast_failure
            raise exception
          end
        end

        include Pendant::WorkAsPendant::InstanceMethods
      end
    end

    module InstanceMethods
      def broadcast_failure
        PendantChannel.broadcast_to(
          'pendant_channel',
          status: 'failure',
          job_id: job_id
        )
      end

      def broadcast_success
        PendantChannel.broadcast_to(
          'pendant_channel',
          status: 'success',
          job_id: job_id
        )
      end
    end
  end
end
