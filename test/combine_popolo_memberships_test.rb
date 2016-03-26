require 'test_helper'
require 'date'

class CombinePopoloMembershipsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CombinePopoloMemberships::VERSION
  end

  def term_mems
    [
      { id: '1', start_date: '1998-01-01', end_date: '1999-12-31', area: 'Oldville' },
      { id: '2', start_date: '2000-01-01', end_date: '2001-12-31', area: 'Newville' }
    ]
  end

  def group_mems
    [
      { id: 'White Party', start_date: '1990-01-01', end_date: '1999-05-28' },
      { id: 'Black Party', start_date: '1999-06-01' },
    ]
  end

  def expected_combination
    [
      { start_date: "1998-01-01", end_date: "1999-05-28", faction: "White Party", term: "1"},
      { start_date: "1999-06-01", end_date: "1999-12-31", faction: "Black Party", term: "1"},
      { start_date: "2000-01-01", end_date: "2001-12-31", faction: "Black Party", term: "2"}
    ]
  end

  def test_combining_memberships
    assert_equal expected_combination, CombinePopoloMemberships.combine(term: term_mems, faction: group_mems)
  end

  def test_combining_in_reverse
    assert_equal expected_combination, CombinePopoloMemberships.combine(faction: group_mems, term: term_mems)
  end
end
