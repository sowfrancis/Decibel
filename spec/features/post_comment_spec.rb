require 'rails_helper'

RSpec.feature "comment", type: :feature do
	before(:each) do
		@bob = create :user
		@track = create :track
		sign_in @bob
	end
	
	context "post a comment" do
		scenario "i can post a comment" do
			visit "/tracks/"
			fill_in 'comment[content]', with: 'yooo'
			click_on 'poster votre commentaire'
			expect(page).to have_text("yooo")
			expect(@track.comments.count).to eq 1
		end
	end

end