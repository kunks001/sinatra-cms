require 'spec_helper'

feature 'Pages' do
  before(:all) { @test_page = Page.create(title: 'test page', content: 'hello world') }

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

    before(:each) do 
      visit '/pages'
      click_link 'test page'
    end

    it 'should display a page' do

      expect(page).to have_title 'test page'
      expect(page).to have_content 'test page'
      expect(page).to have_content 'hello world'
    end

    it 'should contain a link to the edit page' do
      expect(page).to have_link 'Edit this page'
    end

    it 'should contain a link to the delete function' do
      expect(page).to have_button 'Delete this page'
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
        expect(page.current_path).to eq '/new-page'
      end
    end
  end

  context 'edit' do
    before(:each) { visit "/pages/#{@test_page.id}/edit" }

    it 'should allow users to edit a page' do
      expect(page).to have_selector("h1", :text => 'Edit this Page')
      expect(page).to have_field('page[title]')
      expect(page).to have_field('page[content]')
    end

    it 'should redirect the user to the edited page' do
      fill_in 'page[title]', with: 'edited page'
      fill_in 'page[content]', with: 'edited content'
      click_button 'Update'
      expect(page.current_path).to eq '/test-page'
      expect(page).to have_content 'edited page'
      expect(page).to have_content 'edited content'
    end
  end
  context 'delete' do
    it 'should allow the user to delete a page' do
      visit '/test-page'
      click_button 'Delete this page'
      expect(page.current_path).to eq '/pages'
      expect(page).to_not have_content 'test page'
    end
  end

  context 'urls' do
    let!(:page1) { Page.create(title: 'Page One', content: 'hello world')  }
    let!(:page2) { Page.create(title: 'Page Two', content: 'foobar')  }
   
    it 'should display the page title' do
      visit '/page-one'
      expect(page).to have_content 'hello world'
      visit '/page-two'
      expect(page).to have_content 'foobar'
    end
  end
end