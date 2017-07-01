command: "sh ./nerdbar.widget/scripts/status.sh"

refreshFrequency: 10000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./colors.css" />
    <div class="compstatus"></div>
  """

style: """
  right: 55px
  top: 2px
  height: 13
  .charging
    font: 12px FontAwesome
    position: relative
    top: 0px
    right: -11px
    z-index: 1
  """

batteryStatus: (battery, state) ->
  #returns a formatted html string current battery percentage, a representative icon and adds a lighting bolt if the
  # battery is plugged in and charging
  batnum = parseInt(battery)
  if state == 'AC' and batnum >= 90
    return "<span class='charging white sicon'></span><span class='green icon '></span><span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum >= 50 and batnum < 90
    return "<span class='charging white icon'></span><span class='green icon'></span><span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum < 50 and batnum >= 15
    return "<span class='charging white icon'></span><span class='yellow icon'></span><span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum < 15
    return "<span class='charging white icon'></span><span class='red icon'></span><span class='white'>#{batnum}%</span>"
  else if batnum >= 90
    return "<span class='green icon'>&nbsp</span><span class='white'>#{batnum}%</span>"
  else if batnum >= 50 and batnum < 90
    return "<span class='green icon'>&nbsp</span><span class='white'>#{batnum}%</span>"
  else if batnum < 50 and batnum >= 25
    return "<span class='yellow icon'>&nbsp</span><span class='white'>#{batnum}%</span>"
  else if batnum < 25 and batnum >= 15
    return "<span class='yellow icon'>&nbsp</span><span class='white'>#{batnum}%</span>"
  else if batnum < 15
    return "<span class='red icon'>&nbsp</span><span class='white'>#{batnum}%</span>"

update: (output, domEl) ->

  # split the output of the script
  values = output.split('@')

  battery = values[0]
  isCharging = values[1]

  # create an HTML string to be displayed by the widget
  htmlString = @batteryStatus(battery, isCharging)

  $(domEl).find('.compstatus').html(htmlString)
