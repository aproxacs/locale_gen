module LocaleGen
  class Generator
    attr_accessor :config

    def initialize(config)
      self.config = config
    end

    def generate
      config.goals.each do |goal|
        write(goal)
      end
    end

    def write(goal)
      output = []

      goal["tabs"].each do |tname, labels|
        ws = Worksheet.new(ws_xml(tname), labels.to_a)
        ws.parse
        output.concat ws.output
      end

      filename = File.expand_path(goal["output"]["filename"])
      File.open(filename, "w") do |file|
        file.write(output.join("\n"))
      end
    end

    def ws_xml(tname)
      doc_con.get(ws_url(tname)).to_xml
    end

    def ws_url(tname)
      wsid = tab_ids[tname]
      "https://spreadsheets.google.com/feeds/list/#{config.key}/#{wsid}/private/values"
    end

    def tab_ids
      @tab_ids ||= begin
        xml = doc_con.get(doc_url).to_xml
        doc = Nokogiri::XML(xml.to_s)

        worksheets = {}
        doc.search("feed entry").each do |entry|
          title = entry.search("title").text
          id = File.basename(entry.search("id").text)
          worksheets[title] = id
        end

        worksheets
      end
    end

    def doc_con
      @doc_con ||= begin
        con = GData::Client::Spreadsheets.new
        con.clientlogin config.email, config.password
        con
      end
    end

    def doc_url
      "https://spreadsheets.google.com/feeds/worksheets/#{config.key}/private/values"
    end
  end
end
