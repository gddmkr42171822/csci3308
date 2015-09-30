require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('sign up') }
    it { should have_selector('title', :text => "sign up") }
  end

  describe "work page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:project, user: user, title: "Foo", description: "ehllo", location: "here") }
    let!(:m2) { FactoryGirl.create(:project, user: user, title: "Bar", description: "hello", location: "here") }

    before { visit work_path }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "projects" do
      it { should have_content(m1.description) }
      it { should have_content(m2.title) }
      it { should have_content(user.projects.count) }
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

	it { should have_content(user.name) }
	it { should have_selector('title', :text => user.name) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', :text => 'sign up') }
        it { should have_content('error') }
      end

    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email("user@example.com") }

        it { should have_selector('title', :text => user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email("user@example.com") }

        it { should have_link('sign out') }
        it { should have_selector('title', :text => user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("update your settings") }
      it { should have_selector('title', :text => "update your settings") }
    end

    describe "with invalid information" do
      before { click_button "save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "confirm Password", with: user.password
        click_button "save changes"
      end

      it { should have_selector('title', :text => new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', :text => 'All users') }
    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete')
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end
end