require 'spec_helper'

describe User do
  ''"  before { @user = FactoryGirl.build(:user) }

    subject { @user }

    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:email) }
    it { should respond_to(:password) }

    it { should be_valid }"''
end
