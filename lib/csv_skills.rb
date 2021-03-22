# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'csv_parse'

Bundler.require(:default)

class CsvSkills
  ERRORFILE = 'error.csv'
  HEADER = %w[domain count].freeze

  def self.parse_file(input_file, output_file)
    data = CsvParse.read_file(input_file)
    domains = data.map { |row| find_domains(row) }
    totals = count(domains)
    
  rescue Errno::ENOENT => e
    CsvParse.write_file(ERRORFILE, { 'Error' => e.message }, 'Error')
  rescue StandardError => e
    CsvParse.write_file(ERRORFILE, { 'Error' => e.message }, 'Error')
  end

  def self.find_domains(row)
    email = row.find { |elem| elem.include?('@') }
    email.split('@').last if email
  end

  def self.count(values)
    values.group_by { |value| value }.map { |key, value| [key, value.length] }
  end

  def self.write_result(totals, output_file)
    CsvParse.write_file(totals, output_file, HEADER)
  end
end
