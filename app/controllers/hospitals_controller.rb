class HospitalsController < ApplicationController
  def show
    @hospital = Hospital.find(params[:id])
    @doctors = @hospital.doctors_by_patient_count
  end
end