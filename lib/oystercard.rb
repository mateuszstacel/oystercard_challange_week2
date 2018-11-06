class Oystercard

attr_reader :balance

MAX_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail 'Max limit is #{MAX_BALANCE}'  if (@balance + amount) > MAX_BALANCE
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
   @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def allow_entry
    fail 'not enought money on card' if @balance < 1
  end


end
