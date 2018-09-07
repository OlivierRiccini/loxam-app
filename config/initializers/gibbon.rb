Gibbon::Request.api_key = Rails.application.secrets.mailchimp_api_key
Gibbon::Request.list_id = Rails.application.secrets.mailchimp_list_id
Gibbon::Request.timeout = 15
