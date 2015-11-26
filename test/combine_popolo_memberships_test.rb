require 'test_helper'

class CombinePopoloMembershipsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CombinePopoloMemberships::VERSION
  end

  def term_memberships
    [
      { id: '2', name: '2. Národná rada 1998-2002', start_date: '1998-09-26', end_date: '2002-09-21' }
    ]
  end

  def group_memberships
    [
      { name: 'Independent', id: '0', end_date: Date.new(1998, 10, 28) },
      { id: '1', name: 'Klub ĽS-HZDS', start_date: Date.new(1998, 10, 29), end_date: Date.new(2002, 07, 15) },
      { name: 'Independent', id: '0', start_date: Date.new(2002, 07, 16) }
    ]
  end

  def test_combining_memberships
    expected = [
      { start_date: '1998-09-26', end_date: '1998-10-28', faction_id: '0', term: '2' },
      { start_date: '1998-10-29', end_date: '2002-07-15', faction_id: '1', term: '2' },
      { start_date: '2002-07-16', end_date: '2002-09-21', faction_id: '0', term: '2' }
    ]
    assert_equal expected, CombinePopoloMemberships.combine(term: term_memberships, faction_id: group_memberships)
  end

  def test_membership_class
    membership = CombinePopoloMemberships::Membership.new(term_memberships.first)
    assert_equal Date.parse('1998-09-26'), membership.start_date
    assert_equal Date.parse('2002-09-21'), membership.end_date
  end
end
