class ClProperty < ActiveRecord::Base
  has_one :cl_annotation
  has_one :cl_location
  has_many :cl_images
end
