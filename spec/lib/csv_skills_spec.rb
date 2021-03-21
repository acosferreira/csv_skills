require 'csv_skills'

RSpec.describe "csv_skills" do
	let(:file) {"spec/fixtures/roster.csv"}
	let(:output) {"output.csv"}
  it "generates a count of the domains used in email addresses" do
    parse_file(file, output)

    expect(CSV.read("output.csv")).to eq([
      ["domain", "count"],
      ["yahoo.com", "331"],
      ["gmail.com", "330"],
      ["hotmail.com", "339"],
    ])
  end

  it "should find domains into array of string" do 
		str_array = [['test', 'test@test.com', '1','m'], ['test@gmail.com', '']]
		domains = find_domains(str_array)
		expect(domains).to eq(['test.com', 'gmail.com'])

	end
	it "should not find domains into array of string" do 
		str_array = [['test', '1','m'], ['test2', '2']]
		domains = find_domains(str_array)
		expect(domains).to eq([])

	end
	it "should count the domains on hash" do 
		str_array = ['test.com', 'gmail.com']
		domains = count_domains(str_array)
		expect(domains).to eq({'test.com'=>1, 'gmail.com'=> 1})
	
	end

	it "should empty hash" do 
		str_array = []
		domains = count_domains(str_array)
		expect(domains).to eq({})
	
	end
end
