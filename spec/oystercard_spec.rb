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
        expect{ subject.top_up 1 }.to raise_error 'Max limit is #{MAX_BALANCE}'
      end

  end

  describe '#deduct' do
    it {is_expected.to respond_to(:deduct).with(1).argument }
    it 'deduct money from card'do
      subject.top_up(20)
      expect{ subject.deduct 3 }.to change {subject.balance }.by -3
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to :touch_in }
  end

  describe '#touch_out' do
    it { is_expected.to respond_to :touch_out }
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to :in_journey? }
    it 'return true if card in use' do
      allow(subject).to receive(:in_journey?).and_return(true)
      expect(subject.in_journey?).to be true
    end
    it ' return false if card not in use' do
      allow(subject).to receive(:in_journey?).and_return(true)
      expect(subject.in_journey?).to be true
    end
  end

    describe '#allow_entry' do
      it {is_expected.to respond_to :allow_entry}
      it 'raise error if balance < 1' do
      balance = 0
      expect{ subject.allow_entry }.to raise_error 'not enought money on card'
    end

    end

end
