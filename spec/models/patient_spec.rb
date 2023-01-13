require 'rails_helper'

RSpec.describe Patient do
  it { should have_many :doctor_patients }
  it { should have_many(:doctors).through(:doctor_patients) }

  describe 'Class Methods' do
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

    it 'returns only of age patients' do
      expect(Patient.adult_patients_ordered_by_name).to eq([@patient_2, @patient_5, @patient_1, @patient_3])
    end
  end
end