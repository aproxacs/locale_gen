require 'helper'

module LocaleGen
  describe "Config" do

    describe "#initialize" do
      context "when a valid filename is specified" do
        let(:filename) { File.join(File.dirname(__FILE__), "data", "config_for_test.yml") }

        it "parses filename and sets config" do
          config = Config.new filename

          config.key.should == "abcde"
          config.email.should == "test@email.com"
          config.password.should == "testpass"
          config.goals.size.should == 2
        end
      end

      context "when an input filename does not exist" do
        it "" do
          config = Config.new "invalid_file_name"

          config.key.should == nil
          config.email.should == nil
          config.password.should == nil
          config.goals.should == nil
        end
      end
    end

    it "is able to set key" do
      config = Config.new

      config.key = "abc"
      config.key.should == "abc"
    end

  end
end