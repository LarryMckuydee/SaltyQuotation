require 'rails_helper'

feature 'Homepage views.' do
  scenario 'have home link' do
    visit "/"
    assert_text "Home"
  end
end
