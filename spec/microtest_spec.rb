
require File.join(File.dirname(__FILE__), %w[spec_helper])

def reset_runner(runner)
  runner.suites = []
  runner.assertions = 0
  runner.passes = 0
  runner.failures = []
  runner.pendings = []
end

describe Microtest do
  describe "testing one success, one failure, two pendings, and one error" do
    before :all do
      class MyTest < Microtest::TestCase
        def test_true
          assert true
        end
        
        def test_false
          assert false
        end
        
        def test_error
          raise "error"
        end
        
        def test_pending
          pending "not yet implemented"
        end
        
        pending :test_still_not_implemented
      end
      @mtr = Microtest::Runner
      @mtr.run_tests
    end

    it "should return one suite" do
      @mtr.suites.size.should == 1
    end

    it "should return two assertions" do
      @mtr.assertions.should == 2
    end
  
    it "should return one pass" do
      @mtr.passes.should == 1
    end
  
    it "should return two failures" do
      @mtr.failures.size.should == 2
    end
  
    it "should return tow pendings" do
      @mtr.pendings.size.should == 2
    end
  end
end
# EOF
