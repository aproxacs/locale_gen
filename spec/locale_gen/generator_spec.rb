require 'helper'

module LocaleGen
  describe "Generator" do
    let(:cfile) { File.join(File.dirname(__FILE__), "..", "..", "config", "config.yml") }
    let(:config) { Config.new(cfile) }

    it "test" do
      gen = Generator.new(config)

      # p gen.tab_ids
      # gen.generate
    end
  end
end