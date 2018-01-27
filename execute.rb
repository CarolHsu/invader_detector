require './lib/invador_detector'

image_source = File
  .readlines("./radar_images/current_image.txt")
  .map(&:strip)

detector = Detector::Invador.new(image_source)
detector.analysis
