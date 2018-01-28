require './lib/invader_detector'
require 'benchmark'

image_source = File
  .readlines("./radar_images/current_image.txt")
  .map(&:strip)

detector = Detector::Invader.new(image_source)
puts Benchmark.measure { detector.analysis }
