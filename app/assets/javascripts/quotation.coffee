# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# alert 'hello'
roundup = (float,exp) ->
  multiplier = Math.pow(10,exp)
  (Math.ceil(float * multiplier)/multiplier).toFixed(exp)

ready = ->
  relabeljsonobj = 0
  $.ajax
    url: "/relabel.json"
    dataType:"json"
    success: (response) ->
      relabeljsonobj = response

  $('#quotation_relabel_quantity').keyup ->
    $('#quotation_relabel_charge').val(0)
    relabeljsonobj.relabels.forEach (relabel) ->
      # alert relabel.relabel_charge
      if $('#quotation_relabel_quantity').val()>=relabel.start_quantity&&$('#quotation_relabel_quantity').val()<=relabel.end_quantity
        if relabeljsonobj.currency=='SGD'
          $('#quotation_relabel_charge').val(roundup($('#quotation_relabel_quantity').val()*relabel.relabel_charge_sg,2))
        else
          $('#quotation_relabel_charge').val(roundup($('#quotation_relabel_quantity').val()*relabel.relabel_charge,2))

  $('#quotation_woven_tag_quantity').keyup ->
    $('#quotation_woven_tag_charge').val(0)
    relabeljsonobj.woven_tags.forEach (woven_tag) ->
      if $('#quotation_woven_tag_quantity').val()>=woven_tag.start_quantity&&$('#quotation_woven_tag_quantity').val()<=woven_tag.end_quantity
        if relabeljsonobj.currency=='SGD'
          $('#quotation_woven_tag_charge').val(roundup($('#quotation_woven_tag_quantity').val()*woven_tag.woven_tag_charge_sg,2))
        else
          $('#quotation_woven_tag_charge').val(roundup($('#quotation_woven_tag_quantity').val()*woven_tag.woven_tag_charge,2))

  $('#relabelling').hide()
  $('#sew_tag').hide()


  $('.selectable-row').on('click','td:not(.not-show)',->
    window.location=$(this).parent().data('href')
    )


  # $('.ajax_link').bind('ajax:error',(evt,data,status,xhr) ->
  #     $('div#errors').append data
  #   ).bind('ajax:success',(evt,data,status,xhr) ->
  #     # $(this).parent().closest
  #     alert "Updated"
  #     alert $(this).data('id')
  #     console.log("")
  #     location.reload()
  #   )
  # c=0;
  # $("#AdditionalInfo").click ->
  #   textArea = $("<textarea id ='AddDesc"+c+"'rows='5' cols='20'></textarea>")
  #   textField = $("<input type='text' id='AddPrice"+c+"' value = '' >")
  #   $("#new_quotation").append textArea
  #   $("#new_quotation").append textField
  FitPrice = 0;
  $("#quotation_back_print_method_id").change ->
    $("#quotation_back_block_size_id").empty()
    $("#quotation_back_block_size_id").append $('<option>',{
        text: "Select A Block Size"
      })
    print_method_name = $("#quotation_back_print_method_id option:selected").text()
    $.ajax
      url: "/print_methods.json"
      dataType: "json"
      success: (response) ->
        response.forEach (p) ->
          $test_html = $("<div></div>")
          # alert brand.brand
          # alert print_method_name
          if print_method_name.toString() == p.print_method_name.toString()
            p.block_sizes.forEach (b) ->
              $("#quotation_back_block_size_id").append $('<option>',{
                value: b.block_size_id,
                text: b.block_size_name
              })

  $("#quotation_front_print_method_id").change ->
    $("#quotation_front_block_size_id").empty()
    $("#quotation_front_block_size_id").append $('<option>',{
        text: "Select A Block Size"
      })
    print_method_name = $("#quotation_front_print_method_id option:selected").text()
    $.ajax
      url: "/print_methods.json"
      dataType: "json"
      success: (response) ->
        response.forEach (p) ->
          $test_html = $("<div></div>")
          # alert brand.brand
          # alert print_method_name
          if print_method_name.toString() == p.print_method_name.toString()
            p.block_sizes.forEach (b) ->
              $("#quotation_front_block_size_id").append $('<option>',{
                value: b.block_size_id,
                text: b.block_size_name
              })

  # $('#quotation_customers_full_name').autocomplete
  #   source: $('#quotation_customers_full_name').data('clsource')

  $('#calculate').click ->
    $.ajax
      url: "/show_price"
      dataType: "json"
      data: {
        shirt_type_id:  $('#quotation_shirt_type_id').val()
        fit_id: $('#quotation_fit_id').val()
        front_print_method_id: $('#quotation_front_print_method_id').val()
        front_block_size_id: $('#quotation_front_block_size_id').val()
        front_block_no: $('#quotation_front_block_no').val()
        back_print_method_id: $('#quotation_back_print_method_id').val()
        back_block_size_id: $('#quotation_back_block_size_id').val()
        back_block_no: $('#quotation_back_block_no').val()
        left_print_method_id: $('#quotation_left_print_method_id').val()
        left_block_no: $('#quotation_left_block_no').val()
        right_print_method_id: $('#quotation_right_print_method_id').val()
        right_block_no: $('#quotation_right_block_no').val()
        quantity: $('#quotation_quantity').val()
        special_print: $('#quotation_special_print').val()
      }
      success: (response) ->
        if response.currency=='SGD'
          $("#quotation_price").val(response.price_sg)
          $("#quotation_cost").val(response.cost_sg)
          $("#quotation_min_rrp").val(response.min_rrp_sg)
          $("#quotation_max_rrp").val(response.max_rrp_sg)
        else
          $("#quotation_price").val(response.price)
          $("#quotation_cost").val(response.cost)
          $('#quotation_min_rrp').val(response.min_rrp)
          $('#quotation_max_rrp').val(response.max_rrp)

  # $('#quotation_fit_id').change ->
  #   $.ajax
  #     url: "/shirt_types/"+$('#quotation_shirt_type_id').val()
  #     dataType: "json"
  #     data: { fitid: $('#quotation_fit_id').val(),quantity: $('#quotation_quantity').val()}
  #     success: (response) ->
  #       FitPrice = response[0].price
  #       alert FitPrice

  $("#quotation_shirt_type_id").change ->
    $("#quotation_fit_id").empty()
    $("#quotation_fit_id").append $('<option>',{
        text: "Select A Fit"
      })
    shirt_type_name = $("#quotation_shirt_type_id option:selected").text()
    $.ajax
      url: "/shirt_types.json"
      dataType: "json"
      success: (response) ->
        response.shirt_types.forEach (shirt_type) ->
          $test_html = $("<div></div>")
          # alert shirt_type_name
          # alert shirt_type.shirt_type_name
          # alert brand.brand
          # alert brand_name
          if shirt_type_name.toString() == shirt_type.shirt_type_name.toString()
            shirt_type.fits.forEach (fit) ->
              $("#quotation_fit_id").append $('<option>',{
                value: fit.fit_id,
                text: fit.fit_name
              })


  $("#quotation_brand_id").change ->
    $("#quotation_shirt_type_id").empty()
    $("#quotation_shirt_type_id").append $('<option>',{
        text: "Select A Type"
      })
    brand_name = $("#quotation_brand_id option:selected").text()
    $.ajax
      url: "/brands.json"
      dataType: "json"
      success: (response) ->
        response.forEach (brand) ->
          $test_html = $("<div></div>")
          # alert brand.brand
          # alert brand_name
          if brand_name.toString() == brand.brand.toString()
            if brand.add_on == 1
              $('#relabelling').show()
              $('#sew_tag').show()
            else
              $('#relabelling').hide()
              $('#sew_tag').hide()
            brand.shirt_types.forEach (shirt_type) ->
              $('#quotation_shirt_type_id').append $('<option>',{
                value: shirt_type.shirt_type_id,
                text: shirt_type.shirt_type_name
                })

  # $("#quotation_brand_id").change ->
  #   $("#quotation_fit_id").empty()
  #   $("#quotation_shirt_type_id").empty()
  #   $("#quotation_fit_id").append $('<option>',{
  #       text: "Select A Fit"
  #     })
  #   $("#quotation_shirt_type_id").append $('<option>',{
  #       text: "Select A Type"
  #     })
  #   brand_name = $("#quotation_brand_id option:selected").text()
  #   $.ajax
  #     url: "/brands.json"
  #     dataType: "json"
  #     success: (response) ->
  #       response.forEach (brand) ->
  #         $test_html = $("<div></div>")
  #         # alert brand.brand
  #         # alert brand_name
  #         if brand_name.toString() == brand.brand.toString()
  #           brand.fits.forEach (fit) ->
  #             $("#quotation_fit_id").append $('<option>',{
  #               value: fit.fit_id,
  #               text: fit.fit_name
  #             })
  #           brand.shirt_types.forEach (shirt_type) ->
  #             $('#quotation_shirt_type_id').append $('<option>',{
  #               value: shirt_type.shirt_type_id,
  #               text: shirt_type.shirt_type_name
  #               })
          #     $fit_html = $("<div class='fit'>"+fit.fit_name+"</div>")
          #     $test_html.append $fit_html
          # else
          #   alert "fuck"
          # $("#test").append $test_html

#
# $(document).ready ->
#    $("#quotation_brand_id").change ->
#     #  $.parseJSON(
#      $.ajax
#        url: "/brands"
#       #  type: "POST"
#        dataType: "json"
#
#        success: (response) ->
#         # $("#quotation_fit_id").val response
#         # json = $.parseJSON response
#         # alert(json.html)
#         console.log(typeof response)
        # response.each (res)->
        #   alert "a"
      # ).responseText

# ini boleh work
# $(document).ready ->
#    $.ajax
#      url: "/brands.json"
#      dataType: "json"
#      success: (response) ->
#       alert response[0].fits[0].fit
#       response.forEach (brand) ->
#         $brand_html = $("<div class='brand'> " + brand.brand+"</div>")
#         brand.fits.forEach (fit)->
#           $fit_html = $("<div class='fit'>"+fit.fit+"</div>")
#           $brand_html.append $fit_html
#         $("#test").append $brand_html
$(document).ready(ready)
$(document).on('page:load', ready)
