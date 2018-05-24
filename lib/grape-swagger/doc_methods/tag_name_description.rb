# frozen_string_literal: true

module GrapeSwagger
  module DocMethods
    class TagNameDescription
      class << self
        def build(paths, options)
          paths.values.each_with_object([]) do |path, memo|
            tags = path.values.first[:tags]

            case tags
            when String
              memo << Translate.tag(options, tags)
            when Array
              path.values.first[:tags].each do |tag|
                memo << Translate.tag(options, tag)
              end
            end
          end.uniq
        end
      end
    end
  end
end
