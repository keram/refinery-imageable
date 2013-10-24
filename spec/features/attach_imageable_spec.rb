require 'spec_helper'

describe 'attach object images' do
  refinery_login_with :refinery_user

  before(:each) do
    FactoryGirl.create(:page)

    visit refinery.admin_pages_path

    click_link 'Edit this page'
  end

  it 'shows images tab' do
    within '#page_parts .ui-tabs-nav' do
      page.should have_content('Images')
    end
  end

  # This spec actually is broken in a way because Add Image link would
  # be visible to capybara even if we don't click on Images tab.
  # TODO: open dialog
  it 'shows add image link' do
    within '#page_parts .ui-tabs-nav' do
      click_link 'Images'
    end

    within '#imageable' do
      page.should have_button('Add Image')
    end
  end
end
