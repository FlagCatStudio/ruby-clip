# frozen_string_literal: true

require 'sqlite3'

require_relative './canvas_preview'

module Clip
  class File
    MAGIC = 'CSFCHUNK'
    SQLITE_MAGIC = 'SQLite format 3'
    FOOTER_MARKER = 'CHNKFoot'

    attr_reader :path

    def self.open(*, **)
      new(*, **)
    end

    def initialize(path)
      @path = path

      raise InvalidClipFile, 'Not a CSP .clip' unless magic_present?
      raise InvalidClipFile, 'No database found in .clip' unless sqlite_present?
    end

    def file
      @file ||= ::File.open(path, 'rb')
    end

    def raw_content
      @raw_content ||= file.read
    end

    def magic_present?
      file.pread(MAGIC.length, 0) == MAGIC
    end

    def sqlite_present?
      !sqlite_index.nil?
    end

    def sqlite_content
      @sqlite_content ||=
        begin
          len = footer_index - sqlite_index
          raw_content.byteslice(sqlite_index, len)
        end
    end

    def sqlite_file
      @sqlite_file ||=
        begin
          file = Tempfile.new("ruby-clip-#{basename}--")
          file.write(sqlite_content)
          file.seek(0)
          file
        end
    end

    def sqlite
      @sqlite ||= SQLite3::Database.open(sqlite_file.path)
    end

    def close
      if defined? :@sqlite && @sqlite
        @sqlite.close
        @sqlite = nil
      end

      if defined? :@sqlite_file && @sqlite_file
        @sqlite_file.close
        @sqlite_file.unlink
        @sqlite_file = nil
      end
    end

    def canvas_previews
      rows = sqlite_execute_as_hash <<-SQL
        SELECT * FROM CanvasPreview;
      SQL
      rows.map { |row| CanvasPreview.new(self, row) }
    end


    protected

    def basename
      ::File.basename(path)
    end

    def sqlite_index
      raw_content.index SQLITE_MAGIC
    end

    def footer_index
      raw_content.rindex FOOTER_MARKER || raw_content.length
    end

    def sqlite_execute_as_hash(query)
      rows = sqlite.execute2(query)
      headers = rows.shift.map(&:to_sym)

      rows.map do |row|
        h = {}
        headers.each_with_index { |header, index|  h[header] = row[index] }
        h
      end
    end
  end
end
