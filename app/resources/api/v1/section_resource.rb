class Api::V1::SectionResource < JSONAPI::Resource
  attributes :duration, :start_minute, :section_type, :actions
end