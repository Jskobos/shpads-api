require 'rails_helper'

describe "Adding and Editing Schools" do
  let(:admin)      { FactoryGirl.create(:admin) }
  let(:school)     { FactoryGirl.create(:school) }

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

  def put_request(url, params={})
    header = { Authorization: "Token token=#{admin.auth_token}" }
    put url, params, header
  end

  describe "when adding a classroom" do
    it "should include all classrooms" do
      new_rooms = school.classrooms
      new_rooms << "NEW!!!"
      params = { school: { classrooms: new_rooms } }
      put_request "/schools/#{school.id}", params
      expect(response).to have_http_status(204)
      expect(school.classrooms).to include("NEW!!!")
      expect(school.classrooms).to include("Room 1")
    end
  end

  describe "when removing a classroom" do
    it "should delete the correct room if the user is an admin" do
      rooms = school.classrooms
      old_room = rooms.pop()
      params = { school: { classrooms: rooms } }
      put_request "/schools/#{school.id}", params
      expect(response).to have_http_status(204)
      expect(school.classrooms).not_to include(old_room)
    end
  end


end