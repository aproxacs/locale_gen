module LocaleGen
  class Config

    attr_accessor :key, :email, :password, :goals

    def initialize(filename = nil)
      filename = filename.to_s
      parse_config_file(filename) if File.exist?(filename)
    end

    private
      def parse_config_file(filename)
        data = YAML.load_file(filename) rescue {}

        self.key = data["key"]
        self.email = data["email"]
        self.password = data["password"]
        self.goals = data["goals"]
      end

  end
end