require 'csv'

class CsvParse
	
	def read_file(file)
		CSV.read(file)
	end

	def write_file(domain_counts, file_name)
		CSV.open(file_name, "wb") do |csv| 
			csv <<["domain", "count"]
			domain_counts.to_a.each do |elem| 
				csv << elem
			end 
		end
	end
	
end