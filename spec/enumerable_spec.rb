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
        sample_arr.each { |i| arr_two << i * i }
        expect(arr_one).to eql(arr_two)
      end
    end
  end

end
