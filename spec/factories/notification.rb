FactoryGirl.define do 
	factory :notification do
		content "Vous avez recu un commentaire!"
		association :user, factory: :user
		association  :comment, factory: :comment
	end
end