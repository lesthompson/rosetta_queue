# Example:
# RosettaQueue::Filters.define do |filter_for|
#   filter_for.receiving { |message| JSON.parse(message) }
#   filter_for.sending { |hash| hash.to_json }
# end


module RosettaQueue
  class Filters

    class << self

      def define
        yield self
      end

      def reset
        @receiving = nil
        @sending = nil
      end

      def receiving(&receiving_filter)
        @receiving = receiving_filter
      end

      def sending(&sending_filter)
        @sending = sending_filter
      end

      def process_sending(message)
        return message unless @sending
        @sending.call(message)
      end

      def process_receiving(message)
        return message unless @receiving
        @receiving.call(message)
      end

      def safe_process_sending(message)
        safe(:process_sending, message)
      end

      def safe_process_receiving(message)
        safe(:process_receiving, message)
      end

      private

      def safe(filter_call, message)
        send(filter_call)
      rescue StandardError
        message
      end

    end
  end
end
