require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'it is check if initialize balance is 0' do
    expect(subject.balance).to eq 0
    end
  end

  describe '#topup' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
     expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error if the maximum balance is over limit' do
        maximum_balance = Oystercard::MAX_BALANCE
        subject.top_up(maximum_balance)
        expect{ subject.top_up 1 }.to raise_error 'Max limit is £90'
      end

  end

  describe '#deduct' do
    it {is_expected.to respond_to(:deduct).with(1).argument }

    it 'deduct money from card'do
      subject.top_up(20)
      expect{ subject.deduct 3 }.to change {subject.balance }.by -3
    end
  end

end
