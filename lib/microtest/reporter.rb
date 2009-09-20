module Microtest
  module Reporter
    SETTINGS = {
      :color => false
    }

    def self.report!
      puts
      Runner.failures.each_with_index {|f, i| report_single(:failure, f, i) }
      
      puts
      Runner.pendings.each_with_index {|p, i| report_single(:pending, p, i) }

      puts
      puts ["#{Runner.assertions} assertions", 
            "#{Runner.failures.select {|f| f.is_a?(TestFailure) }.length} failures",
            "#{Runner.failures.reject {|f| f.is_a?(TestFailure) }.length} errors",
            "#{Runner.pendings.length} pending tests"].join(", ")
    end
    

    private

    def self.report_single(type, reportee, number = 0)
      require 'pp'
      print "#{number + 1})  "
      if reportee.respond_to? :message
        puts "#{reportee.message} (#{reportee.class.name})"
      else
        puts reportee
      end
    end
  end
end