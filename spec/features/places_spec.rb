require 'rails_helper'

describe "Places" do
  it "if one is returned by API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    
    expect(page).to have_content "Oljenkorsi"
  end

  it "if several is returned by API, all are shown at the page" do 
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new(name: "Oljenkorsi", id:1), Place.new(name: "Oslo", id: 2) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Oslo"
  end

  it "if no restaurant is found, msg is shown" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end
