require 'spec_helper'

feature 'displaying Pages' do

	context 'index' do
		before(:each) { Page.create(title: "new page", content: "hello world") }

		it "should display all pages" do
			expect(page).to have_link "new page"
		end
	end
end