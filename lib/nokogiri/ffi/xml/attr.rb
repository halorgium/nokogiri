module Nokogiri
  module XML
    class Attr < Node

      def self.new(document, name) # :nodoc:
        node_ptr = LibXML.xmlNewDocProp(document.cstruct, name.to_s, nil)

        node_cstruct = LibXML::XmlNode.new(node_ptr)
        node_cstruct[:doc] = document.cstruct[:doc]
        LibXML.xmlXPathNodeSetAdd(node_cstruct.document.node_set, node_cstruct)

        node = Node.wrap(node_cstruct, self)
        yield node if block_given?
        node
      end

      def value=(content) # :nodoc:
        unless cstruct[:children].null?
          LibXML.xmlFreeNodeList(cstruct[:children])
        end
        cstruct[:children] = cstruct[:last] = nil
        return unless content

        char_ptr = LibXML.xmlEncodeEntitiesReentrant(cstruct[:doc], content)

        cstruct[:children] = LibXML.xmlStringGetNodeList(cstruct[:doc], char_ptr)
        child_cstruct = cstruct[:children]
        while ! child_cstruct.null?
          child = Node.wrap(child_cstruct)
          child.cstruct[:parent] = cstruct
          child.cstruct[:doc] = cstruct[:doc]
          cstruct[:last] = child.cstruct
          child_cstruct = child.cstruct[:next]
        end
        LibXML.xmlFree(char_ptr)

        content
      end

    end
  end
end
