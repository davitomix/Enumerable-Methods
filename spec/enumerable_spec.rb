# frozen_string_literal: true

require_relative '../enumerable.rb'

describe Enumerable do
  let(:sample_arr) { [1, 2, 3, 4, 5] }
  let(:word_arr) { %w[ant bear cat] }
  let(:mix_arr) { [nil, true, 99] }
  let(:num_arr) { [1, 3.14, 2i] }
  let(:nil_arr) { [] }

  describe '#my_each' do
    context 'If block is given' do
      subject { sample_arr.each { |i| i * i } }
      it 'Travels the arra, one element at a time' do
        expect(subject).to eql(sample_arr.my_each { |i| i * i})
      end
    end
  end

  context 'If no block is given'  do
    subject { sample_arr.my_each.is_a?(Enumerable) }
    it 'returns an enumerator' do
      expect(subject).to be true
    end
  end
end
