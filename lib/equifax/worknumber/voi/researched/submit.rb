module Equifax
  module Worknumber
    module VOI
      module Researched
        class Submit < ::Equifax::Worknumber::Base
          def self.call(opts)
            voe = Equifax::Worknumber::VOI::Researched::Submit.new(opts)

            Equifax::Client.request(
              voe.send(:url),
              { request_method: :post },
              voe.send(:request_params),
            )
          end

          def params
            self.send(:opts)
          end

          def self.required_fields
            super + [
              :authform_name,
              :authform_content,
              # :organization_name,
            ]
          end

          def self.optional_fields
            super + [
              :employer_duns_number,
              :employer_division,
            ]
          end

          def xml
            <<-eos
              <?xml version="1.0" encoding="utf-8"?>
              <REQUEST_GROUP MISMOVersionID="2.3.1">
                <REQUESTING_PARTY _Name="#{params.fetch(:vendor_id, '')}"/>
                <SUBMITTING_PARTY _Name="#{params.fetch(:employer_name, '')}"/>
                <REQUEST InternalAccountIdentifier="#{params.fetch(:account_number, '')}" LoginAccountIdentifier="#{params.fetch(:account_number, '')}" LoginAccountPassword="#{params.fetch(:password, '')}" RequestingPartyBranchIdentifier="#{params.fetch(:organization_name, '')}">
                  <KEY _Name="EMSEmployerCode" _Value="#{params.fetch(:employer_code, '')}"/>
                  <KEY _Name="EMSEmployerDunsNumber" _Value="#{params.fetch(:employer_duns_number, '')}"/>
                  <KEY _Name="EMSEmployerDivision" _Value="#{params.fetch(:employer_division, '')}"/>
                  <KEY _Name="EmployerVerificationDocumentsRequired" _Value="N"/>
                  <KEY _Name="CallRecordingRequired" _Value="N"/>
                  <REQUEST_DATA>
                    <VOI_REQUEST LenderCaseIdentifier="#{params.fetch(:lender_case_id, '')}" RequestingPartyRequestedByName="#{params.fetch(:lender_name, '')}">
                      <VOI_REQUEST_DATA VOIReportType="Other" VOIReportTypeOtherDescription="RVVOI" VOIRequestType="Individual" VOIReportRequestActionType="Submit" BorrowerID="Borrower"/>
                      <LOAN_APPLICATION>
                        <BORROWER BorrowerID="Borrower" _FirstName="#{params.fetch(:first_name, '')}" _MiddleName="#{params.fetch(:middle_name, '')}" _LastName="#{params.fetch(:last_name, '')}" _PrintPositionType="Borrower" _SSN="#{params.fetch(:ssn, '')}">
                          <_RESIDENCE _StreetAddress="#{params.fetch(:street_address, '')}" _City="#{params.fetch(:city, '')}" _State="#{params.fetch(:state, '')}" _PostalCode="#{params.fetch(:postal_code, '')}" BorrowerResidencyType="Current"/>
                          <EMPLOYER _Name="#{params.fetch(:employer_name, '')}" _TelephoneNumber="#{params.fetch(:employer_phone, '')}" _StreetAddress="#{params.fetch(:employer_address, '')}" _City="#{params.fetch(:employer_city, '')}" _State="#{params.fetch(:employer_state, '')}" _PostalCode="#{params.fetch(:employer_postal_code, '')}"/>
                        </BORROWER>
                      </LOAN_APPLICATION>
                      <EXTENSION>
                        <EXTENSION_SECTION>
                          <EXTENSION_SECTION_DATA>
                            <EMBEDDED_FILE MIMEType="application/pdf" _Name="#{params.fetch(:authform_name, '')}" _EncodingType="Base64" _Type="pdf">
                              <DOCUMENT>#{params.fetch(:authform_content, '')}
                              </DOCUMENT>
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
