require 'spec_helper'

feature 'Pages' do
  before(:all) { Page.create(title: 'test page', content: 'hello world') }

  context 'index' do
    it 'should display all pages' do
      visit '/pages'
      expect(page).to have_title 'Simple Sinatra CMS'
      expect(page).to have_link 'test page'
      end
    end

  context 'show' do
    it 'should display a page' do
      visit '/pages'
      click_link 'test page'
      expect(page).to have_title 'test page'
      expect(page).to have_content 'test page'
      expect(page).to have_content 'hello world'
    end
  end

  context 'new' do
    it 'should contain a form for a new page' do
      visit '/pages/new'
      expect(page).to have_title 'add page'
      expect(page).to have_field("page[title]")
      expect(page).to have_field("page[content]")
    end
  end
end