require "minitest/autorun"
require_relative "../lib/invador_detector"

class TestInvador < Minitest::Test
  def setup
    image = ["ooooo", "-----", "--o--"]
    @detector = Detector::Invador.new image
  end

  def test_new_a_radar_image
    assert_equal "ooooo", @detector.radar_image.first
  end

  def test_read_known_invadors_files
    file_of_invadors = Dir["./known_invadors/invador_*"]
    invadors = @detector.send(:known_invadors)
    assert_equal file_of_invadors.size, invadors.size
  end


end
