class HostelSerializer
  include JSONAPI::Serializer
  attributes :id, :room_description, :created_at
end
