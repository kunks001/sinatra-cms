require 'spec_helper'

feature 'Pages' do
	before(:all) { Page.create(title: "new page", content: "hello world") }

	context 'index' do

		it 'should display all pages' do
			visit '/pages'
			expect(page).to have_link 'new page'
		end
	end

	context 'show' do
		it 'should display a page' do
			visit '/pages'
			click_link 'new page'
			expect(page).to have_content 'new page'
			expect(page).to have_content 'hello world'
		end
	end
end