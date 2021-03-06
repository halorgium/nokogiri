module Nokogiri
  module LibXML # :nodoc:
    class XmlSaxHandler < FFI::ManagedStruct # :nodoc:

      layout(:internalSubset,           :pointer,
             :isStandalone,             :pointer,
             :hasInternalSubset,        :pointer,
             :hasExternalSubset,        :pointer,
             :resolveEntity,            :pointer,
             :getEntity,                :pointer,
             :entityDecl,               :pointer,
             :notationDecl,             :pointer,
             :attributeDecl,            :pointer,
             :elementDecl,              :pointer,
             :unparsedEntityDecl,       :pointer,
             :setDocumentLocator,       :pointer,
             :startDocument,            :start_document_sax_func, 
             :endDocument,              :end_document_sax_func ,
             :startElement,             :start_element_sax_func,
             :endElement,               :end_element_sax_func,
             :reference,                :pointer,
             :characters,               :characters_sax_func,
             :ignorableWhitespace,      :pointer,
             :processingInstruction,    :pointer,
             :comment,                  :comment_sax_func,
             :warning,                  :warning_sax_func, 
             :error,                    :error_sax_func,
             :fatalError,               :pointer,
             :getParameterEntity,       :pointer,
             :cdataBlock,               :cdata_block_sax_func, 
             :externalSubset,           :pointer,
             :initialized,              :uint
             )

      def self.allocate
        new LibXML.calloc(1, LibXML::XmlSaxHandler.size)
      end

      def self.release ptr
        LibXML.free(ptr)
      end

    end
  end
end
