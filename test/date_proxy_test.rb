require 'test_helper'

class DateProxyTest < Minitest::Test
  def start_date
    Date.parse('2015-11-27')
  end

  def end_date
    Date.parse('2015-12-31')
  end

  def test_with_strings
    proxy = CombinePopoloMemberships::DateProxy.new(start_date: start_date.to_s, end_date: end_date.to_s)
    assert_equal Date.new(2015, 11, 27), proxy.start_date
    assert_equal Date.new(2015, 12, 31), proxy.end_date
  end

  def test_with_dates
    proxy = CombinePopoloMemberships::DateProxy.new(start_date: start_date, end_date: end_date)
    assert_equal Date.new(2015, 11, 27), proxy.start_date
    assert_equal Date.new(2015, 12, 31), proxy.end_date
  end

  def test_with_nil
    proxy = CombinePopoloMemberships::DateProxy.new(start_date: nil, end_date: nil)
    assert_equal Date.new, proxy.start_date
    assert_equal Date.new(9999, 12, 31), proxy.end_date
  end

  def test_with_empty_strings
    proxy = CombinePopoloMemberships::DateProxy.new(start_date: '', end_date: '')
    assert_equal Date.new, proxy.start_date
    assert_equal Date.new(9999, 12, 31), proxy.end_date
  end

  def test_returns_original_membership
    proxy = CombinePopoloMemberships::DateProxy.new(start_date: '', end_date: '')
    assert_equal({ start_date: '', end_date: '' }, proxy.data)
    proxy2 = CombinePopoloMemberships::DateProxy.new(start_date: nil, end_date: nil)
    assert_equal({ start_date: nil, end_date: nil }, proxy2.data)
  end
end
