require "minitest/autorun"
require_relative "../lib/invader_detector"

class Testinvader < Minitest::Test
  def setup
    image = ["ooooo", "-----", "--o--"]
    @detector = Detector::Invader.new image
  end

  def test_new_a_radar_image
    assert_equal "ooooo", @detector.radar_image.first
  end

  def test_read_known_invaders_files
    file_of_invaders = Dir["./known_invaders/invader_*"]
    invaders = @detector.send(:known_invaders)
    assert_equal file_of_invaders.size, invaders.size
  end

  def test_get_characteristic_value_from_invader
    fake_invader = @detector.radar_image
    cinfo = @detector.send(:characteristic_value, fake_invader)
    assert_equal "ooooo", cinfo.keys.first
  end

  def test_report_should_puts_safe_when_there_no_invader
    @detector.instance_variable_set("@invader_exists", false)
    assert_output(/Safe!/) { @detector.send(:report) }
  end

  def test_report_should_puts_oh_no_when_there_is_invader
    fake_image_info = [
      ["ooooo", 2],
      ["--o--", 1],
      ["-o-o-", 3]
    ]
    @detector.instance_variable_set("@on_the_image", fake_image_info)
    @detector.instance_variable_set("@invader_exists", true)
    assert_output(/Oh no!/) { @detector.send(:report) }
  end

  def test_shows_image_snippet_if_not_empty
    fake_image_info = [
      ["ooooo", 2],
      ["--o--", 1],
      ["-o-o-", 3]
    ]
    @detector.instance_variable_set("@on_the_image", fake_image_info)
    assert_equal "ooooo", @detector.send(:image_snippet)[1][0]
  end

  def test_reture_true_if_matched
    fake_invader = @detector.radar_image
    result = @detector.send(:compare_result, fake_invader)
    assert_equal true, result
  end

  def test_reture_true_if_not_matched
    fake_invader = @detector.radar_image.reverse
    result = @detector.send(:compare_result, fake_invader)
    assert_equal false, result
  end

  def test_reture_true_if_part_matched
    fake_invader = @detector.radar_image.map { |r| r[1..4] }
    result = @detector.send(:compare_result, fake_invader)
    assert_equal true, result
  end
end
