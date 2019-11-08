# frozen_string_literal: true

require_relative '../enumerable.rb'

describe Enumerable do
  let(:sample_arr) { [1, 2, 3, 4, 5] }
  let(:word_arr) { %w[ant bear cat] }
  let(:mix_arr) { [nil, true, 99] }
  let(:num_arr) { [1, 3.14, 2i] }
  let(:nil_arr) { [] }
  hash_one = {}
  hash_two = {}

  describe '#my_each' do
    context 'If block is given' do
      subject { sample_arr.each { |i| i * i } }
      it 'Travels the array, one element at a time' do
        expect(subject).to eql(sample_arr.my_each { |i| i * i})
      end
    end
  end

  context 'If no block is given'  do
    subject { sample_arr.my_each }
    it 'returns an enumerator' do
      expect(subject).to be_a(Enumerable)
    end
  end

  describe '#my_each_with_index' do
    context 'If block is given' do
      it 'Travels the array, one element at a time with index' do
        sample_arr.each_with_index{ |i, indx| hash_one[i] = indx } 
        sample_arr.my_each_with_index{ |i, indx| hash_two[i] = indx } 
        expect(hash_one).to eql(hash_two)
      end
    end

    context 'If no block is given' do
      subject { sample_arr.my_each_with_index }
      it 'Returns an enumerator' do
        expect(subject).to be_a(Enumerable)
      end
    end
  end


  describe '#my_select'  do
    it 'Returns the selected item according to the specified conditions' do
      original_arr = sample_arr.my_select{ |x| x > 2 }
      test_arr = sample_arr.my_select{ |x| x > 2 }
      expect(test_arr).to eql(original_arr)
    end

    context "If a block is given" do
      it 'Returns the selected item' do
      end
    end
    
    context "If no block is given" do
      it 'Returns an enumerator' do
        expect(sample_arr.my_each.is_a?(Enumerable)).to be true
      end
    end
  end

  describe '#my_all' do
    it 'Returns true if the elements are true else it returns an empty array' do
      original_arr = sample_arr.all? { |x| x > 0 }
      test_arr = sample_arr.my_all? { |x| x > 0 }
      expect(test_arr).to eql(original_arr)
    end  
  end
end
