@show = (value) ->
  $("." + value + "-show").removeClass("hide disabled")

@disable = (value) ->
  $("." + value + "-disable").attr('disabled', true);

@hide = (value) ->
  $("." + value + "-hide").addClass("hide")

@default_format = (string) ->
  string.replace(/\s+/g, '-').toLowerCase()

@default_datepicker = ->
  $('.datepicker').datepicker
    format: "yyyy-mm-dd"
    autoclose: true
    todayHighlight: true
    endDate: new Date()
  $('.cocoon-form').on 'cocoon:after-insert', (e, insertedItem) ->
    $('.datepicker').datepicker
      format: "yyyy-mm-dd"
      autoclose: true
      todayHighlight: true
      endDate: new Date()

@type_ahead_clients = ->
  clientsSource = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace 'value'
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: '/datasets/clients?query=%QUERY'
      wildcard: '%QUERY'
  )
  $('.search_typeahead').typeahead null, 
    limit: 1000,
    name: 'clients',
    display: 'name',
    source: clientsSource
  $('.search_typeahead').bind 'typeahead:selected', (obj, datum, name) ->
    $('.clients-typeahead-id').val datum.id
    $('.clients-typeahead-name').val datum.name
    $('.clients-typeahead-country').val datum.country
    $('.clients-typeahead-address').val datum.address
    $('.clients-typeahead-legal-id').val datum.legal_id
    $('.clients-typeahead-corporate-name').val datum.corporate_name



@picture_input = ->
  $('.pictureInput').on 'change', (event) ->
    files = event.target.files
    image = files[0]
    reader = new FileReader()
    reader.onload = (file) ->
      img = new Image()
      img.src = file.target.result
      $('#target').html(img)
      img.style.height = '180px'
      img.style.width = 'auto'
    reader.readAsDataURL(image)
    $("#endTimeLabel").removeClass()
    
@current_scope = (data, value) ->
  $("#wrapper").data(data).search(value) >= 0

@default_tab = ->
  $('.nav-tabs a:first').tab "show"
  $('.nav-tabs a').click (e) ->
    e.preventDefault()
    $(this).tab 'show'
