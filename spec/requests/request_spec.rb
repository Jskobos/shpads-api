require 'rails_helper'

describe "API Requests" do
  def json
    JSON.parse(response.body)
  end

  def login_request(email, password)
    token = Base64.encode64("#{email}:#{password}")
    header = "Basic #{token}"
    params = {}
    headers = { Authorization: header }
    get '/login', params, headers
  end

  def data_request(url)
    header = { Authorization: "Token token=#{teacher.auth_token}" }
    params = {}
    get url, params, header
  end

  let(:teacher)  { FactoryGirl.create(:teacher) }
  let(:teachers) { FactoryGirl.create_list(:teacher, 10) }

  describe "before authentication" do
    it "should return a bad token error" do
      get '/teachers'

      expect(response).to have_http_status(401)

      expect(json['error']).to eq("Bad Token")
    end
  end

  describe "when submitting correct authentication" do
    it "should return a valid auth token" do
      login_request(teacher.email, teacher.password)

      expect(response).to be_success
      expect(json["token"]).to eq(teacher.auth_token)
    end
  end

  describe "when submitting incorrect authentication" do
    it "should return a 401 and error message" do
      login_request(teacher.email,"wrong_password")

      expect(response).to have_http_status(401)
      expect(json["error"]).to include("password")

      login_request("bad_email@bad.org",teacher.password)

      expect(response).to have_http_status(401)
      expect(json["error"]).to include("Email")
    end
  end

describe "when making an authenticated get request" do
  it "should return the correct data" do
    data_request("/schools")

    expect(response).to have_http_status(200)
    expect(json['schools'][0]).to include("name")

    data_request("/teachers/#{teacher.id}")

    expect(response).to have_http_status(200)
    expect(json['teacher']).to include("name")
  end

  it "should not return unserialized data" do
    data_request("/teachers/#{teacher.id}")

    expect(json['teacher']).not_to include("password_digest")
    expect(json['teacher']).not_to include("auth_token")
  end
end

end
