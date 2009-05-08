module Nokogiri
  module LibXML
    class XsltStylesheet < FFI::ManagedStruct
      
      layout :dummy, :int, 0 # to avoid @layout warnings

      def self.release ptr
        LibXML.xsltFreeStylesheet(ptr)
      end

    end
  end
end