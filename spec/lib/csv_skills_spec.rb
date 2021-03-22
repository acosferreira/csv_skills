# frozen_string_literal: true

require 'csv_skills'

RSpec.describe 'csv_skills' do

context 'Read file and export result' do
	subject { parse_file(file, output) }	
  let(:file) { 'spec/fixtures/roster.csv' }
  let(:output) { 'output.csv' }
  let(:result) {[['yahoo.com', 331], ['gmail.com', 330], ['hotmail.com', 339]]}
  it 'generates a count of the domains used in email addresses' do
    expect(subject).to eq(result)
  end
end
	
	context 'Find domains' do
	  subject{ find_domains(str_array) }
	  let(:str_array) {[['test', 'test@test.com', '1', 'm'], ['test@gmail.com', '']]}
	  it 'find all domains' do
	    
	    expect(subject).to eq(['test.com', 'gmail.com'])
	  end
	end

	context 'Domains not found' do
		subject{ find_domains(str_array) }
	  let(:str_array) {[%w[test 1 m], %w[test2 2]]}
	  it 'empty result' do
	    expect(subject).to eq([])
	  end
	end
  
  context 'Count' do
  	subject{ count_domains(str_array) }
	  let(:str_array) {['test.com', 'gmail.com']}
	  it 'count the domains on hash' do
	    expect(subject).to eq({ 'test.com' => 1, 'gmail.com' => 1 })
	  end
	end
  
  context 'Empty result' do
  	subject{ count_domains(str_array) }
	  let(:str_array) {[]}
	  it 'should empty hash' do
	    expect(subject).to eq({})
	  end
	end
end
