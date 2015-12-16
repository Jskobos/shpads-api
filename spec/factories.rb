FactoryGirl.define do
	factory :school do
		sequence(:name) { |n| "Person #{n}" }
		ipads 34

		factory :admin do
			admin true
		end
	end

  factory :classroom do
    school
		sequence(:name) { |n| "Classroom #{n}" }
  end

end
