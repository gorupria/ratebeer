const BREWERIES = {}

BREWERIES.show = () => {
  $("#brewerytable tr:gt(0)").remove()
  const table = $("#brewerytable")

  BREWERIES.list.forEach((brewery) => {
    table.append('<tr>'
      + '<td>' + brewery['name'] + '</td>' 
      + '<td>' + brewery['year'] + '</td>'
      + '<td>' + brewery['num_beer']['num_of_beer'] + '</td>'
      + '<td>' + brewery['brewery']['active'] + '</td>'
      + '</tr>')
  })
}

BREWERIES.sort_by_name = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  })
}

BREWERIES.sort_by_year = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year.toString().toUpperCase().localeCompare(b.year.toString().toUpperCase());
  })
}

BREWERIES.sort_by_num_beers = () => {
  BREWERIES.list.sort((a, b) => {
    return a.num_beer.num_of_beer.toString().toUpperCase().localeCompare(b.num_beer.num_of_beer.toString().toUpperCase());
  })
}

BREWERIES.sort_by_status = () => {
  BREWERIES.list.sort((a, b) => {
    return a.brewery.active.toUpperCase().localeCompare(b.brewery.active.toUpperCase());
  })
}

document.addEventListener("turbolinks:load", () => {
  $("#name").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_name()
    BREWERIES.show();
  })

  $("#year").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_year()
    BREWERIES.show();
  })

  $("#num_year").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_num_beers()
    BREWERIES.show();
  })

  $("#status").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_status()
    BREWERIES.show();
  })
  
  $.getJSON('breweries.json', (breweries) => {
    BREWERIES.list = breweries
    BREWERIES.show()
  })

})
