require 'rails_helper'

describe 'Posts feature', type: :feaure do
  feature 'creating a post' do
    scenario 'with valid params' do
      visit '/posts/new'
      fill_in 'post_title', with: 'Lorem Ipsum'
      fill_in 'post_body', with: 'Lorem Ipsum text and paragraph'
      click_on 'Create Post'

      expect(page).to have_content('Post created successfully!')
    end
  end

  feature 'not creating a post' do
    scenario 'with invalid title' do
      visit '/posts/new'
      fill_in 'post_title', with: ''
      fill_in 'post_body', with: 'Lorem Ipsum text and paragraph'
      click_on 'Create Post'

      expect(page).to have_content("Title can't be blank")
    end
  end

  feature 'not creating a post' do
    scenario 'with invalid body' do
      visit '/posts/new'
      fill_in 'post_title', with: 'Lorem Ipsum'
      fill_in 'post_body', with: ''
      click_on 'Create Post'

      expect(page).to have_content("Body can't be blank")
    end
  end
end
