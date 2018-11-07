class Oystercard

attr_reader :balance, :entry_station, :exit_station, :history

MAX_BALANCE = 90
MINIMUM_FARE = 1



  def initialize(balance = 0, entry_station = nil, exit_station = nil)
    @balance = balance
    @in_journey = nil
    @entry_station = entry_station
    @exit_station = exit_station
    @history = []
  end

  def top_up(amount)
    fail 'Max limit is £90'  if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end


  def touch_in(entry_station)
    allow_entry
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE) if @in_journey == true
    @exit_station = exit_station
    @history.push({  entry_station: @entry_station, exit_station: @exit_station})
    @in_journey = false
    @entry_station = nil
  end

  def in_journey?
    !!@in_journey
  end

  def allow_entry
    fail 'not enought money on card' if @balance < MINIMUM_FARE
  end


private

  def deduct(amount)
    @balance -= amount
  end

end
