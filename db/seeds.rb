

Cat.destroy_all

breakfast = Cat.create!(name: 'Breakfast', birth_date: Date.today, color: 'smoke', description: 'What a great cat', sex: 'M')
sennacy = Cat.create!(name: 'Sennacy', birth_date: 5.year.ago, color: 'tabby', description: 'What a bad cat', sex: 'F')

CatRentalRequest.destroy_all

c1 = CatRentalRequest.create!(cat_id: breakfast.id, start_date: 1.year.ago, end_date:2.month.ago)
c2 = CatRentalRequest.create!(cat_id: breakfast.id, start_date: 2.year.ago, end_date:3.month.ago, status: "APPROVED")
c3 = CatRentalRequest.create!(cat_id: sennacy.id, start_date: 1.year.ago, end_date:2.month.ago)
