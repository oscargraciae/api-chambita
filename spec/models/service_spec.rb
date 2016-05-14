require 'spec_helper'

describe Service do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:description) }

  it { should be_valid }
end