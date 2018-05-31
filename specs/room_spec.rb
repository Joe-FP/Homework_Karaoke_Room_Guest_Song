require('minitest/autorun')
require('minitest/rg')

require_relative('../room.rb')
require_relative('../guest.rb')

class RoomTest < MiniTest::Test

  def setup
    @songs = ["song A", "song B", "song C"]
    @room1 = Room.new("Room1", @songs, 2, 5.0)
    @guest1 = Guest.new("Joe", 50.0)
    @guest2 = Guest.new("Dave", 4.0)
    @guest3 = Guest.new("Michelle", 35.0)
    @guest4 = Guest.new("Sarah", 20.0)
  end

  def test_name
    assert_equal("Room1", @room1.name)
  end

  def test_songs
    assert_equal(@songs, @room1.songs)
  end

  def test_add_song
    @room1.add_song("song D")
    assert_equal(4, @room1.songs.count)
  end

  def test_ticket_price
    assert_equal(5.0, @room1.ticket_price)
  end

  def test_guests
    # guests should be 0 initially
    assert_equal(0, @room1.guests.count)
  end

  def test_add_guest
    @room1.add_guest(@guest1)
    assert_equal(1, @room1.guests.count)
  end

  def test_remove_guest
    @room1.add_guest(@guest1)
    @room1.remove_guest(@guest1)
    assert_equal(0, @room1.guests.count)
  end

  def test_sell_ticket__Success
    # guest can afford ticket
    # till should have 5 in it
    assert_equal(true, @room1.sell_ticket(@guest1))
    assert_equal(5, @room1.till)
  end

  def test_sell_ticket__Failure
    # guest can't afford ticket
    # till should have 0 in it
    assert_equal(false, @room1.sell_ticket(@guest2))
    assert_equal(0, @room1.till)
  end

  def test_max_capacity__true
    # max capacity has been set at 2
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest2)
    assert_equal(true, @room1.max_capacity)
  end

  def test_max_capacity__false
    # max capacity has been set at 2
    @room1.add_guest(@guest1)
    assert_equal(false, @room1.max_capacity)
  end

end
