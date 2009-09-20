class TestThing < Microtest::TestCase
  def test_true
    assert true
  end
  
  def test_false
    assert false
  end
  
  def test_error
    raise "DUDE"
  end
  
  def test_not
    assert_not false
  end

  def test_pending
    pending "Not implemented yet"
  end

  pending :test_more_pending
end