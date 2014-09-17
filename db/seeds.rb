# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

case Rails.env
# just manually set anchor for now
when "development"
  Anchor.create!(anchor: "1313701192", num_polled: 0);
when "test"
  Anchor.create!(anchor: "1313701192", num_polled: 0);
when "production"
  Anchor.create!(anchor: "1313701192", num_polled: 0);
end
