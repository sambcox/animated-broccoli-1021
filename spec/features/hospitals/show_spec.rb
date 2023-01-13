require 'rails_helper'

RSpec.describe 'Doctor Show' do
  before(:each) do
    @hospital_1 = Hospital.create!({name: 'Denver Health'})
    @hospital_2 = Hospital.create!({name: 'Porter Advnentist'})

    @doctor_1 = @hospital_1.doctors.create!({name: 'Brian Cox', specialty: 'Cardiac', university: 'Johns Hopkins'})
    @doctor_2 = @hospital_1.doctors.create!({name: 'Erin Cox', specialty: 'Spinal', university: 'School of Mines'})
    @doctor_3 = @hospital_2.doctors.create!({name: 'Samuel Cox', specialty: 'Neurological', university: 'Fordham'})

    @patient_1 = Patient.create!({name: Faker::FunnyName.name, age: 26})
    @patient_2 = Patient.create!({name: Faker::FunnyName.name, age: 48})
    @patient_3 = Patient.create!({name: Faker::FunnyName.name, age: 82})
    @patient_4 = Patient.create!({name: Faker::FunnyName.name, age: 14})
    @patient_5 = Patient.create!({name: Faker::FunnyName.name, age: 35})

    DoctorPatient.create!({doctor_id: @doctor_1.id, patient_id: @patient_1.id})
    DoctorPatient.create!({doctor_id: @doctor_2.id, patient_id: @patient_2.id})
    DoctorPatient.create!({doctor_id: @doctor_1.id, patient_id: @patient_3.id})
    DoctorPatient.create!({doctor_id: @doctor_2.id, patient_id: @patient_3.id})
    DoctorPatient.create!({doctor_id: @doctor_2.id, patient_id: @patient_4.id})
    DoctorPatient.create!({doctor_id: @doctor_3.id, patient_id: @patient_5.id})
    DoctorPatient.create!({doctor_id: @doctor_3.id, patient_id: @patient_1.id})
  end

  it 'shows the hospital name' do
    visit hospital_path(@hospital_1)

    expect(page).to have_content(@hospital_1.name)
    expect(page).to_not have_content(@hospital_2.name)
  end

  it 'shows the names of all doctors that work for the hospital' do
    visit hospital_path(@hospital_1)
    
    expect(page).to have_content(@doctor_1.name)
    expect(page).to have_content(@doctor_2.name)
    expect(page).to_not have_content(@doctor_3.name)
  end

  it 'shows the count of all patients for each doctor' do
    visit hospital_path(@hospital_1)

    within "#doctor_#{@doctor_1.id}" do
      expect(page).to have_content('2 patients')
    end

    within "#doctor_#{@doctor_2.id}" do
      expect(page).to have_content('3 patients')
    end
  end

  it 'shows each doctor in order of patient count' do
    visit hospital_path(@hospital_1)

    expect(@doctor_2.name).to appear_before(@doctor_1.name)
  end
end