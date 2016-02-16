require 'rails_helper'

RSpec.feature "comment", type: :feature do
	before(:each) do
		@bob = create :user
		@track = create :track
		@notification = create :notification
		sign_in @bob
		visit "/tracks/"
	end
	
	context "when i want to post a comment" do
		scenario "i can post a comment" do
			fill_in 'comment_content', with: 'yooo'
			click_on 'poster votre commentaire'
			expect(page).to have_text("yooo")
		end
	end


end