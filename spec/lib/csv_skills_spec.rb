# frozen_string_literal: true

require 'csv_skills'

RSpec.describe 'CsvSkills' do
  context '#parse_file' do
    subject { CsvSkills.parse_file(file, output) }
    let(:file) { 'spec/fixtures/roster.csv' }
    let(:output) { 'output.csv' }
    let(:result) { [['yahoo.com', 331], ['gmail.com', 330], ['hotmail.com', 339]] }
    it 'return parse result' do
      expect(subject).to eq(result)
    end
  end

  context '#find_domains' do
    subject { CsvSkills.find_domains(row) }
    context 'find domains' do
      let(:row) { ['test', 'test@test.com', '1', 'm'] }
      it 'return test.com' do
        expect(subject).to eq('test.com')
      end
    end
    context 'domain not found' do
      let(:row) { %w[test 1 m] }
      it 'return empty result' do
        expect(subject).to be_nil
      end
    end
  end

  context '#count' do
    subject { CsvSkills.count(value) }
    context 'return count' do
      let(:value) { ['test.com', 'gmail.com'] }
      it 'return count test and gmail' do
        expect(subject).to eq([['test.com', 1], ['gmail.com', 1]])
      end
    end

    context 'domains not found' do
      let(:value) { [] }
      it 'return empty result' do
        expect(subject).to eq([])
      end
    end
  end
end
