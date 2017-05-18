require 'rails_helper'

feature 'oauth' do
  context 'user login' do
    it 'when the user logs in' do
      visit '/login'

      expect(page).to have_current_path('/login')
    end
  end
end
