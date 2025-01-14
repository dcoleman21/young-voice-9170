require 'rails_helper'

RSpec.describe "students index page" do
  before(:each) do
    @snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
    @hagarid = Professor.create(name: "Rubeus Hagrid", age: 38 , specialty: "Care of Magical Creatures")
    @lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

    @harry = Student.create(name: "Harry Potter" , age: 11 , house: "Gryffindor" )
    @malfoy = Student.create(name: "Draco Malfoy" , age: 12 , house: "Slytherin" )
    @longbottom = Student.create(name: "Neville Longbottom" , age: 11 , house: "Gryffindor" )

    ProfessorStudent.create(student_id: @harry.id, professor_id: @snape.id)
    ProfessorStudent.create(student_id: @harry.id, professor_id: @hagarid.id)
    ProfessorStudent.create(student_id: @harry.id, professor_id: @lupin.id)
    ProfessorStudent.create(student_id: @malfoy.id, professor_id: @hagarid.id)
    ProfessorStudent.create(student_id: @malfoy.id, professor_id: @lupin.id)
    ProfessorStudent.create(student_id: @longbottom.id, professor_id: @snape.id)
  end

  it "can see a list of students and the number of professors each one has" do
    visit "/students"

    expect(page).to have_content("Students Index")

    within("#student-#{@harry.id}") do
      expect(page).to have_content(@harry.name)
      expect(page).to have_content(@harry.number_of_professors)

      expect(page).to_not have_content(@malfoy.name)
      expect(page).to_not have_content(@malfoy.number_of_professors)

      expect(page).to_not have_content(@longbottom.name)
      expect(page).to_not have_content(@longbottom.number_of_professors)
    end

    within("#student-#{@malfoy.id}") do
      expect(page).to have_content(@malfoy.name)
      expect(page).to have_content(@malfoy.number_of_professors)

      expect(page).to_not have_content(@harry.name)
      expect(page).to_not have_content(@harry.number_of_professors)

      expect(page).to_not have_content(@longbottom.name)
      expect(page).to_not have_content(@longbottom.number_of_professors)
    end

    within("#student-#{@longbottom.id}") do
      expect(page).to have_content(@longbottom.name)
      expect(page).to have_content(@longbottom.number_of_professors)

      expect(page).to_not have_content(@harry.name)
      expect(page).to_not have_content(@harry.number_of_professors)

      expect(page).to_not have_content(@malfoy.name)
      expect(page).to_not have_content(@malfoy.number_of_professors)
    end
  end

  it "can see all students listed alphabetically." do
    visit "/students"

    within("#student-#{@malfoy.id}") do
      expect(page).to have_content(@malfoy.name)
    end

    within("#student-#{@harry.id}") do
      expect(page).to have_content(@harry.name)
    end

    within("#student-#{@longbottom.id}") do
      expect(page).to have_content(@longbottom.name)
    end
  end
end
