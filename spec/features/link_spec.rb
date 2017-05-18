require 'rails_helper'

feature 'oauth' do
  context 'user login' do

    before { visit '/link' }

    it 'when the user logs in' do
      expect(page).to have_current_path('/login')
    end

    it 'should have a login button' do
      expect(page).to have_selector(:link_or_button, 'Login')
    end

    it 'authenticates the user' do
      click_on 'Login'
      expect(page).to have_current_path('/')
    end
  end
end
