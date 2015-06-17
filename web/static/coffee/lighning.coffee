# out: ../js/lighning.js
# out comment above for coffee compiler

$ = require('web/static/js/jquery-1.11.3.min')

createInput = (attr) ->
  attr = {} unless attr
  input = $(document.createElement('input'))
  attr.type = 'text'
  input.attr(attr) if attr
  input

newLi = (attr) ->
  e = $(document.createElement('li'))
  e.attr(attr) if attr
  input = createInput()
  e.append(input)
  e

changeToSpan = (input) ->
  span = $(document.createElement('span'))
  val = input.val()
  span.addClass('task').append(val)
  for w in val.split(' ')
    addVariable(w) if w[0] == ':'

  input.closest('li').html(span)

changeToInput = (span) ->
  input = createInput({value: span.text()})
  span.closest('li').html(input)

addVariable = (variable) ->
  list = $('.variables-list')
  li = $(document.createElement('li'))
  input = $(document.createElement('input'))
  input.attr({type: 'text', 'data-name': variable.substr(1)})
  li.text("#{variable} => ").append(input)
  list.append(li)

$(document).ready(() ->
  $('.add-more').on('click',() ->
    $(@).before(newLi())
  )

  $('.script-list').on('focusout','input',() ->
    return unless $(@).val()
    changeToSpan($(@))
  )

  $('.script-list').on('click','span.task',() ->
    changeToInput($(@))
  )

  $('.script-list').on('click','.screenshot-icon',() ->
    img = $(document.createElement('img'))
    img.attr({src: $(@).data('screenshot')})
    $('.screenshot_container').html(img)
  )

  $('#run-scraper').on('click',() ->

    tasks = (t.innerText for t in $('.script-list li') when t.innerText)

    variables = {}
    for v in $('.variables-list li input')
      e = $(v)
      variables[e.data('name')] = e.val() if e.val()

    data =
      data: variables
      script: tasks

    $.post('/api/scripts',data,(response) ->
      for t,i in $('.script-list span.task')
        screenshot_url = response['debug'][i]['screenshot_url']
        icon = $(document.createElement('span'))
        icon.addClass('screenshot-icon').attr('data-screenshot',screenshot_url)
        $(t).before(icon)
    )
  )
)
