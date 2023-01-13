class PatientsController < ApplicationController
  def index
    @patients = Patient.adult_patients_ordered_by_name
  end
end