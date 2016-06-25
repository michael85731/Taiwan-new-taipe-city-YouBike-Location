require "json"
require "net/http"
require "erb"

def call(env)
  locations = get_data
  content = ERB.new(File.read("Google multiple marker.html"))
  [200, {"content-type" => "text/html"}, [content.result(binding)]]
end

def get_data
  url = URI("http://data.ntpc.gov.tw/api/v1/rest/datastore/382000000A-000352-001")
  raw_data = JSON.parse(Net::HTTP.get(url))

  result = []
  raw_data["result"]["records"].each{|raw|
    single_data = []
    single_data << raw["sna"]
    single_data << raw["lat"].to_f
    single_data << raw["lng"].to_f
    result << single_data
  }
  result
end


run self