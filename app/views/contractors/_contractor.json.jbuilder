json.extract! contractor, :id, :first_name, :last_name, :company, :email, :password_digest, :maintenance_request_id, :phone, :created_at, :updated_at
json.url contractor_url(contractor, format: :json)
