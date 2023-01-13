require 'rails_helper'

RSpec.describe 'Patient Index' do
  before(:each) do
    @hospital_1 = Hospital.create!({name: 'Denver Health'})
    @hospital_2 = Hospital.create!({name: 'Porter Advnentist'})

    @doctor_1 = @hospital_1.doctors.create!({name: 'Brian Cox', specialty: 'Cardiac', university: 'Johns Hopkins'})
    @doctor_2 = @hospital_1.doctors.create!({name: 'Erin Cox', specialty: 'Spinal', university: 'School of Mines'})
    @doctor_3 = @hospital_2.doctors.create!({name: 'Samuel Cox', specialty: 'Neurological', university: 'Fordham'})

    @patient_1 = Patient.create!({name: 'Katie Bryce', age: 26})
    @patient_2 = Patient.create!({name: 'Denny Duquette', age: 48})
    @patient_3 = Patient.create!({name: 'Rebecca Pope', age: 82})
    @patient_4 = Patient.create!({name: 'Zola Shepherd', age: 14})
    @patient_5 = Patient.create!({name: 'Frankie Cox', age: 35})

    DoctorPatient.create!({doctor_id: @doctor_1.id, patient_id: @patient_1.id})
    DoctorPatient.create!({doctor_id: @doctor_1.id, patient_id: @patient_2.id})
    DoctorPatient.create!({doctor_id: @doctor_1.id, patient_id: @patient_3.id})
    DoctorPatient.create!({doctor_id: @doctor_2.id, patient_id: @patient_3.id})
    DoctorPatient.create!({doctor_id: @doctor_2.id, patient_id: @patient_4.id})
    DoctorPatient.create!({doctor_id: @doctor_3.id, patient_id: @patient_5.id})
    DoctorPatient.create!({doctor_id: @doctor_3.id, patient_id: @patient_1.id})
  end

  it 'shows all adult patients in alphabetical order' do
    visit patients_path

    expect(@patient_2.name).to appear_before(@patient_5.name)
    expect(@patient_5.name).to appear_before(@patient_1.name)
    expect(@patient_1.name).to appear_before(@patient_3.name)
    expect(page).to_not have_content(@patient_4.name)
  end
end