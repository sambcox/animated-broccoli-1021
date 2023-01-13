class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients

  def find_doctor_patient(patient)
    self.doctor_patients.find_by_patient_id(patient.id)
  end
end
