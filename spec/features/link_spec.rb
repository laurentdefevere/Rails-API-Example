require 'rails_helper'

feature 'oauth' do
  context 'user login' do

    before { visit '/link' }

    it 'when the user logs in' do
      expect(page).to have_current_path('/link')
    end

    it 'should have a link button' do
      expect(page).to have_selector(:link_or_button, 'Link TrainingPeaks')
    end

    it 'authenticates the user' do
      click_on 'Link TrainingPeaks'
      expect(page).to have_current_path('/')
    end
  end
end
