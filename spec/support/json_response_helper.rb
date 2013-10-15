module JsonResponseHelper
  def parsed_json_response
    ActiveSupport::JSON.decode(response.body)
  end
end
