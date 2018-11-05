class Oystercard

attr_reader :balance

MAX_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance

  end

  def top_up(amount)
    fail 'Max limit is £90'  if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end


end
