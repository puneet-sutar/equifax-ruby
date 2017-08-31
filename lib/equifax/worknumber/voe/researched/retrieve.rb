module Equifax
  module Worknumber
    module VOE
      module Researched
        class Retrieve < ::Equifax::Worknumber::Base
          def self.call(opts)
            voe = Equifax::Worknumber::VOE::Researched::Retrieve.new(opts)

            Equifax::Client.request(
              voe.send(:url),
              { request_method: :post },
              voe.send(:request_params),
            )
          end
        end

        def self.required_fields
          super + [
            :order_number,
            :organization_name,
          ]
        end

        private

        def xml
          <<-eos
            <?xml version="1.0" encoding="utf-8"?>
            <REQUEST_GROUP>
              <SUBMITTING_PARTY _Name="#{vendor_id}"></SUBMITTING_PARTY>
              <REQUEST LoginAccountIdentifier="#{account_number}" LoginAccountPassword="#{password}">
                <KEY _Name="EMSOrderNumber" _Value="#{order_number}" />
                <REQUEST_DATA>
                  <VOI_REQUEST LenderCaseIdentifier="#{lender_case_id}">
                    <VOI_REQUEST_DATA VOIReportRequestActionType="Retrieve" VOIReportTypeOtherDescription="RVVOE"/>
                    <LOAN_APPLICATION>
                      <BORROWER _FirstName="#{first_name}" _LastName="#{last_name}" _SSN="#{ssn}" _PrintPositionType="Borrower"></BORROWER>
                    </LOAN_APPLICATION>
                  </VOI_REQUEST>
                </REQUEST_DATA>
              </REQUEST>
            </REQUEST_GROUP>
          eos
        end
      end
    end
  end
end
