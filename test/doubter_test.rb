require 'test_helper'

class DoubterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Doubter::VERSION
  end
end
