require 'spec_helper'
describe "User pages" do

subject { page }

describe "profile page" do
let(:user) { FactoryGirl.create(:user) }
let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }
before { visit user_path(user) }
it { should have_selector('h1', text: user.name) }
it { should have_selector('title', text: user.name) }
describe "microposts" do
it { should have_content(m1.content) }
it { should have_content(m2.content) }
it { should have_content(user.microposts.count) }
end
end
end
describe User do
before do
@user = User.new(name: "Example User", email: "user@example.com",
password: "foobar", password_confirmation: "foobar")
end
subject { @user }



it { should respond_to(:authenticate) }
it { should respond_to(:microposts) }

describe "micropost associations" do
before { @user.save }
let!(:older_micropost) do
FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
end
let!(:newer_micropost) do
FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
end
it "should have the right microposts in the right order" do
@user.microposts.should == [newer_micropost, older_micropost]
end
it "should destroy associated microposts" do
microposts = @user.microposts.dup
@user.destroy
microposts.should_not be_empty
microposts.each do |micropost|
Micropost.find_by_id(micropost.id).should be_nil
end
end
end

end
