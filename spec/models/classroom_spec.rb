require 'rails_helper'

describe Classroom do
  let(:school) { FactoryGirl.create(:school) }
  let(:room)   { FactoryGirl.create(:classroom) }

  subject { room }

  it { should respond_to(:name)  }
  it { should respond_to(:school_id) }

  describe "with valid name" do
    it "should be valid" do
        expect(room).to be_valid
    end
  end

  describe "without a name" do
    it "should not be valid" do
      room.name = nil
      expect(room).not_to be_valid
    end
  end

  describe "with an invalid name" do
    it "should not be valid" do
      room.name = ""
      expect(room).not_to be_valid
    end
  end
end
