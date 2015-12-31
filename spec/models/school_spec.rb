require 'rails_helper'

describe School do
  let(:school)  { FactoryGirl.create(:school) }
  let(:school2) { FactoryGirl.create(:school) }

  subject { school }

  it { should respond_to(:name)  }
  it { should respond_to(:ipads) }
  it { should respond_to(:school_code) }

  describe "with valid name" do
    it "should be valid" do
        expect(school).to be_valid
    end
  end

  describe "with invalid name" do
    it "should not be valid" do
      school.name = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      expect(school).not_to be_valid
    end
  end

  describe "with no name" do
    it "should not be valid" do
      school.name = ""
      expect(school).not_to be_valid
    end
  end

  describe "with duplicate name" do
    it "should not be valid" do
      school2.name = school.name
      expect(school2).not_to be_valid
    end
  end

  describe "with whitespace in the name" do
    it "should not be valid" do
      school.name = "shanghai 10"
      expect(school).not_to be_valid
    end
  end

  describe "with no ipad count" do
    it "should not be valid" do
      school.ipads = nil
      expect(school).not_to be_valid
    end
  end

  describe "with too many ipads" do
    it "should not be valid" do
      wrong_counts = [ -50, 0, 1001 ]
      wrong_counts.each do | count |
        school.ipads = count
        expect(school).not_to be_valid
      end
    end
  end

  describe "school code" do
    it "should have a valid school code" do
      expect(school.school_code).to be_between(1000,9999)
    end
  end
end
