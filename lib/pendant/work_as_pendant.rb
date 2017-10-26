module Pendant
  module WorkAsPendant
    module ClassMethods

      def work_as_pendant
        self.class_eval do
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
        PendantChannel.broadcast_to 'pendant_channel', status: 'failure'
      end

      def broadcast_success
        PendantChannel.broadcast_to 'pendant_channel', status: 'success'
      end
    end
  end
end
