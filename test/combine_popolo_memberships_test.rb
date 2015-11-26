require 'test_helper'

class CombinePopoloMembershipsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CombinePopoloMemberships::VERSION
  end

  def term_mems
    @term_mems ||= [
      { id: '2', name: '2. Národná rada 1998-2002', start_date: '1998-09-26', end_date: '2002-09-21' }
    ]
  end

  def group_mems
    @group_mems ||= [
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
    assert_equal expected, CombinePopoloMemberships.combine(term: term_mems, faction_id: group_mems)
  end
end
