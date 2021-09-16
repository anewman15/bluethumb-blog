require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    subject { FactoryBot.build :post }

    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
  end
end
