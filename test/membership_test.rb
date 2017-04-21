require 'test_helper'

class MembershipTest < Minitest::Test
  def test_with_known_dates
    membership = CombinePopoloMemberships::Membership.new(start_date: '2015-11-27', end_date: '2015-12-31')
    assert_equal '2015-11-27', membership.start_date
    assert_equal '2015-12-31', membership.end_date
  end

  def test_with_nil
    membership = CombinePopoloMemberships::Membership.new(start_date: nil, end_date: nil)
    assert_equal '0000-00-00', membership.start_date
    assert_equal '9999-99-99', membership.end_date
  end

  def test_with_empty_strings
    membership = CombinePopoloMemberships::Membership.new(start_date: '', end_date: '')
    assert_equal '0000-00-00', membership.start_date
    assert_equal '9999-99-99', membership.end_date
  end

  def test_returns_original_membership
    membership = CombinePopoloMemberships::Membership.new(start_date: '', end_date: '')
    assert_equal({ start_date: '', end_date: '' }, membership.membership_hash)
    membership2 = CombinePopoloMemberships::Membership.new(start_date: nil, end_date: nil)
    assert_equal({ start_date: nil, end_date: nil }, membership2.membership_hash)
  end
end
