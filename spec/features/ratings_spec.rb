require 'rails_helper'
include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:style1) { FactoryBot.create :style, name: "Lager" }
  let!(:style2) { FactoryBot.create :style, name: "IPA" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", style: style1, brewery: brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", style: style2, brewery: brewery }
  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create :user, username: "Mike" }
  
  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]') 
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq 1
    expect(beer1.ratings.count).to eq 1
    expect(beer1.average_rating).to eq(15.0)
  end

  it "is shown with the value" do 
    FactoryBot.create :rating, score: 15, beer: beer1, user: user 
    visit ratings_path
    
    expect(page).to have_content "List of ratings."
    expect(page).to have_content "iso 3, 15" 
  end

  it "is show in user's page" do
    FactoryBot.create :rating, score: 15, beer: beer1, user: user 
    FactoryBot.create :rating, score: 34, beer: beer2, user: user2 
    FactoryBot.create :rating, score: 10, beer: beer2, user: user 
    FactoryBot.create :rating, score: 43, beer: beer1, user: user2 
    
    visit user_path(user)
    
    expect(user.username).to eq "Pekka"
    expect(user.ratings.count).to eq 2
    expect(page).to have_content "Ratings"
    expect(page).to have_content "iso 3, 15"
    expect(page).to have_content "Karhu, 10"
    expect(page).to_not have_content "iso 3, 24"
    expect(page).to_not have_content "Karhu, 43"
  end

  it "is removed from db when delete button is pressed" do 
    FactoryBot.create :rating, score: 15, beer: beer1, user: user
    FactoryBot.create :rating, score: 32, beer: beer2, user: user

    visit user_path(user)

    expect{
      page.first(:link, "delete").click
    }.to change{Rating.count}.from(2).to(1)
  end

  it "does not have favorite beer/brewery yet" do 
    visit user_path(user)

    expect(page).to have_content "#{user.username} does not have a favorite style yet."
    expect(page).to have_content "#{user.username} does not have a favorite brewery yet." 
  end

  it "have favorite beer/brewery if has rating" do
    brewery2 = FactoryBot.create(:brewery, name: "Carlsberg") 
    style1 = FactoryBot.create(:style, name: "IPA")
    beer2 = FactoryBot.create(:beer, name: "Karhu", style: style1, brewery: brewery2)
    FactoryBot.create :rating, score: 15, beer: beer1, user: user
    FactoryBot.create :rating, score: 25, beer: beer1, user: user
    FactoryBot.create :rating, score: 35, beer: beer2, user: user

    visit user_path(user)

    expect(page).to have_content "#{user.username}'s favorite style of beer is IPA."
    expect(page).to have_content "#{user.username}'s favorite brewery is Carlsberg."
  end
end
