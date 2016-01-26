require 'rails_helper'

describe Teacher do
  before { @user = Teacher.new(email: "example@user.com", name: "Sample User",
   password: "password", password_confirmation: "password",
   admin: false, school_id: 1) }

  subject { @user }

  it { should respond_to(:admin) }
  it { should respond_to(:email) }
  it { should respond_to(:name)  }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:auth_token) }

  describe "with valid email" do
  	it "should be valid" do
  		emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		emails.each do |valid_email|
  			@user.email = valid_email
  			expect(@user).to be_valid
  		end
  	end
  end

  describe "with invalid email" do
    it "should not be valid" do
    	emails = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
        emails.each do |email|
        	@user.email = email
        	expect(@user).not_to be_valid
        end
    end
  end

  describe "with duplicate email" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "without a name" do
  	before { @user.name = "" }
  	it { should_not be_valid }
  end

  describe "when name is too long" do
  	before { @user.name = "a"*51 }
  	it {should_not be_valid }
  end

  describe "without a password" do
  	before do
  		@user = Teacher.new(name: "Sample", email: "sample_user2@example.com",
       password: "", admin: true)
  	end
  	it { should_not be_valid }
  end
end
