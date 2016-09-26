require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {
    User.create(
      :name => "Mindy",
      :password => "password",
      :email => "email@rspec.com"
    )
  }

  it "is not valid without a password" do
    expect(User.new(name: "Name")).not_to be_valid
    expect(User.new(email: "email@rspec.com")).not_to be_valid
    expect(User.new(password: "password")).not_to be_valid
    expect(User.new(name: "Name", email: "email@rspec.com")).not_to be_valid
    expect(User.new(password: "password", email: "email@rspec.com")).to be_valid
    expect(User.new(name: "Name", password: "password", email: "email@rspec.com")).to be_valid
  end

  it "has many questions" do
    user.authored_questions.create
    expect(user.authored_questions.count).to eq(1)
  end

  it "has many comments through questions" do
    answer = Answer.create(content: "A New Answer")
    user.answers << answer
    expect(user.answers.last).to eq(answer)
  end

end
