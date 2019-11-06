# frozen_string_literal: true

require_relative '../enumerable.rb'

describe Enumerable do
  let(:sample_arr) { [1, 2, 3, 4, 5] }

  describe '#my_each' do
    context 'If block is given' do
      it 'Travels the array, one element at a time' do
        arr_one = []
        arr_two = []
        sample_arr.each { |i| arr_one << i * i }
        sample_arr.my_each { |i| arr_two << i * i }
        expect(arr_one).to eql(arr_two)
      end
    end

    context 'If no block is given' do
      it 'returns an enumerator' do
        expect(sample_arr.my_each.is_a?(Enumerable)).to be true
      end
    end
  end

  describe '#my_each_with_index' do
    context 'If block is given' do
      it 'It iterates through the each element at a given index in the array' do
        hash_one = {}
        hash_two = {}
        sample_arr.my_each_with_index{|item, index| hash_one[item] = index}
        sample_arr.each_with_index{|item, index| }
      end
    end
    context 'If no block is given' do
      it 'returns an enumerator' do
        expect(sample_arr.my_each.is_a?(Enumerable)).to be true
      end
    end
    

  end


end
