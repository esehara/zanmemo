# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

p = (st) ->
  console.log(st)

storagekey = "zanmemo-draft"

draft = () ->
  localStorage.getItem(storagekey)

savedraft = (st) ->
  localStorage.setItem(storagekey, st)

cleardraft = () ->
  localStorage.setItem(storagekey, "")
  
$ ->
  debug_mode = true
  p("Start :: LocalStrage Load")
  $("#memo_content").val(draft())

  save_interval = setInterval ->
    savedraft($("#memo_content").val())
    p("Tick, Tick ... Save !!")
  , 500

  $("#submit-memo").on "click", ->
    clearInterval(save_interval)
    cleardraft()
