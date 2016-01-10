$ ->

  $baseUrl = '/open-source-club-website'
  $u = window.location.host.indexOf('github.io')
  if $u == -1
    $baseUrl = ''

  SimpleJekyllSearch
    searchInput: document.getElementById('search-posts')
    resultsContainer: document.getElementById('search-results')
    json: $baseUrl + '/search.json'
    searchResultTemplate: '<a href="{url}"><li><div class="primary">{title}</div><div class="secondary">{date}</div></li></a>'
    noResultsText: '<li class="no-results">No results found</li>'
    limit: 10
    fuzzy: false
    templateMiddleware:
      () ->
        # TODO
        # this is super inefficent because it gets executed on EVERY match
        result = document.querySelector('#search-results>a')
        if result?
          if result.classList.length
            result.classList.add 'selected'
          else
            result.className += ' ' + 'selected'


  if $('#search-posts').val().length > 0
    isSelected = true
  else
    isSelected = false

  $('#search-results').hover (->
    isSelected = true
    if isSelected == true
      console.log 'results selected: ' + isSelected
    return
  ), ->
    isSelected = false
    if isSelected == false
      console.log 'results selected: ' + isSelected
    return

  $('#search-posts').focusout ->
    if !isSelected and $('#search-posts').val().length > 0
      $('#search-results').css('display', 'none')
    else
      $('#search-results').css('display', '')
    return

  $('#search-posts').focusin ->
    if $('#search-results').css('display') == 'none'
      $('#search-results').css('display', '')
    return

  return










