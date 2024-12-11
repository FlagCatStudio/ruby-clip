# frozen_string_literal: true

module Clip
  class CanvasPreview
    attr_reader :file, :row

    def initialize(file, row)
      @file = file
      @row = row
    end

    def inspect
      "#{self.class.name}: #{@row}"
    end

    def main_id
      row[:MainId]
    end

    def canvas_id
      row[:CanvasId]
    end

    def width
      row[:ImageWidth]
    end

    def height
      row[:ImageHeigth]
    end

    def image_type
      # NOTE: So far I've only encountered ImageType == 1, which I assume means
      # png. but we can't know for sure :shrug:
      row[:ImageType]
    end

    def image
      row[:ImageData]
    end

    def image_tempfile
      file = Tempfile.new(['ruby-clip--', '.png'])
      file.write image
      file.seek 0
      file
    end

    def image_save(path)
      File.open(path, 'wb') do |file|
        file.write image
      end
    end
  end
end
