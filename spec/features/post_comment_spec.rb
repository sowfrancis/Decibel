require 'rails_helper'

RSpec.feature "comment", type: :feature do
	before(:each) do
		@bob = create :user
		@track = create :track
		@notification = create :notification
		sign_in @bob
		visit "/tracks/"
	end
	
	context "comment" do
		scenario "i can post a comment" do
			binding.pry
			fill_in 'comment_content', with: 'yooo'
			click_on 'poster votre commentaire'

			expect(page).to have_text("yooo")
			expect(@track.comments.count).to eq 1
			expect(@bob.notifications.count).to eq 1
		end
	end


end