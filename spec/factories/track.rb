include ActionDispatch::TestProcess
FactoryGirl.define do 
	factory :track do
		avatar {Faker::Avatar.image}
		audio_file_name "sound"
		association :user, factory: :user
	end
end