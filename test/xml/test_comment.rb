require File.expand_path(File.join(File.dirname(__FILE__), '..', "helper"))

module Nokogiri
  module XML
    class TestComment < Nokogiri::TestCase
      def setup
        super
        @xml = Nokogiri::XML.parse(File.read(XML_FILE), XML_FILE)
      end

      def test_subclass
        klass = Class.new(Nokogiri::XML::Comment)
        comment = klass.new(@xml, 'hello world')
        assert_instance_of klass, comment
      end

      def test_new
        comment = Nokogiri::XML::Comment.new(@xml, 'hello world')
        assert_equal('<!--hello world-->', comment.to_s)
      end

      def test_many_comments
        100.times {
          Nokogiri::XML::Comment.new(@xml, 'hello world')
        }
      end
    end
  end
end
