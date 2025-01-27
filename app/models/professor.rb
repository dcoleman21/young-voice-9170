class Professor < ApplicationRecord
  # include Alphabetically

  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :specialty

  has_many :professor_students
  has_many :students, through: :professor_students

  def student_average_age
    students.average(:age).to_i
  end

  def self.alphabetically
    order(name: :asc)
  end
end
