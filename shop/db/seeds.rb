# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name :=> 'Chicago' }, { :name :=> 'Copenhagen' }])
#   Major.create(:name :=> 'Daley', :city :=> cities.first)
Category.create(:name => 'Korut')
Category.create(:name => 'Kortit')
Category.create(:name => 'Saippuat')
Category.create(:name => 'Kaulakorut', :parent => 'Korut')
Category.create(:name => 'Korvakorut', :parent => 'Korut')
Category.create(:name => 'Rannekorut', :parent => 'Korut')
Category.create(:name => 'Nilkkakorut', :parent => 'Korut')
Category.create(:name => 'Kännykkäkorut', :parent => 'Korut')
Category.create(:name => 'Setit', :parent => 'Korut')
Item.create(:name=> "Suojanen", :description=> "testausta", :price=> 15, :discount=> 0, :saldo=> 1, :picurl=> "suojanen.jpg", :category_id=> 3)
Item.create(:name=> "Manatee", :description=> "Animaatio isosta merieläimestä", :price=> 200, :discount=> 0, :saldo=> 1, :picurl=> "kwSPW.gif", :category_id=> 9)
Item.create(:name=> "Helly Hansen", :description=> "Testaamme monipuolisia tekstejä ja pitkiä kuvauksia. Miten mahtaa käydä tässä?", :price=> 100, :discount=> 0, :saldo=> 1, :picurl=> "93203.jpg", :category_id=> 9)
Item.create(:name=> "Pöh", :description=> "Loputtomasti testausta", :price=> 5, :discount=> 0, :saldo=> 1, :picurl=> "slh1.png", :category_id=> 7)
Item.create(:name=> "Riikunkanahienokoru", :description=> "This file should contain all the record creation needed to seed the database with its default values.The data can then be loaded with the rake  (or created alongside the db with )", :price=> 40.5, :discount=> 0, :saldo=> 1, :picurl=> "farkut.jpg", :category_id=> 4)
Item.create(:name=> "Jalin Riikunkanahienokoru", :description=> "testausta", :price=> 4, :discount=> 0, :saldo=> 1, :picurl=> "volvov70.jpg", :category_id=> 3)

