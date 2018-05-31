require('minitest/autorun')
require('minitest/rg')

require_relative('../guest.rb')
require_relative('../room.rb')

class GuestTest < MiniTest::Test

  def setup
    @songs = ["song A", "song B", "song C"]
    @room1 = Room.new("Room1", @songs, 2, 5.0)
    @guest1 = Guest.new("Joe", 50.0)
    @guest2 = Guest.new("Joe", 4.0)
  end

  def test_name
    assert_equal("Joe", @guest1.name)
  end

  def test_funds
    assert_equal(50.0, @guest1.funds)
  end

  def test_buys_ticket__guest_CAN_afford
    assert_equal(true, @guest1.buys_ticket(@room1))
    assert_equal(45.0, @guest1.funds)
  end

  def test_buys_ticket__guest_CANT_afford
    assert_equal(false, @guest2.buys_ticket(@room1))
    assert_equal(4.0, @guest2.funds)
  end

end
