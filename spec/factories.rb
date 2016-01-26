FactoryGirl.define do
	factory :school do
		sequence(:name) { |n| "School#{n}" }
		ipads 34
		classrooms ["Room 1", "Room 2", "Room 3"]
	end

	factory :teacher do
		school
		sequence(:name)  { |n| "Teacher #{n}" }
		sequence(:email) { |n| "teacher#{n}@ef.com" }
		password "password"
		password_confirmation "password"


		factory :admin do
			admin true
		end
	end

end
