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
      it 'returns an Enumerator when no block given' do
        expect(sample_arr.my_select.is_a?(Enumerator)).to be(true)
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
  

    context "If an argument is given" do
      it 'Returns true when all the elements belong to the class' do
        expect(sample_arr.my_all?(Integer)).to eql(true)
        expect(sample_arr.my_all?(String)).to eql(false)
      end
    end

    context 'Argument = Regexp'
    it 'returns true when all elements match the Regular Expression passed or false when it does not pass' do
      expect(word_arr.my_all?(/[a-z]/)).to eql(true)
      expect(word_arr.my_all?(/d/)).to eql(false)
    end
  end  
  
  describe '#my_any?' do
    context 'If block is given' do 
      subject { word_arr.my_any? { |word|  word.length >= 3 } }
      it 'Returns true if ever return a value other than false or nil' do
        expect(subject).to be true
      end
    end

    context 'If an argument is given' do
      subject { mix_arr.my_any?(Integer) }
      it 'returns true if theres a element in the array' do
        expect(subject).to be true
      end
    end

    context 'If nor argument is given ' do
      subject { mix_arr.my_any? }
      it 'returns true if there a true in the array' do
        expect(subject).to be true
      end
    end
  end

  describe '#my_none?' do
    context 'If block is given' do
      subject { word_arr.my_none? { |word| word.length == 5 } }
      it 'return true if block never return true for all elemetns' do
        expect(subject).to be true
      end
    end

    context 'If an argument is given' do
      subject { num_arr.my_none?(Float) } 
      it 'return false if all elements are true' do
        expect(subject).to be false
      end
    end

    context 'If no arguments is given' do
      subject { nil_arr.my_none? }
      it 'returns true if all elements are false or nil' do
        expect(subject).to be true
      end
    end
  end

  describe '#my_count' do
    it 'takes an enumerable collection and counts how many elements match the given criteria.' do
      original_arr =sample_arr.count { |x| x > 5 }
      test_arr = sample_arr.my_count { |x| x > 5 }
      expect(test_arr).to eql(original_arr)
    end

    it 'returns array length when no block given' do
      expect(sample_arr.my_count).to eql(5)
    end

    it 'returns the number of elements that is equal to the given argument' do
      expect(sample_arr.my_count(2)).to eq(1)
    end
  end
end
