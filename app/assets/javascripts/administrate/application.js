//= require jquery
//= require jquery_ujs
//= require selectize
//= require moment
//= require datetime_picker
//= require_tree .

document.addEventListener("DOMContentLoaded", function(event) {
  var uniqueId = 1;
  $('.farmally-add-field-button').click(function() {
    var target = $(this).data("target");
    var new_table_row = $(target + ' tr:visible:last').clone();
    var new_id = new Date().getTime() + (uniqueId++);
    new_table_row.find("input, select").each(function () {
      var el = $(this);

      // 追加分には削除チェックボックスを追加しない
      if(el.prop("name").match(/_destroy/)){
        el.remove();
      }

      el.val("");
      // Replace last occurrence of a number
      el.prop("id", el.prop("id").replace(/\d+(?=[^\d]*$)/, new_id))
      el.prop("name", el.prop("name").replace(/\d+(?=[^\d]*$)/, new_id))
    })

    $(target).prepend(new_table_row);
  })

  $("#sale_item_sale_property_template_id").on("change", function(){
    $.ajax({
      url: $("form").attr("data-property-list-url"),
      data: { sale_property_template_id: $(this).val() }
    });
  });
});
