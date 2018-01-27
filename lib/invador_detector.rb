module Detector
  class Invador

    attr_reader :radar_image

    def initialize(radar_image)
      @radar_image = radar_image
      @invador_exists = false
    end

    private

    def known_invadors
      file_of_invadors = Dir["./known_invadors/invador_*"]
      invadors = []
      file_of_invadors.each do |f|
        invador = File.readlines(f).map(&:strip)
        invadors.push invador
      end
      invadors
    end
  end
end
