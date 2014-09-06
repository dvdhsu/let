class ClProperty < ActiveRecord::Base
  has_one [:cl_album, :cl_annotation, :cl_location]
end
