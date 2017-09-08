module Equifax
  module Worknumber
    module VOI
      module Researched
        class Retrieve < ::Equifax::Worknumber::Base
          def self.call(opts)
            voi = Equifax::Worknumber::VOI::Researched::Retrieve.new(opts)

            Equifax::Client.request(
              voi.send(:url),
              { request_method: :post },
              voi.send(:request_params),
            )
          end

          def self.required_fields
            ::Equifax::Worknumber::Base.required_fields + [
              :order_number,
              :organization_name,
            ]
          end

          def xml
            <<-eos
              <?xml version="1.0" encoding="utf-8"?>
              <REQUEST_GROUP>
                <SUBMITTING_PARTY _Name="#{vendor_id}"></SUBMITTING_PARTY>
                <REQUEST LoginAccountIdentifier="#{account_number}" LoginAccountPassword="#{password}">
                  <KEY _Name="EMSOrderNumber" _Value="#{order_number}" />
                  <REQUEST_DATA>
                    <VOI_REQUEST LenderCaseIdentifier="#{lender_case_id}">
                      <VOI_REQUEST_DATA VOIReportRequestActionType="Retrieve" VOIReportTypeOtherDescription="RVVOI"/>
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
end
