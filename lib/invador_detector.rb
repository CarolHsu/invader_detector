module Detector
  class Invador

    attr_reader :radar_image

    def initialize(radar_image)
      @radar_image = radar_image
      @invador_exists = false
    end

    def analysis
      @invadors = known_invadors
      @invadors.each do |invador|
        @invador_exists = compare_result(invador)
        break if @invador_exists
      end
      
      report
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

    def characteristic_value(invador)
      char = {}
      invador.each_with_index do |line, location|
        if line.split("").uniq.size == 1
          char[line] = location
        end
      end
      char
    end

    def compare_result(invador)
      char_info = characteristic_value(invador)
      char_value = char_info.keys.first
      char_location = char_info.values.first
      @on_the_image = []
      @radar_image.each_with_index do |line, location|
        left_index = line.index(char_value)
        next if left_index.nil?
        right_index = left_index + char_value.size - 1

        # check to upper side
        0.upto(char_location) do |n|
          snippet = @radar_image[location - n][left_index..right_index]
          if snippet == invador[char_location - n]
            @on_the_image.push [snippet, location - n]
            next
          else
            @on_the_image = []
            break
          end
        end

        # check to lower side
        0.upto(invador.size - 1 - char_location) do |n|
          if (location + n) > (@radar_image.size - 1)
            @on_the_image = []
            break
          end
          snippet = @radar_image[location + n][left_index..right_index]
          if snippet == invador[char_location + n]
            @on_the_image.push [snippet, location + n]
            next
          else
            @on_the_image = []
            break
          end
        end

        break unless @on_the_image.empty?
      end

      @on_the_image.empty? ? false : true
    end

    def report
      if @invador_exists
        puts "Oh no! Invador is existing!"
        puts "---------------------------"
        puts image_snippet.inspect
      else
        puts "Safe!"
      end
    end

    def image_snippet
      return @on_the_image if @on_the_image.empty?
      @on_the_image.sort_by(&:last)
    end
  end
end
