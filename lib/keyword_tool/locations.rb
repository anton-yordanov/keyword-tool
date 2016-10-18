require "open-uri"
require "csv"

module KeywordTool
  class Locations
    LOCATIONS_PATH  = "/system/locations.csv".freeze
    LOCATIONS_URI   = URI("https://fusiontables.google.com/exporttable?query=select+*+from+1d1inB8Y_MKvCf0XHU1z58fnCtpPBahM-sAgiAe65")

    class << self
      def all
        @@locations ||= new.fetch_locations
      end

      def find_by_name(name)
        all.select { |key, _| key.casecmp(name) > -1 }
      end

      private :new
    end

    attr_reader :name, :code

    def initialize(options = {})
      @name = options.delete(:name)
      @code = options.delete(:code)
    end

    def csv_file_path
      @csv_file_path ||= "#{KeywordTool.root_path}/#{LOCATIONS_PATH}"
    end

    def fetch_locations
      retries = 2
      begin
        parse_csv_file
      rescue Errno::ENOENT => e
        raise e if retries == 0
        download_locations
        retry
      end
    end

    def download_locations
      get_request = Net::HTTP::Get.new(LOCATIONS_URI.request_uri)
      dir         = File.dirname("#{csv_file_path}")
      Dir.mkdir(dir) unless Dir.exist?(dir)

      http_request.request(get_request) do |resppnse|
        File.open(csv_file_path, mode: "w+b", encoding: "ASCII-8BIT") do |f|
          resppnse.read_body do |chunk|
            f.write(chunk)
          end
        end
      end

      f.close
    rescue => e
      raise e
    end

    def parse_csv_file
      csv_options = { headers: true, encoding: "UTF-8" }

      CSV.read(csv_file_path, csv_options).each_with_object({}) do |row, memo|
        next unless row["Target Type"] == "Country"
        memo[row["Name"]] =
          {
            code: row["Criteria ID"].to_i,
            country_code: row["Country Code"]
          }
      end
    end

    def http_request
      return @http_request if @http_request

      @http_request = Net::HTTP.new(LOCATIONS_URI.host, LOCATIONS_URI.port)
      @http_request.use_ssl = true
      @http_request
    end
  end
end
