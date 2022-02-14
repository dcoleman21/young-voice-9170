class ProfessorsController < ApplicationController
  def index
    @professors = Professor.alphabetically
  end

  def show
    @professor = Professor.find(params[:id])
  end
end
