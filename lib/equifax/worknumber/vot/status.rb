module Equifax
  module Worknumber
    module VOT
      class Status < ::Equifax::Worknumber::VOT::Base
        def self.required_fields
          super + [ :order_number ]
        end

        def self.optional_fields
          super + [ :request_date ]
        end

        private

        def action_type
          "StatusQuery"
        end

        def xml_builder
          xml_container do |xml|
            xml.SUBMITTING_PARTY _Name: vendor_id,
                                 LoginAccountIdentifier: account_number,
                                 LoginAccountPassword: password
            xml.REQUEST RequestDatetime: request_date do
              xml.KEY _Name: "EMSOrderNumber", _Value: order_number
              xml.REQUEST_DATA do
                xml.VOI_REQUEST MISMOVersionID: mismo_version_id do
                  xml.VOI_REQUEST_DATA VOIRequestType: request_type,
                                       VOIReportRequestActionType: action_type,
                                       VOIReportType: "Other"
                end
              end
            end
          end
        end
      end
    end
  end
end

