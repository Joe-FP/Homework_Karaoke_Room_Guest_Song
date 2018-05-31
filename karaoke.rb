class Karaoke

  attr_reader :name, :rooms

  def initialize(name, rooms)
    @name = name
    @rooms = rooms
    @till = 0
  end

  def check_in(guest, room)
    if not room.max_capacity
      room.add_guest(guest) if room.sell_ticket(guest)
    else
      if empty_room_available?
        check_in(guest, first_empty_room)
      end
    end
    # could be refactored as below so that room.max_capacity and
    # room.sell_ticket(guest) are handled within the Room class
    # to produce:
    #
    # if not room.add_guest(guest)
    #   if empty_room_available?
    #     check_in(guest, first_empty_room)
    #   end
    # end
    #
    # room.add_guest(guest) would then have to return:
    # true, false(max capacity), or false (guest can't afford)
    #
    # what is the better way?
  end

  def check_out(guest, room)
    @guests.delete(guest) if @guests.include?(guest)
  end

  def empty_room_available?
    @rooms.each do |room|
      return true if not room.max_capacity
    end
    return false
  end

  def first_empty_room
    @rooms.each do |room|
      return room if not room.max_capacity
    end
  end

  def till_count
    self.rooms.each do |room|
      @till += room.till
    end
    return @till
  end

end
