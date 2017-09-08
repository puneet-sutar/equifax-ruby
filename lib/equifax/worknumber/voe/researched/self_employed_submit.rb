module Equifax
  module Worknumber
    module VOE
      module Researched
        class SelfEmployedSubmit < ::Equifax::Worknumber::Base
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
              :tax_preparer_company_name,
              :tax_preparer_city,
              :tax_preparer_state,
              :tax_preparer_postal_code,
              :tax_preparer_phone_number,
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
                  <KEY _Name="EMSEmployerCode" _Value="#{employer_code}"/>
                  <REQUEST_DATA>
                    <VOI_REQUEST LenderCaseIdentifier="#{lender_case_id}">
                      <VOI_REQUEST_DATA VOIReportTypeOtherDescription="WVOE" VOIReportRequestActionType="Submit"/>
                      <LOAN_APPLICATION>
                        <BORROWER _FirstName="#{first_name}" _MiddleName="#{middle_name}" _LastName="#{last_name}" _SSN="#{ssn}" _PrintPositionType="Borrower">
                          <EMPLOYER _Name="#{employer_name}" _City="#{employer_city}" _State="#{employer_state}" _PostalCode="#{employer_postal_code}" _TelephoneNumber="#{employer_phone}" EmploymentBorrowerSelfEmployedIndicator="Y"/>
                            <SELF_EMPLOYMENT_INFO BusinessType="Retail">
                                <TAX_PREPARER _VerificationType="Both" _City="#{tax_preparer_city}" _MiddleName="#{tax_preparer_middle_name}" _FirstName="#{tax_preparer_first_name}" _PostalCode="#{tax_preparer_postal_code}" _State="#{tax_preparer_state}" _Address1="#{tax_preparer_address}"
                                _CompanyName="#{tax_preparer_company_name}" _FaxNumber="#{tax_preparer_fax}" _Address2="#{tax_preparer_address_cont}" _PhoneNumber="#{tax_preparer_phone_number}" _EmailAddress="#{tax_preparer_email}" _Title="#{tax_preparer_title}" _LastName="#{tax_preparer_last_name}">
                                </TAX_PREPARER>
                             </SELF_EMPLOYMENT_INFO>
                           </EMPLOYER>
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
