FactoryGirl.define do
	factory :school do
		sequence(:name) { |n| "School#{n}" }
		ipads 34
	end

  factory :classroom do
    school
		sequence(:name) { |n| "Classroom #{n}" }
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
