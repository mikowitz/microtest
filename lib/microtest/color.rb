module Microtest
  module Color
    ANSI = {
      :clear => 0,
      :red => 31,
      :green => 32,
      :yellow => 33,
      :cyan => 36
    }
    ANSI.default = 0
    
    def self.io
      $stderr
    end

    def self.write_with_color(color, *args)
      "\e[#{ANSI[color]}m#{args.first.to_s}\e[#{ANSI[:clear]}m"
    end

    def self.method_missing(color, *args)
      io.write self.write_with_color(color, *args)
      io.flush
    end
  end
end