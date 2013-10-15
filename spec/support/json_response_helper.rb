module JsonResponseHelper
  def parsed_json_response
    HashWithIndifferentAccess.new(ActiveSupport::JSON.decode(response.body))
  end
end
