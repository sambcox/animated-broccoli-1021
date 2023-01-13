require 'rails_helper'

RSpec.describe DoctorPatient do
  it { should belong_to :patient }
  it { should belong_to :doctor }
end