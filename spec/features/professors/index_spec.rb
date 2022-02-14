require 'rails_helper'

RSpec.describe "the Professor index page" do
  before(:each) do
    @snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
    @hagarid = Professor.create(name: "Rubeus Hagrid", age: 38 , specialty: "Care of Magical Creatures")
    @lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")
  end

  it "can see a list professors and their name, age, specialty" do
    visit "/professors"

    within("#professor-#{@snape.id}") do
      expect(page).to have_content(@snape.name)
      expect(page).to have_content(@snape.age)
      expect(page).to have_content(@snape.specialty)

      expect(page).to_not have_content(@hagarid.name)
      expect(page).to_not have_content(@hagarid.age)
      expect(page).to_not have_content(@hagarid.specialty)

      expect(page).to_not have_content(@lupin.name)
      expect(page).to_not have_content(@lupin.age)
      expect(page).to_not have_content(@lupin.specialty)
    end

    within("#professor-#{@hagarid.id}") do
      expect(page).to have_content(@hagarid.name)
      expect(page).to have_content(@hagarid.age)
      expect(page).to have_content(@hagarid.specialty)

      expect(page).to_not have_content(@lupin.name)
      expect(page).to_not have_content(@lupin.age)
      expect(page).to_not have_content(@lupin.specialty)

      expect(page).to_not have_content(@snape.name)
      expect(page).to_not have_content(@snape.age)
      expect(page).to_not have_content(@snape.specialty)
    end

    within("#professor-#{@lupin.id}") do
      expect(page).to have_content(@lupin.name)
      expect(page).to have_content(@lupin.age)
      expect(page).to have_content(@lupin.specialty)

      expect(page).to_not have_content(@snape.name)
      expect(page).to_not have_content(@snape.age)
      expect(page).to_not have_content(@snape.specialty)

      expect(page).to_not have_content(@hagarid.name)
      expect(page).to_not have_content(@hagarid.age)
      expect(page).to_not have_content(@hagarid.specialty)
    end
  end

  it "can see all professors listed alphabetically." do
    visit "/professors"

    within("#professor-#{@lupin.id}") do
      expect(page).to have_content(@lupin.name)
    end

    within("#professor-#{@hagarid.id}") do
      expect(page).to have_content(@hagarid.name)
    end

    within("#professor-#{@snape.id}") do
      expect(page).to have_content(@snape.name)
    end
  end
end
