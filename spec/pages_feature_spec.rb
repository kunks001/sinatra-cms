require 'spec_helper'

feature 'Pages' do
  before(:all) { Page.create(title: 'test page', content: 'hello world') }

  context 'index' do
    before { visit '/pages' }

    it 'should display all pages' do
      expect(page).to have_title 'Simple Sinatra CMS'
      expect(page).to have_link 'test page'
    end

    it "should contain a link to the 'new' page" do
      expect(page).to have_link 'add page'
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
      expect(page).to have_field('page[title]')
      expect(page).to have_field('page[content]')
    end

    describe 'creating a page' do
      before(:all) do
        visit '/pages/new'
        fill_in 'page[title]', with: 'new page'
        fill_in 'page[content]', with: 'foobar'
        click_button 'Create'
      end

      it 'should redirect the user to the new page' do
        expect(page).to have_title 'new page'
        expect(page).to have_content 'foobar'
      end

      it 'should list the page on the pages index' do
        visit '/pages'
        expect(page).to have_link 'new page'
      end

      it 'should be accessible from the pages index' do
        visit '/pages'
        click_link 'new page'
        expect(current_path).to match /\/pages\/[a-zA-Z\d]{24}/
      end
    end
  end
end