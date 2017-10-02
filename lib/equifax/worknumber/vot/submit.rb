module Equifax
  module Worknumber
    module VOT
      class Submit < ::Equifax::Worknumber::VOT::Base

        def self.required_fields
          super + [ :authform_content, :order_record_id, :requested_years, :transcript_requested ]
        end

        def self.optional_fields
          super + [ :request_date ]
        end

        private

        def xml_builder
          xml_container do |xml|
            xml.REQUESTING_PARTY _Name: lender_name do
              xml.CONTACT_DETAIL _EmployeeIdentifier: "" do
                xml.CONTACT_POINT _RoleType: "Work",
                                  _Type: "Phone",
                                  _Value: "",
                                  _PreferenceIndicator: "Y"
              end
            end
            xml.SUBMITTING_PARTY _Name: vendor_id,
                                 LoginAccountIdentifier: account_number,
                                 LoginAccountPassword: password do
              xml.PREFERRED_RESPONSE _Format: "XML", _Method: "HTTPS", _Type: "PDF"
            end
            xml.REQUEST RequestDatetime: request_date do
              xml.KEY _Name: "OrderRecordID", _Value: order_record_id
              xml.REQUEST_DATA do
                xml.VOI_REQUEST LenderCaseIdentifier: lender_case_id, MISMOVersionID: mismo_version_id do
                  xml.VOI_REQUEST_DATA VOIRequestType: request_type,
                                       VOIReportRequestActionType: "Submit",
                                       VOIReportRequestActionTypeOtherDescription: "4506T",
                                       VOIReportType: "Other"
                  xml.LOAN_APPLICATION do
                    xml.BORROWER _PrintPositionType: "Borrower",
                                 _SSN: ssn,
                                 _FirstName: first_name,
                                 _MiddleName: middle_name,
                                 _LastName: last_name do
                      xml._RESIDENCE BorrowerResidencyType: "Current",
                                     _City: city,
                                     _State: state,
                                     _StreetAddress: street_address,
                                     _PostalCode: postal_code
                    end
                  end
                  xml.EXTENSION do
                    xml.EXTENSION_SECTION do
                      xml.EXTENSION_SECTION_DATA do
                        xml.TAX_RETURN_VERIFICATION_DATA do
                          xml.FORM_DETAIL _TranscriptRequested: transcript_requested, _Type: "Y"
                          requested_years.each do |year|
                            xml.VERIFICATION_PERIOD_DETAIL _Year: year
                          end
                        end
                        xml.EMBEDDED_FILE MIMEType: "image/tiff",
                                          _Name: "Form4506TaxTranscriptRequest.tiff",
                                          _EncodingType: "Base64",
                                          MISMOVersionID: mismo_version_id do
                          xml.DOCUMENT authform_content
                        end
                      end
                    end
                  end

                end
              end
            end
          end
        end

        def request_date
          super.presence || Time.now.strftime("%Y-%m-%d")
        end

      end
    end
  end
end


