require 'bike'

describe Bike do

  it 'enables a user to report it as broken' do
    subject.working = false
    expect(subject.working).to eq false
  end

end
