# frozen_string_literal: true

module GrapeSwagger
  module DocMethods
    class Translate
      class << self
        def translate(path, method)
          path.gsub!(/\{|\}/, '')
          path.sub!(/^(\/\w+){3}\//, '\0{method}/')
          path.sub!(/^(\/\w+){3}$/, '\0/{method}')
          path.sub!('{method}', method.downcase)
          path.gsub!(/^(\/)/, '')
          path.gsub!('/', '.')

          path
        end
      end
    end
  end
end
