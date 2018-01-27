module Detector
  class Invader

    attr_reader :radar_image

    def initialize(radar_image)
      @radar_image = radar_image
      @invader_exists = false
    end

    def analysis
      @invaders = known_invaders
      @invaders.each do |invader|
        @invader_exists = compare_result(invader)
        break if @invader_exists
      end
      
      report
    end


    private

    def known_invaders
      file_of_invaders = Dir["./known_invaders/invader_*"]
      invaders = []
      file_of_invaders.each do |f|
        invader = File.readlines(f).map(&:strip)
        invaders.push invader
      end
      invaders
    end

    def characteristic_value(invader)
      char = {}
      invader.each_with_index do |line, location|
        if line.split("").uniq.size == 1
          char[line] = location
        end
      end
      char
    end

    def compare_result(invader)
      char_info = characteristic_value(invader)
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
          if snippet == invader[char_location - n]
            @on_the_image.push [snippet, location - n]
            next
          else
            @on_the_image = []
            break
          end
        end

        # check to lower side
        0.upto(invader.size - 1 - char_location) do |n|
          if (location + n) > (@radar_image.size - 1)
            @on_the_image = []
            break
          end
          snippet = @radar_image[location + n][left_index..right_index]
          if snippet == invader[char_location + n]
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
      if @invader_exists
        puts "Oh no! invader is existing!"
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
