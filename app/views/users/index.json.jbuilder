json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :avatar_url, :password_digest, :isadmin
  json.url user_url(user, format: :json)
end
