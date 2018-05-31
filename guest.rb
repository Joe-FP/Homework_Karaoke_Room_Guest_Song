class Guest

  attr_reader :name, :funds

  def initialize(name, funds)
    @name = name
    @funds = funds
  end

  def buys_ticket(room)
    if sufficient_funds?(room)
      @funds -= room.ticket_price
      return true
    end
    return false
  end

  def sufficient_funds?(room)
    return @funds >= room.ticket_price
  end

end
