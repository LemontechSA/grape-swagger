# frozen_string_literal: true

module GrapeSwagger
  module DocMethods
    class Translate
      class << self
        def tag(tag, options)
          translate "#{prefix(options)}.#{tag.pluralize}.desc"
        end

        def summary(route, options)
          translate "#{base(route, options)}.desc"
        end

        def description(route, options)
          translate "#{base(route, options)}.detail"
        end

        def param(route, param, options)
          translate "#{base(route, options)}.parameters.#{param}"
        end

        def response(route, code, options)
          translate "#{base(route, options)}.responses.#{code}.message"
        end

        private

        def translate(value)
          I18n.t(value, default: nil)
        end

        def base(route, options)
          "#{prefix(options)}.#{clean_path(route)}"
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

          # add method to path
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
