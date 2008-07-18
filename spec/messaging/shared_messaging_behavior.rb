module Messaging

  describe "a messaging gateway object", :shared => true do

    describe ".unsubscribe" do
      
      def do_process
        @gateway.unsubscribe
      end
      
      it "should unsubscribe from a destination" do
        during_process { @gateway.should_receive("unsubscribe") }
      end      
    end
    
    describe ".disconnect" do
      
      def do_process
        @gateway.disconnect
      end
      
      it "should disconnect from a destination" do
        during_process { @gateway.should_receive("disconnect") }
      end
    end    

    it "should subscribe to a destination" do
      @gateway.class.destination.should == :test_queue
    end

    it "should unsubscribe from a destination" do
      @gateway.class.destination.should == :test_queue
    end

    describe "stomp client headers" do

      it "should receive a hash" do
        @gateway.class.headers.should == @headers
      end

    end
  end
end