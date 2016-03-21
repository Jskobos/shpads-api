require 'rails_helper'

describe "Adding and Editing Teachers" do
  let(:admin)      { FactoryGirl.create(:admin) }
  let(:school)     { FactoryGirl.create(:school) }
  let(:teacher)    { FactoryGirl.create(:teacher) }
  let(:teachers)   { FactoryGirl.create_list(:teacher, 10) }


  before do
    @user = {
      email: "example@ef.com", name: "Sample User", password: "password",
      password_confirmation: "password", admin: false, school_id: school.id
    }
    @params =  { teacher: @user }
  end

  def json
    JSON.parse(response.body)
  end

  def get_request(url, user, params={})
    header = { Authorization: "Token token=#{user.auth_token}" }
    get url, params, header
  end

  def post_request(url, user, params={})
    header = { Authorization: "Token token=#{user.auth_token}" }
    post url, params, header
  end

  def put_request(url, user=admin, params={})
    header = { Authorization: "Token token=#{user.auth_token}" }
    put url, params, header
  end

  describe "Creating a new teacher" do
    it "should reject unauthenticated requests" do
      post '/teachers', @params
      expect(response).to have_http_status(401)
      expect(json['error']).to eq("Bad Token")
    end

    it "should reject requests from a non-admin user" do
      post_request '/teachers', teacher, @params
      expect(response).to have_http_status(401)
      expect(json['error']).to eq("Bad Token")
    end

    it "should accept a valid teacher" do
      post_request '/teachers', admin, @params
      expect(response).to have_http_status(201)
    end

    it "should reject an invalid teacher" do
      @user['password'] = "abc"
      params = { teacher: @user }
      post_request '/teachers', admin, params
      expect(response).to have_http_status(422)
    end
  end

  describe "Editing a teacher" do
    it "should update a teacher's password" do
      new_password = "changepassword"
      params = { teacher: { password: new_password,
        password_confirmation: new_password } }
      put_request("/teachers/#{teacher.id}", user=teacher, params=params)
      updated_teacher = Teacher.find(teacher.id)
      expect(response).to have_http_status(204)
      expect(updated_teacher.authenticate(new_password)).not_to be(false)
    end

    it "should refuse to edit a password if the confirmation does not match" do
      old_password = teacher.password
      new_password = "changepassword"
      wrong_confirm = "changepassword2"
      params = { teacher: { password: new_password,
        password_confirmation: wrong_confirm } }
      put_request("/teachers/#{teacher.id}", user=teacher, params=params)
      updated_teacher = Teacher.find(teacher.id)
      expect(response).to have_http_status(422)
      expect(updated_teacher.authenticate(new_password)).to be(false)
      expect(updated_teacher.authenticate(old_password)).not_to be(false)
    end

    it "should refuse to edit a password if logged in as another user" do
      new_password = "changepassword"
      params = { teacher: { password: new_password,
        password_confirmation: new_password } }
      put_request("/teachers/#{teacher.id}", user=admin, params=params)
      updated_teacher = Teacher.find(teacher.id)
      expect(response).to have_http_status(422)
      expect(updated_teacher.authenticate(new_password)).to be(false)
    end
  end
end
