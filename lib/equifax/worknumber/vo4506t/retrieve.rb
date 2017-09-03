module Equifax
  module Worknumber
    module VO4506T
      class Retrieve < ::Equifax::Worknumber::VO4506T::Base
        # def self.required_fields
        #   ::Equifax::Worknumber::Base.required_fields + [
        #     :order_number,
        #     :organization_name,
        #   ]
        # end
        private

        def xml
          <<-eos
              <?xml version="1.0" encoding="utf-8"?>
              <REQUEST_GROUP MISMOVersionID="2.3.1">
                <SUBMITTING_PARTY _Name="#{vendor_id}" />
                <REQUEST InternalAccountIdentifier="#{account_number}"
                  LoginAccountIdentifier="#{account_number}" LoginAccountPassword="#{password}"
                  RequestingPartyBranchIdentifier="#{organization_name}">
                  <KEY _Name="EMSEmployerCode" _Value="#{employer_code}" />
                  <KEY _Name="EMSOrderNumber" _Value="#{order_number}" />
                  <REQUEST_DATA>
                    <VOI_REQUEST LenderCaseIdentifier="#{lender_case_id}"
                      RequestingPartyRequestedByName="QTP">
                      <VOI_REQUEST_DATA VOIReportType="Other"
                        VOIReportTypeOtherDescription="RVVOI" VOIRequestType="Individual"
                        VOIRequestID="RVVOI_RETRIEVE" VOIReportRequestActionType="Retrieve"
                        BorrowerID="Borrower" />
                      <LOAN_APPLICATION>
                        <BORROWER BorrowerID="Borrower" _FirstName="#{first_name}"
                          _MiddleName="#{middle_name}" _LastName="#{last_name}" _PrintPositionType="Borrower"
                          _SSN="799005001">
                          <_RESIDENCE _StreetAddress="#{street_address}" _City="#{city}"
                            _State="#{state}" _PostalCode="#{postal_code}" BorrowerResidencyType="Current" />
                        </BORROWER>
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
