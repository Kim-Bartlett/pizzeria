class SpecialtyTypesController < ApplicationController
  def index
    @specialty_types = SpecialtyType.all
  end
end
