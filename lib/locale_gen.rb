begin
  require "gdata"
rescue Exception => e
end

require "nokogiri"
require "yaml"

Dir.glob( File.join(File.dirname(__FILE__), "locale_gen", "*.rb")).each do |file|
  require file
end

module LocaleGen
  class << self
    def configure(filename = nil)
      @config = Config.new filename
      yield @config if block_given?
      @config
    end

    def config
      @config ||= Config.new
    end

    def generate
      gen = Generator.new config
      gen.generate
    end
  end
end