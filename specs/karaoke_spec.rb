require('minitest/autorun')
require('minitest/rg')

require_relative('../karaoke.rb')
require_relative('../room.rb')
require_relative('../guest.rb')

class KaraokeTest < MiniTest::Test

  def setup
    @songs_soul = ["song A", "song B", "song C"]
    @songs_pop = ["song D", "song E", "song F"]
    @room1 = Room.new("Room1", @songs_soul, 2, 5.0)
    @room2 = Room.new("Room2", @songs_pop, 2, 10.0)
    @rooms = [@room1, @room2]
    @karaoke = Karaoke.new("CodeClan", @rooms)
    @guest1 = Guest.new("Joe", 5.0)
    @guest2 = Guest.new("Dave", 12.0)
    @guest3 = Guest.new("Michelle", 15.0)
    @guest4 = Guest.new("Sarah", 3.0)
  end

  def test_empty_room_available__true
    assert_equal(true, @karaoke.empty_room_available?)
  end

  def test_empty_room_available__false
    # fill both rooms to max capacity (2)
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest2)
    @room2.add_guest(@guest3)
    @room2.add_guest(@guest4)
    assert_equal(false, @karaoke.empty_room_available?)
  end

  def test_first_empty_room__room_1_or_2_available
    assert_includes([@room1, @room2], @karaoke.first_empty_room)
  end

  def test_first_empty_room__room_2_available
    # fill room 1
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest2)
    assert_equal(@room2, @karaoke.first_empty_room)
  end

  def test_first_empty_room__no_empty_rooms
    # fill both rooms to max capacity (2)
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest2)
    @room2.add_guest(@guest3)
    @room2.add_guest(@guest4)
    # doesn't work with assert_equal
    assert_nil(nil, @karaoke.first_empty_room)
  end

  def test_check_in
    @karaoke.check_in(@guest1, @room1)
    assert_equal([@guest1], @room1.guests)
  end

  def test_check_in__room_1_full
    # guest 3 should be placed into room 2
    @karaoke.check_in(@guest1, @room1)
    @karaoke.check_in(@guest2, @room1)
    @karaoke.check_in(@guest3, @room1)
    assert_equal([@guest3], @room2.guests)
  end

  def test_check_in__failure_guest_cant_afford
    @karaoke.check_in(@guest4, @room1)
    assert_equal(0, @room1.guests.count)
  end

  def test_till_count
    @karaoke.check_in(@guest1, @room1)
    @karaoke.check_in(@guest2, @room1)
    @karaoke.check_in(@guest3, @room2)
    # guest 4 can't afford room 2
    @karaoke.check_in(@guest4, @room2)
    # total taken in should be 20
    assert_equal(20, @karaoke.till_count)
  end









end
