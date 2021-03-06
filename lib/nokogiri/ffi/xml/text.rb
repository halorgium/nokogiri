module Nokogiri
  module XML
    class Text < Node

      def self.new(string, document) # :nodoc:
        node_ptr = LibXML.xmlNewText(string)
        node_cstruct = LibXML::XmlNode.new(node_ptr)
        node_cstruct[:doc] = document.cstruct
        node = Node.wrap(node_cstruct, self)
        yield node if block_given?
        node
      end

    end
  end
end
