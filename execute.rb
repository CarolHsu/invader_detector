require './lib/invader_detector'

image_source = File
  .readlines("./radar_images/current_image.txt")
  .map(&:strip)

detector = Detector::Invader.new(image_source)
detector.analysis
