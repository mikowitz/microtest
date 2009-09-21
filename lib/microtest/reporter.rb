module Microtest
  module Reporter
    SETTINGS = {
      :show_colors => true
    }

    COLORS = {
      :failures => :red,
      :errors => :yellow,
      :pendings => :cyan
    }

    def self.report!
      puts

      report_set(:failures)
      report_set(:errors)
      report_set(:pendings)

      puts
      Color.send(self.results_color, self.full_results)
      puts
    end
    

    private

    def self.results_color
      if Runner.failures.empty?
        if Runner.errors.empty?
          if Runner.pendings.empty?
            :green
          else
            :cyan
          end
        else
          :yellow
        end
      else
        :red
      end
    end

    def self.full_results
      ["#{Runner.assertions} assertions",
                      "#{Runner.failures.length} failures",
                      "#{Runner.errors.length} errors",
                      "#{Runner.pendings.length} pending tests"
                      ].join(", ")

    end

    def self.report_set(set)
      puts
      Color.send(COLORS[set], "= = #{set.to_s} = =")
      puts
      Runner.send(set).each_with_index do |item, index|
        Color.send(COLORS[set], report_single(set, item, index))
        puts
      end
    end

    def self.report_single(type, reportee, number = 0)
      require 'pp'
      result = "#{number + 1})  "
      if reportee.respond_to? :message
        result << "#{reportee.message} (#{reportee.class.name})"
      else
        result << reportee
      end
    end
  end
end
