module Pendant
  module WorkAsPendant
    module ClassMethods
      def work_as_pendant
        self.class_eval do
          after_perform :broadcase_success
        end

        include Pendant::WorkAsPendant::InstanceMethods
      end
    end

    module InstanceMethods
      def broadcase_success
        ActionCable.server.broadcast 'pendant_channel', status: 'success'
      end
    end
  end
end
