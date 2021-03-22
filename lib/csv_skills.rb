# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'csv_parse'

Bundler.require(:default)

# class CsvSkills
  
  ERRORFILE = 'error.csv'
  HEADER = %w[domain count]
  
  def parse_file(inputfile, outputfile)
    csv = CsvParse.new
    data = csv.read_file(inputfile)
    domains = find_domains(data)
    totals = count_domains(domains)
    csv.write_file(totals, outputfile, HEADER)
  rescue Errno::ENOENT => e
    csv.write_file(ERRORFILE, { 'Error' => e.message })
  rescue StandardError => e
    csv.write_file(ERRORFILE, { 'Error' => e.message })
  end

  def find_domains(row_value)
    domains = []
    row_value.each do |line|
      line.each do |elem|
        domains << elem.split('@').last if elem.include?('@')
      end
    end
    domains
  end

  def count_domains(domains)
    domains.group_by{|domain| domain}.map {|key,value| [key, value.length]}
  end
 # end