# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
Category.create(:name => 'Korut')
Category.create(:name => 'Kortit')
Category.create(:name => 'Saippuat')
Category.create(:name => 'Kaulakorut', :parent => 'Korut')
Category.create(:name => 'Korvakorut', :parent => 'Korut')
Category.create(:name => 'Rannekorut', :parent => 'Korut')
Category.create(:name => 'Nilkkakorut', :parent => 'Korut')
Category.create(:name => 'Kännykkäkorut', :parent => 'Korut')
Category.create(:name => 'Setit', :parent => 'Korut')
Category.create(:parent => 'Kortit')
Category.create(:parent => 'Saippuat')
