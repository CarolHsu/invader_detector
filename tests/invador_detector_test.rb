require "minitest/autorun"
require_relative "../lib/invador_detector"

class TestInvador < Minitest::Test
  def setup
    image = ["ooooo", "-----", "--o--"]
    @detector = Detector::Invador.new(image)
  end


end
