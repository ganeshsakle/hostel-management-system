class HostelSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :phone, :address, :created_at
end
