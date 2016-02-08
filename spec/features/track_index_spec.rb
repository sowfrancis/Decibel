require 'rails_helper'

RSpec.feature "track", type: :feature do
  before(:each) do 
    @bob = create(:user)
    @track = create(:track)
    sign_in @bob
    visit("/tracks/")
  end
  
  context 'when i upload my track' do
    scenario 'i can see my track avatar' do
      expect(page).to have_css ".img-responsive"
    end

    scenario 'i can listen my track' do
      expect(Track.count).to eq 1
    end

    scenario 'i can see the comment field' do
      expect(page).to have_css('#comment')
    end
  end
end