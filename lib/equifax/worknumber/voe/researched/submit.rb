module Equifax
  module Worknumber
    module VOE
      module Researched
        class Submit < ::Equifax::Worknumber::Base
          def self.call(opts)
            voe = Equifax::Worknumber::VOE::Researched::Submit.new(opts)

            Equifax::Client.request(
              voe.send(:url),
              { request_method: :post },
              voe.send(:request_params),
            )
          end

          def self.required_fields
            ::Equifax::Worknumber::Base.required_fields + [
              :authform_name,
              :authform_content,
              :organization_name,
            ]
          end

          def self.optional_fields
            ::Equifax::Worknumber::Base.optional_fields + [
              :employer_duns_number,
              :employer_division,
            ]
          end

          private

          def xml
            <<-eos
              <?xml version="1.0" encoding="utf-8"?>
              <REQUEST_GROUP>
                <SUBMITTING_PARTY _Name="#{vendor_id}">
                  <PREFERRED_RESPONSE _Format="PDF"></PREFERRED_RESPONSE>
                </SUBMITTING_PARTY>
                <REQUEST LoginAccountIdentifier="#{account_number}" LoginAccountPassword="#{password}">
                  <REQUEST_DATA>
                    <VOI_REQUEST LenderCaseIdentifier="#{lender_case_id}">
                      <VOI_REQUEST_DATA VOIReportTypeOtherDescription="WVOE" VOIReportRequestActionType="Submit"/>
                      <LOAN_APPLICATION>
                        <BORROWER _FirstName="#{first_name}" _MiddleName="#{middle_name}" _LastName="#{last_name}" _SSN="#{ssn}" _PrintPositionType="Borrower">
                          <EMPLOYER _Name="#{employer_name}" _City="#{employer_city}" _State="#{employer_state}" _PostalCode="#{employer_postal_code}" _TelephoneNumber="#{employer_phone}"/>
                        </BORROWER>
                      </LOAN_APPLICATION>
                      <EXTENSION>
                        <EXTENSION_SECTION>
                          <EXTENSION_SECTION_DATA>
                            <EMBEDDED_FILE _Name="#{authform_name}" _EncodingType="Base64">
                              <DOCUMENT>#{authform_content}</DOCUMENT>
                            </EMBEDDED_FILE>
                          </EXTENSION_SECTION_DATA>
                        </EXTENSION_SECTION>
                      </EXTENSION>
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
