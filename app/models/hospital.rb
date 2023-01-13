class Hospital < ApplicationRecord
  has_many :doctors

  def doctors_by_patient_count
    self.doctors.joins(:doctor_patients).select('doctors.*, count(doctor_patients) as patient_count').group(:id).order('patient_count DESC')
  end
end
