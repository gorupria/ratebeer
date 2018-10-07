require 'rails_helper'

RSpec.describe User, type: :model do

  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do 
    user = User.create username: "Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with proper password" do
    let(:user){ FactoryBot.create(:user) }

    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average" do 
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "with improper password" do 
    let(:user) { User.create username: "Pekka", password:"ab", password_confirmation:"ab" }

    it "is not saved" do 
      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite_beer" do
      expect(user).to respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do 
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do 
      create_beer_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining favorite style" do 
      expect(user).to respond_to :favorite_style
    end

    it "is the one with highest rating" do 
      brewery = FactoryBot.create(:brewery)
      beer = FactoryBot.create(:beer)
      style1 = FactoryBot.create(:style)
      style2 = FactoryBot.create(:style, name: "Ipa")
      beer1 = FactoryBot.create(:beer, name: "beer1", style: style1, brewery: brewery)
      beer2 = FactoryBot.create(:beer, name: "beer1", style: style2, brewery: brewery)
      beer3 = FactoryBot.create(:beer, name: "beer1", style: style2, brewery: brewery)
      beer4 = FactoryBot.create(:beer, name: "beer1", style: style2, brewery: brewery)
      FactoryBot.create(:rating, score: 23, beer: beer, user: user)
      FactoryBot.create(:rating, score: 12, beer: beer1, user: user)
      FactoryBot.create(:rating, score: 45, beer: beer2, user: user)
      FactoryBot.create(:rating, score: 43, beer: beer3, user: user)
      FactoryBot.create(:rating, score: 32, beer: beer4, user: user)
     
      expect(user.favorite_style).to eq("Ipa")
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining favorite brewery" do
      expect(user).to respond_to :favorite_brewery
    end

    it "is the one that produces highest rated beers" do
      brewery = FactoryBot.create(:brewery)
      brewery1 = FactoryBot.create(:brewery, name: "Koff", year: 1990) 
      brewery2 = FactoryBot.create(:brewery, name: "Koff", year: 1990) 
      style1 = FactoryBot.create(:style)
      style2 = FactoryBot.create(:style, name: "Ipa")
      beer = FactoryBot.create(:beer)
      beer1 = FactoryBot.create(:beer, name: "beer1", style: style1, brewery: brewery1)
      beer2 = FactoryBot.create(:beer, name: "beer1", style: style2, brewery: brewery1)
      beer3 = FactoryBot.create(:beer, name: "beer1", style: style2, brewery: brewery1)
      beer4 = FactoryBot.create(:beer, name: "beer1", style: style2, brewery: brewery2)
      FactoryBot.create(:rating, score: 50, beer: beer, user: user)
      FactoryBot.create(:rating, score: 12, beer: beer1, user: user)
      FactoryBot.create(:rating, score: 10, beer: beer2, user: user)
      FactoryBot.create(:rating, score: 13, beer: beer3, user: user)
      FactoryBot.create(:rating, score: 32, beer: beer4, user: user)
      
      expect(user.favorite_brewery).to eq("anonymous")
      
    end
  end
end

def create_beer_with_rating(score, user)
  beer = FactoryBot.create(:beer)
  FactoryBot.create(:rating, score: score, beer: beer, user: user)
  beer
end

def create_beer_with_ratings(*score, user)
  score.each do |score|
    create_beer_with_rating(score, user)
  end
end
