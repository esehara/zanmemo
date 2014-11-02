# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

debug_mode = false
p = (st) ->
  if debug_mode
    console.log(st)

storagekey = "zanmemo-draft"
save_target = () -> $("#memo_content")
preview_target = () -> $("#memo_content")

draft = () ->
  localStorage.getItem(storagekey)

post_now = false
savedraft = (st) ->
  if save_target().val()? && !post_now
    localStorage.setItem(storagekey, st)

cleardraft = () ->
  if save_target().val()?
    localStorage.setItem(storagekey, "")

previous_render_text = null

render_markdown = () ->
  if preview_target().val()?
    raw_text = preview_target().val()

    if !previous_render_text
      previous_render_text = raw_text
      return reflesh_markdown_preview(raw_text) 
  
    if previous_render_text != raw_text
     reflesh_markdown_preview(raw_text)
    
reflesh_markdown_preview = (raw_text) ->
  markdown_text = marked(raw_text)
  $('#memo-preview').html(markdown_text)
  reflesh_preview_height()

reflesh_preview_height = () ->
  preview_height = $('#memo-preview').height()
  if preview_height > preview_target().height()
    preview_target().height(preview_height)
    
$ ->
  p("Start :: LocalStrage Load")

  save_target().val(draft())
  
  save_interval = setInterval ->
    savedraft(save_target().val())
    p("Tick, Tick ... Save !!")
  , 500

  render_interval = setInterval ->
    render_markdown()
    p("Markdown render ... boom boom !!")
  , 500

  $("#submit-memo").on "click", ->
    post_now = true
    clearInterval(save_interval)
    cleardraft()
