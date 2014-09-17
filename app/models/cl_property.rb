class ClProperty < ActiveRecord::Base
  has_one :cl_annotation, dependent: :destroy
  has_one :cl_location, dependent: :destroy
  has_many :cl_images, dependent: :destroy
end
