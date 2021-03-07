# frozen_string_literal: true

module ErrorsHelper
  def code
    response.status.to_s
  end
end
