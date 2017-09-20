module Equifax
  module Worknumber
    module VOT
      class Retrieve < ::Equifax::Worknumber::VOT::Status
        # API for retrive and status is same, only differece is VOIReportRequestActionType
        def action_type
          "Retrieve"
        end
      end
    end
  end
end
