require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.first
  end

  it "is not valid without a password" do
    expect(User.new(name: "Name")).not_to be_valid
  end

  it "has many questions" do
    @user.questions.create
    expect(@user.questions.count).to eq(1)
  end

  it "has many comments through questions" do
    comment = Comment.create(content: "A New Comment")
    @user.comments << comment
    expect(@user.comments.first).to eq(comment)
  end

end
