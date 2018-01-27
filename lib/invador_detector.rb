module Detector
  class Invador

    attr_reader :radar_image

    def initialize(radar_image)
      @radar_image = radar_image
      @invador_exists = false
    end

  end
end
