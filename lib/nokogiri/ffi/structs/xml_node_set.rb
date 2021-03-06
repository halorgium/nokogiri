module Nokogiri
  module LibXML # :nodoc:

    module XmlNodeSetMixin # :nodoc:
      def self.included(base)
        base.class_eval do

          layout(
            :nodeNr,    :int,
            :nodeMax,   :int,
            :nodeTab,   :pointer
            )

        end
      end

      def document
        p = self[:doc]
        p.null? ? nil : LibXML::XmlDocumentCast.new(p)
      end

      def nodeTab
        # TODO: think about whether we should take an argument and
        # only return a single pointer instead of marshaling the
        # entire array
        self[:nodeTab].read_array_of_pointer(self[:nodeNr])
      end

      def nodeTab=(array)
        # TODO: do we need to check nodeMax and allocate more memory? probably.
        self[:nodeTab].write_array_of_pointer(array)
      end
    end


    class XmlNodeSet < FFI::ManagedStruct # :nodoc:
      include XmlNodeSetMixin

      def self.release ptr
        ns = XmlNodeSetCast.new(ptr)
        LibXML.xmlFree ns[:nodeTab] if ns[:nodeTab]
        LibXML.xmlFree ptr
      end
    end


    class XmlNodeSetCast < FFI::Struct # :nodoc:
      include XmlNodeSetMixin
    end

  end
end
