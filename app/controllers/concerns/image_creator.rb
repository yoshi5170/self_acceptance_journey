class ImageCreator
  require 'mini_magick'

  GRAVITY = 'center'.freeze
  FONT_SIZE = 25
  TEXT_POSITION = '0,0'.freeze
  FONT = './app/assets/fonts/MPLUS1p-Medium.ttf'.freeze
  INDENTION_COUNT = 20
  ROW_LIMIT = 10

  class << self
    def build(text, image_id)
      text = prepare_text(text)
      image = MiniMagick::Image.open("./app/assets/images/#{image_id}.png")
      image.combine_options do |config|
        config.font FONT
        config.fill 'black'
        config.gravity GRAVITY
        config.pointsize FONT_SIZE
        config.draw "text #{TEXT_POSITION} '#{text}'"
      end
    end

    private

    def prepare_text(text)
      text.to_s.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
    end
  end
end
