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
    DoctorPatient.create!({doctor_id: @doctor_1.id, patient_id: @patient_2.id})
    DoctorPatient.create!({doctor_id: @doctor_1.id, patient_id: @patient_3.id})
    DoctorPatient.create!({doctor_id: @doctor_2.id, patient_id: @patient_3.id})
    DoctorPatient.create!({doctor_id: @doctor_2.id, patient_id: @patient_4.id})
    DoctorPatient.create!({doctor_id: @doctor_3.id, patient_id: @patient_5.id})
    DoctorPatient.create!({doctor_id: @doctor_3.id, patient_id: @patient_1.id})
  end

  it ' shows all doctor information' do
    visit doctor_path(@doctor_1)

    expect(page).to have_content(@doctor_1.name)
    expect(page).to have_content(@doctor_1.specialty)
    expect(page).to have_content(@doctor_1.university)
    expect(page).to_not have_content(@doctor_2.name)

    visit doctor_path(@doctor_2)

    expect(page).to have_content(@doctor_2.name)
    expect(page).to have_content(@doctor_2.specialty)
    expect(page).to have_content(@doctor_2.university)
    expect(page).to_not have_content(@doctor_1.name)
  end

  it 'shows the hospital where the doctor works' do
    visit doctor_path(@doctor_1)

    expect(page).to have_content(@hospital_1.name)
    expect(page).to_not have_content(@hospital_2.name)

    visit doctor_path(@doctor_3)

    expect(page).to have_content(@hospital_2.name)
    expect(page).to_not have_content(@hospital_1.name)
  end

  it 'shows the names of all patients for the doctor' do
    visit doctor_path(@doctor_1)

    expect(page).to have_content(@patient_1.name)
    expect(page).to have_content(@patient_2.name)
    expect(page).to have_content(@patient_3.name)
    expect(page).to_not have_content(@patient_4.name)

    visit doctor_path(@doctor_2)

    expect(page).to_not have_content(@patient_1.name)
    expect(page).to_not have_content(@patient_2.name)
    expect(page).to have_content(@patient_3.name)
    expect(page).to have_content(@patient_4.name)
  end

  it 'has a button to remove a patient from this doctor' do
    visit doctor_path(@doctor_1)

    within("#patient_#{@patient_3.id}") do
      click_button('Remove Patient')
    end
    expect(current_path).to eq(doctor_path(@doctor_1))
    expect(page).to_not have_content(@patient_3.name)

    visit doctor_path(@doctor_2)

    expect(page).to have_content(@patient_3.name)
  end
end