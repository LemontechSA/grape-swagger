# frozen_string_literal: true

module GrapeSwagger
  module DocMethods
    class Translate
      class << self
        def tag(options, tag)
          description = translate "#{prefix(options)}.#{tag.pluralize}.desc"

          {
            name: tag,
            description: description
          }
        end

        def summary(route, options = {})
          base = prefix(options)

          translate "#{base}.#{clean_path(route)}.desc"
        end

        def description(route, options = {})
          base = prefix(options)

          translate "#{base}.#{clean_path(route)}.detail"
        end

        private

        def translate(value)
          I18n.t(value, default: '')
        end

        def prefix(options)
          "#{options[:i18n_scope]}.#{options[:version]}"
        end

        def clean_path(route)
          path = route.path.dup
          method = route.request_method.downcase

          # always removing format
          path.sub!(/\(\.\w+?\)$/, '')
          path.sub!('(.:format)', '')

          # always remove base
          path.gsub!(/^(\/(\w+|:\w+)){2}\//, '')

          # add mehtod to path
          path.sub!(/^(\w+)\//, '\0{method}/')
          path.sub!(/^(\w+)$/, '\0/{method}')

          # change to dots
          path.gsub!('/', '.')
          path.gsub!(/:(\w+)/, '\1')
          path.sub!('{method}', method)
        end
      end
    end
  end
end
