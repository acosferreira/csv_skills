require 'rubygems'
require 'bundler/setup'
require 'csv_parse'
Bundler.require(:default)
ERRORFILE = 'error.csv'
def parse_file(inputfile, outputfile)
  csv = CsvParse.new
  data = csv.read_file(inputfile)
  domains = find_domains(data)
  totals = count_domains(domains)
  csv.write_file(totals, outputfile)
rescue Errno::ENOENT => e
  csv.write_file(ERRORFILE, { 'Error' => e.message })
rescue StandardError => e
  csv.write_file(ERRORFILE, { 'Error' => e.message })
end

def find_domains(row_value)
  domains = []
  byebug
  row_value.each do |line|
    line.each do |elem|
      domains << elem.split('@').last if elem.include?('@')
    end
  end
  domains
end

def count_domains(domains)
  Hash[
    domains.group_by do |domain|
      domain
    end.map do |key, value|
      [key, value.size]
    end
  ]
end
