require 'rails_helper'

RSpec.describe "Professor show page" do
  before(:each) do
    @snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
    @hagarid = Professor.create(name: "Rubeus Hagrid", age: 38 , specialty: "Care of Magical Creatures")
    @lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

    @harry = @snape.students.create(name: "Harry Potter" , age: 11 , house: "Gryffindor" )
    @malfoy = @hagarid.students.create(name: "Draco Malfoy" , age: 12 , house: "Slytherin" )
    @longbottom = @lupin.students.create(name: "Neville Longbottom" , age: 11 , house: "Gryffindor" )
  end

  it "can see a list of names of the students the professors have" do
    visit "/professors/#{@snape.id}"

    expect(page).to have_content("Professor #{@snape.name}'s students")
    expect(page).to have_content("Students:")
    expect(page).to have_content(@harry.name)
  end

  it "can see the average age of all students for that professor" do
    visit "/professors/#{@snape.id}"

    expect(page).to have_content("Average Age: #{@snape.student_average_age}")
  end
end
