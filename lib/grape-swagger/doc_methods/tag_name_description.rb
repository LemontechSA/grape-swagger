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
              memo << build_memo(tags, options)
            when Array
              path.values.first[:tags].each do |tag|
                memo << build_memo(tag, options)
              end
            end
          end.uniq
        end

        private

        def build_memo(tag, options)
          {
            name: tag,
            description: Translate.tag(tag, options) || "Operations about #{tag.pluralize}"
          }
        end
      end
    end
  end
end
