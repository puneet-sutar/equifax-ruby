module Equifax
  module Worknumber
    module VO4506T
      class Base < ::Equifax::Worknumber::Base

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

        def submitting_party_tag(xml)
          xml.SUBMITTING_PARTY _Name: vendor_id,
                               LoginAccountIdentifier: account_number,
                               LoginAccountPassword: password do
            yield if block_given?
          end
        end

        def mismo_version_id
          "2.3.1"
        end

      end
    end
  end
end
