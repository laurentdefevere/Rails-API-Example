require 'rails_helper'

feature 'oauth' do
  context 'user login' do

    before { visit '/login' }

    it 'when the user logs in' do

      expect(page).to have_current_path('/login')
    end

    it 'when a user clicks login' do

    end
  end
end
