class Oystercard

attr_reader :balance

MAX_BALANCE = 90
MINIMUM_FARE = 1

  def initialize(balance = 0)
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail 'Max limit is £90'  if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    allow_entry
   @in_journey = true
  end

  def touch_out
    journey_charge
   @in_journey = false

  end

  def in_journey?
    @in_journey
  end

  def allow_entry
    fail 'not enought money on card' if @balance < MINIMUM_FARE
  end

  def journey_charge
    @balance -= MINIMUM_FARE
  end

end
