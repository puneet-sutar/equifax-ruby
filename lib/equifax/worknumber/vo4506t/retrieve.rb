module Equifax
  module Worknumber
    module VO4506T
      class Retrieve < ::Equifax::Worknumber::VO4506T::Status
        # API for retrive and status is same, only differece is VOIReportRequestActionType
        def action_type
          "Retrieve"
        end
      end
    end
  end
end
