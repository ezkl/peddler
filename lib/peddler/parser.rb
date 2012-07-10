require 'ox'

module Peddler
  # Internal: A stream Sax parser.
  class Parser < Ox::Sax
    def initialize
      @stack = [{}]
    end

    def attr(key, val)
      node[key] = val
    end

    def end_element(key)
      child = @stack.pop

      key = key
        .to_s
        .gsub(/([a-z\d])([A-Z])/,'\1_\2')
        .downcase
        .to_sym

      case node[key]
      when Array
        node[key] << child
      when Hash
        node[key] = [node[key], child]
      else
        node[key] =
          if child.keys == [:__content__]
            child[:__content__]
          else
            child
          end
      end
    end

    def root
      @stack.first
    end

    def start_element(key)
      @stack << {}
    end

    def text(val)
      node[:__content__] = val
    end

    private

    def node
      @stack.last
    end
  end
end
