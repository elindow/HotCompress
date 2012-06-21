require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should_not allow_value("foo").for(:email) }
  it { should_not allow_value("@example.com").for(:email) }
  it { should allow_value("foo@example.com").for(:email) }
  context "with an existing user" do
    before :each do
      @user = Fabricate(:user)
    end
    it { should validate_uniqueness_of(:email) }
    it "should have an encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    it "should encrypt passwords" do
      @user.password.should_not == @user.encrypted_password
    end
    describe "valid_password? method" do
      it "should be true if the passwords match" do
        @user.valid_password?("password").should be_true
      end
      it "should be false if the passwords don't match" do
        @user.valid_password?("invalid").should be_false
      end 
    end
  end
  context "password" do
    it { should validate_presence_of(:password) }
    it "should require a matching password confirmation" do
      User.new({name: "dummy", email: "dummy@example.com", password: "", password_confirmation: "invalid"}).should_not be_valid
    end
    it "should reject short passwords" do
      pwd = "a" * 5
      User.new({name: "dummy", email: "dummy@example.com", password: pwd, password_confirmation: pwd}).should_not be_valid
    end
    it "should reject very long passwords" do
      pwd = "a" * 41
      User.new({name: "dummy", email: "dummy@example.com", password: pwd, password_confirmation: pwd}).should_not be_valid
    end
  end
end
