# frozen_string_literal: true

require 'csv'

class CsvParse
  def self.read_file(file)
    CSV.read(file)
  end

  def self.write_file(result, outputfile, header)
    CSV.open(outputfile, 'wb') do |csv|
      csv << header
      result.to_a.each do |elem|
        csv << elem
      end
    end
  end
end
