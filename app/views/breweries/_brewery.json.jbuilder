json.extract! brewery, :id, :name, :year
json.num_beer do
  json.num_of_beer brewery.beers.count
end
json.brewery do 
  if brewery.active
    json.active 'Yes'
  else
    json.active 'No'
  end
end
