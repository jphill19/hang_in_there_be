require 'rails_helper'

RSpec.describe Poster, type: :model do
  describe 'validations' do 
    it {should validate_presence_of(:name)}
    it {should validate_uniqueness_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:year)}
    it {should validate_numericality_of(:year).only_integer}
    it {should validate_presence_of(:price)}
    it {should validate_numericality_of(:price)}
    # it {should validate_presence_of(:vintage) } Current issue with validating booleans
  end
end