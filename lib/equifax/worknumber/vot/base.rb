module Equifax
  module Worknumber
    module VOT
      class Base < ::Equifax::Worknumber::Base

        def self.required_fields
          super + [ :filing_type ]
        end

        def self.call(opts)
          new(opts).call
        end

        def call
          Equifax::Client.request(
            url,
            { request_method: :post },
            request_params,
          )
        end

        private

        def xml
          return xml_builder.to_xml
        end

        def xml_builder
          raise "define xml_builder"
        end

        def xml_container
          Nokogiri::XML::Builder.new encoding: "utf-8" do |xml|
            xml.REQUEST_GROUP MISMOVersionID: mismo_version_id do
              yield xml
            end
          end
        end

        def mismo_version_id
          "2.3.1"
        end

        def request_type
          filing_type.to_s.downcase.capitalize
        end

      end
    end
  end
end
