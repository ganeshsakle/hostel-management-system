class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :full_name, :user_role, :created_at
end
