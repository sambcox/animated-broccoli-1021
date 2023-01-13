require 'rails_helper'

RSpec.describe 'Doctor Show' do
  before(:each) do
    @hospital_1 = Hospital.create!({name: 'Denver Health'})
    @hospital_2 = Hospital.create!({name: 'Porter Advnentist'})

    @doctor_1 = @hospital_1.doctors.create!({name: 'Brian Cox', speciality: 'Cardiac', university: 'Johns Hopkins'})
    @doctor_2 = @hospital_1.doctors.create!({name: 'Erin Cox', speciality: 'Spinal', university: 'School of Mines'})
    @doctor_3 = @hospital_2.doctors.create!({name: 'Samuel Cox', speciality: 'Neurological', university: 'Fordham'})

    @patient_1 = Patient.create!({name: Faker::FunnyName.name, age: 26})
    @patient_2 = Patient.create!({name: Faker::FunnyName.name, age: 48})
    @patient_3 = Patient.create!({name: Faker::FunnyName.name, age: 82})
    @patient_4 = Patient.create!({name: Faker::FunnyName.name, age: 14})
    @patient_5 = Patient.create!({name: Faker::FunnyName.name, age: 35})

    DoctorPatient.create!({doctor_id: @doctor_1.id, patient_id: @patient_1.id})
    DoctorPatient.create!({doctor_id: @doctor_1.id, patient_id: @patient_2.id})
    DoctorPatient.create!({doctor_id: @doctor_1.id, patient_id: @patient_3.id})
    DoctorPatient.create!({doctor_id: @doctor_2.id, patient_id: @patient_3.id})
    DoctorPatient.create!({doctor_id: @doctor_2.id, patient_id: @patient_4.id})
    DoctorPatient.create!({doctor_id: @doctor_3.id, patient_id: @patient_5.id})
    DoctorPatient.create!({doctor_id: @doctor_3.id, patient_id: @patient_1.id})
  end
end