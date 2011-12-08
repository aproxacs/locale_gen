begin
  require "gdata"
rescue Exception => e
end

require "nokogiri"

cli = GData::Client::Spreadsheets.new
cli.clientlogin "chang.shin@paprikalab.com", "tlsrmsckd"

# spreadsheet key
key = "0Am7lwLKQFcgQdF9WU3g4T1Z6SVoxQ3NlWTlGRy1iTHc"

# should retrieve worksheet keys
url = "https://spreadsheets.google.com/feeds/worksheets/#{key}/private/values"
xml = cli.get(url).to_xml
doc = Nokogiri::XML(xml.to_s)

worksheets = {}
doc.search("feed entry").each do |entry|
  title = entry.search("title").text
  id = File.basename(entry.search("id").text)
  worksheets[title] = id
end


parsing_rules = {
  "View" => {
    "en" => {
      "codename" => "en"
    },
    "kr" => {
      "codename" => "fbkr"
    }
  }
}
# rule one
# %w(View Tab Button Notifications Facebook_Feed Structures Road NPC World Quest Collection Tutorial_msg)

# rule two : 2 columns
# %w(Hero Item Region)

# rule three : 5 columns
# %w(Monster)

tname = "View"
prule = parsing_rules[tname]
wsid = worksheets[tname]
url = "https://spreadsheets.google.com/feeds/list/#{key}/#{wsid}/private/values"
xml = cli.get(url).to_xml
doc = Nokogiri::XML(xml.to_s)

# output : en.txt, kr.txt
begin
  en_out = File.open("en.txt", "w")
  kr_out = File.open("kr.txt", "w")
  doc.search("feed entry").each do |entry|
    prule["en"].each do |lname, vname|
      label = entry.xpath("./gsx:#{lname}").text
      value = entry.xpath("./gsx:#{vname}").text
      en_out.write("#{label}\t#{value}\n")
    end
    prule["kr"].each do |lname, vname|
      label = entry.xpath("./gsx:#{lname}").text
      value = entry.xpath("./gsx:#{vname}").text
      kr_out.write("#{label}\t#{value}\n")
    end
  end
rescue Exception => e
  p e
ensure
  en_out.close
  kr_out.close
end