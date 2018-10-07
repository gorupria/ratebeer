require 'rails_helper' 
include Helpers

describe "Beer" do 
  BeerClub
  BeerClubsController
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:style) { FactoryBot.create :style, name: "Lager" }
  let!(:beer) { FactoryBot.create :beer, name: "iso 3", style: style, brewery: brewery }
  let!(:user){ FactoryBot.create(:user) }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end
  
  before { Beer.destroy_all } 

  it "is saved if name is not empty" do 
    visit new_beer_path
    fill_in("beer[name]", with: beer.name)
    
    expect{ 
      click_button("Create Beer")
    }.to change{Beer.count}.from(0).to(1)

    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Beers"
    expect(page).to have_content "Beer was successfully created."
  end
  
  it "is not saved if name is empty" do
    visit new_beer_path
    fill_in("beer[name]", with: '')
    click_button("Create Beer")

    expect(Beer.count).to eq 0 
    expect(page).to have_content "New Beer"
    expect(page).to have_content "Name can't be blank"
  end
end
