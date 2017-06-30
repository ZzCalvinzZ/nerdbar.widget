command: "/usr/local/bin/kwmc query window focused name"

refreshFrequency: 2000 # ms

render: (output) ->
  """
<link rel="stylesheet" type="text/css" href="./colors.css" />
    <div class='date'></div>
  """

style: """
  left: 25%
  top: 2px
  width: 50%
  text-align: center
  """

update: (output, domEl) ->
  days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
  months = ['January','February','March','April','May','June','July','August','September','October','November','December']

  now = new Date()

  day = days[now.getDay()]
  month = months[now.getMonth()]
  time = now.toLocaleTimeString().replace(/([\d]+:[\d]{2})(:[\d]{2})(.*)/, "$1$3")

  date = "#{day}, #{month} #{now.getDate()} - #{time}"

  icon = "<span class='icon'></span> "
  dateEl = "<span>#{date}</span>"

  $(domEl).find('.date').html(icon + dateEl)
