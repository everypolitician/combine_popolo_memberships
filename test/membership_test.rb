require 'test_helper'

class MembershipTest < Minitest::Test
  def test_with_known_dates
    membership = CombinePopoloMemberships::Membership.new(start_date: '2015-11-27', end_date: '2015-12-31')
    assert_equal '2015-11-27', membership.date_range.start_date
    assert_equal '2015-12-31', membership.date_range.end_date
  end

  def test_with_nil
    membership = CombinePopoloMemberships::Membership.new(start_date: nil, end_date: nil)
    assert_equal '0000-00-00', membership.date_range.start_date
    assert_equal '9999-99-99', membership.date_range.end_date
    assert_equal({ start_date: nil, end_date: nil }, membership.membership_hash)
  end

  def test_with_empty_strings
    membership = CombinePopoloMemberships::Membership.new(start_date: '', end_date: '')
    assert_equal '0000-00-00', membership.date_range.start_date
    assert_equal '9999-99-99', membership.date_range.end_date
    assert_equal({ start_date: '', end_date: '' }, membership.membership_hash)
  end
end
