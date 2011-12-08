require 'helper'

describe ".configure" do
  it "returns Config instance" do
    LocaleGen.configure.should be_instance_of(LocaleGen::Config)
  end

  it "can send filename as an argument" do
    filename = File.join(File.dirname(__FILE__), "locale_gen", "data", "config_for_test.yml")
    config = LocaleGen.configure(filename)

    config.key.should == "abcde"
  end

  it "can set config using block" do
    LocaleGen.configure do |config|
      config.key = "ccc"
    end

    LocaleGen.config.key.should == "ccc"
  end
end
