require 'oystercard'

describe Oystercard do

    let(:station) { double 'station' }

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
    it 'throw error when top up is higher then £90' do
      amount = Oystercard::MAX_BALANCE
      subject.top_up(amount)
      expect{ subject.top_up(1) }.to raise_error 'Max limit is £90'
    end

    it 'raises an error if the maximum balance is over limit' do
        maximum_balance = Oystercard::MAX_BALANCE
        subject.top_up(maximum_balance)
        expect{ subject.top_up 1 }.to raise_error 'Max limit is £90'
      end

  end
  #
  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }
    it 'when user top up account allow to touch in' do
      card = Oystercard.new
      card.top_up(1)
      card.touch_in(station)
      expect(card.in_journey?).to eq true
    end
    it 'dont allow touch in if no enought money on account' do
      card = Oystercard.new
      card.top_up(0)
      expect{ card.touch_in(station) }.to raise_error 'not enought money on card'
    end
    it 'save the travel station' do
      card = Oystercard.new
      card.top_up(20)
      card.touch_in(station)
      expect(card.entry_station).to eq(station)
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out).with(1).argument }
    it 'is expected to deduct money after journey' do
      card = Oystercard.new
      card.top_up(3)
      card.touch_in(station)
      card.touch_out(station)
      expect(card.balance).to eq 2
    end
    it 'is expected in journey to be false after test' do
      card = Oystercard.new
      card.top_up(5)
      card.touch_in(station)
      card.touch_out(station)
      expect(card.in_journey?).to be false
    end
    it 'forget the tavel station' do
      card = Oystercard.new
      card.top_up(90)
      card.touch_in(station)
      card.touch_out(station)
      expect(card.entry_station).to eq nil

    end
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
      it { is_expected.to respond_to :allow_entry }
      it 'raise error if balance < 1' do
      expect{ subject.allow_entry }.to raise_error 'not enought money on card'
      end
    end



end
