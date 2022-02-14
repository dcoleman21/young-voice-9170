class StudentsController < ApplicationController
  def index
    @students = Student.alphabetically 
  end
end
