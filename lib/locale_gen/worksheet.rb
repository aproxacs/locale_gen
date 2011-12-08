module LocaleGen
  class Worksheet
    attr_accessor :labels, :doc

    def initialize(xml, labels)
      self.doc = Nokogiri::XML(xml.to_s)
      self.labels = labels
    end

    def parse
      doc.search("feed entry").each do |entry|
        parse_entry(entry)
      end
    end

    def output
      @output ||= []
    end


    private
      def parse_entry(entry)
        labels.each do |lname, vname|
          label = entry.xpath("./gsx:#{lname}").text
          value = entry.xpath("./gsx:#{vname}").text
          output << "#{label}\t#{value}"
        end
      end
  end
end