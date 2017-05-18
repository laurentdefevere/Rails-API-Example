require 'rails_helper'

feature 'oauth' do
  context 'user login' do

    before { visit '/login' }

    it 'when the user logs in' do

      expect(page).to have_current_path('/login')
    end

    it 'should have a login button' do
      expect(page).to have_selector(:link_or_button, 'Login')
    end
  end
end
