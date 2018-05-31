class Room

  attr_reader :name, :songs, :guests, :ticket_price, :till

  def initialize(name, songs, capacity, ticket_price)
    @name = name
    @songs = songs
    @guests = []
    @capacity = capacity
    @ticket_price = ticket_price
    @till = 0
  end

  def sell_ticket(guest)
    if guest.buys_ticket(self)
      @till += @ticket_price
      return true
    end
    return false
  end

  def add_guest(guest)
    @guests << guest
  end

  def remove_guest(guest)
    @guests.delete(guest)
  end

  def add_song(song_name)
    @songs << song_name if not @songs.include?(song_name)
  end

  def max_capacity
    @guests.count >= @capacity
  end

end
