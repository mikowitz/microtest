module Microtest
  class TestFailure < StandardError; end
  
  module Assertions
    def assert(what, message = nil)
      Runner.assertions += 1
      what ? _pass : _fail(message)
    end
    
    def assert_not(what, message = nil)
      assert(!(what), message)
    end
    
    def assert_true(val, message = nil); assert(!!(val), message); end
    def assert_false(val, message = nil); assert_not(!!(val), message); end
    
    def assert_block(message = nil) 
      assert(yield, message)
    end
    
    def assert_empty(object, message = nil)
      assert(object.empty?, message)
    end
    
    def assert_nil(object, message = nil)
      assert(object.nil?, message)
    end
    
    def assert_equal(expected, actual, message = nil)
      assert((expected == actual), message)
    end    
  end
  
  class TestCase
    include Assertions
    
    def setup
    end
    
    def teardown
    end
    
    def _pass
      Color.green(".")
      Runner.passes += 1
    end
    
    def _fail(message)
      Color.red("F")
      raise TestFailure.new(message || "FAIL")
    end
    alias flunk _fail

    def _pending(message = "")
      Color.cyan("-")
      Runner.pendings << message.to_s
    end
    alias pending _pending
    
    def _run
      begin
        _do_or_die { setup }

        _test_methods.each do |m|
          _do_or_die { send(m) }
        end
      ensure
        _do_or_die { teardown }
      end
    end
    
    def self.inherited(klass)
      Runner.suites << klass.new
    end
    
  private    
    def _do_or_die
      begin
        yield
      rescue Exception => e
        _die(e)
      end
    end
  
    def _die(error)
      if error.is_a? TestFailure
        Runner.failures << error
      else
        Color.yellow("*")
        Runner.errors << error
      end
    end

    def _test_methods
      self.class.public_instance_methods(true).grep(/^test_/)
    end
  end
  
  class Runner
    def self.suites; @suites ||= []; end
    def self.suites=(val); @suites = val; end
    
    def self.passes; @passes ||= 0; end
    def self.passes=(val); @passes = val; end
    
    def self.failures; @failures ||= []; end
    def self.failures=(val); @failures = val; end
    
    def self.errors; @errors ||= []; end
    def self.errors=(val); @erros = []; end

    def self.pendings; @pendings ||= []; end
    def self.pendings=(val); @pendings = val; end

    def self.assertions; @assertions ||= 0; end
    def self.assertions=(val); @assertions = val; end
    
    def self.run_tests
      @suites.each do |suite|
        suite._run
      end
      report!
    end
    
    def self.report!
      Reporter.report!
    end
  end
end