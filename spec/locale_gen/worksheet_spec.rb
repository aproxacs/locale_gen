require 'helper'

module LocaleGen
  describe "Worksheet" do
    describe "#parse" do
      let(:xml) { File.read(File.join(File.dirname(__FILE__), "data", "ws_sample.xml")) }

      let(:labels) { {codename: "envalue"}.to_a }
      let(:ws) { Worksheet.new(xml, labels) }

      it "label and value are separated by tab " do
        ws.parse

        ws.output.should include "ui_level\tLEVEL"
      end

      it "interpolation" do
        ws.parse

        ws.output.should include "ui_collection_atoms\tENERGY : \#{1}"
      end

      it ", and ." do
        ws.parse

        ws.output.should include "mouseover_energy\tENERGY (\#{1}/\#{2})  : Consumed at every action. building, collecting, etc."
      end

      it "labels are more than one" do
        ws.labels = {codename: "envalue", tooltip: "tooltipenvalue"}.to_a
        ws.parse

        ws.output.should include "ui_level\tLEVEL"
        ws.output.should include "ui_level.tooltip\tlevel tooltip"
      end

    end
  end
end
