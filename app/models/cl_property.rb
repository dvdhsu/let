class ClProperty < ActiveRecord::Base
  has_one :cl_album
  has_one :cl_annotation
  has_one :cl_location
end
