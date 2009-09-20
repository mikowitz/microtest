module Microtest
  module Reporter
    SETTINGS = {
      :color => false
    }

    def self.report!
      puts
      report_set(:failures)

      puts
      report_set(:errors)

      puts
      report_set(:pendings)

      puts
      puts ["#{Runner.assertions} assertions", 
            "#{Runner.failures.length} failures",
            "#{Runner.errors.length} errors",
            "#{Runner.pendings.length} pending tests"].join(", ")
    end
    

    private

    def self.report_set(set)
      puts "= = #{set.to_s} = ="
      Runner.send(set).each_with_index do |item, index|
        report_single(:whatever, item, index)
      end
    end

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