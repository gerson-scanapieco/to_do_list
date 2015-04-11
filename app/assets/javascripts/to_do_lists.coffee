$(document).on "click", ".new-assignment .close", ->
  $(this).closest(".new-assignment").remove()

# Ao clicar no botao de remocao, remove a div que contem o elemento
# removido e executa o JS enviado pelo servidor.
$(document).on "click", ".assignments-list .remove-assignment", ->
  assignment_id = $(this).closest(".assignment-entry").data("id")

  $.ajax(
    url: [ "/assignments/", assignment_id ].join("")
    data: { "id": assignment_id }
    method: "DELETE"
  ).done( (response) ->
    $(".assignments-list").find( ["[data-id='", assignment_id ,"']"].join("") ).remove()
    eval(response)
  ).fail (jqXHR, textStatus, errorThrown) ->
    console.log(errorThrown)

# Ao clicar no botao de edicao, eh possivel editar uma tarefa via AJAX.
# Aparecem inputs onde estavam os campos da Tarefa, e o botao de edicao
# se torna um botao que salva as alteracoes.
$(document).on "click", ".assignments-list .edit-assignment", ->
  assignmentEntry = $(this).closest(".assignment-entry")
  assignmentName = assignmentEntry.find(".assignment-name").text()
  assignmentDescription = assignmentEntry.find(".assignment-description").text()

  assignmentEntry.find(".assignment-name").find("b").hide()
  assignmentEntry.find(".assignment-description").find("p").hide()

  assignmentEntry.find(".assignment-name").append(
    ["<input type='text' class='assignment-name-input' id='edit-assignment-name' value=", assignmentName, "></input>"].join("")
  )

  assignmentEntry.find(".assignment-description").append(
    ["<input type='text' class='assignment-description-input' id='edit-assignment-description' value=", assignmentDescription, "></input>"].join("")
  )

  $(this).siblings().find(".assignment-name-input").focus()

  $(this).closest(".assignment-entry-buttons").append([
    '<button class="btn btn-success pull-right update-assignment" id="update-assignment" aria-label="Left Align">',
      '<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>',
    '</button>'].join("\n");
  )

  $(this).replaceWith([
    '<button type="button" class="btn btn-warning pull-right cancel-update-assignment" id="cancel-update-assignment" aria-label="Left Align">',
      '<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>',
    '</button>'].join("\n");
  )

# Ao clicar no botao de salvar alteracoes na Tarefa, antes de enviar os dados
# para o servidor eh preciso setar nos inputs ocultos os dados editados pelo usuario.
$(document).on "click", ".assignments-list .update-assignment", ->
  assignmentEntry = $(this).closest(".assignment-entry")

  editedName = assignmentEntry.find(".assignment-name").find(".assignment-name-input").val()
  editedDescription = assignmentEntry.find(".assignment-description").find(".assignment-description-input").val()

  assignmentEntry.find(".assignment-name-input-hidden").val(editedName)
  assignmentEntry.find(".assignment-description-input-hidden").val(editedDescription)

# Ao clicar no botao de cancelar edicao, deve voltar tudo ao estado
# atual da Tarefa.
$(document).on "click", ".assignments-list .cancel-update-assignment", ->
  assignmentEntry = $(this).closest(".assignment-entry")

  assignmentEntry.find(".assignment-name-input").remove()
  assignmentEntry.find(".assignment-description-input").remove()

  assignmentEntry.find(".assignment-name").find("b").show()
  assignmentEntry.find(".assignment-description").find("p").show()

  assignmentEntry.find(".assignment-entry-buttons").find(".update-assignment").remove()

  $(this).replaceWith([
    '<button type="button" class="btn btn-warning pull-right edit-assignment" aria-label="Left Align">',
      '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>',
    '</button>'].join("\n");
  )

$ ->
  
  # Requisicao AJAX para adicionar/remover lista dos favoritos
  # ao clicar no botao com a estrela
  $("#favorite-button").click ->
    # Nao eh favorito.
    if $(this).hasClass("btn-default")
      to_do_list_id = $(".section-header").data("id")

      $.ajax(
        url: "/favorite_to_do_lists"
        data: { "favorite_to_do_list": { "to_do_list_id": to_do_list_id } }
        method: "POST"
      ).done( (data) ->
        $("#favorite-button").removeClass("btn-default").addClass("btn-warning")
        $("#favorite-button").data("id", data.favorite_to_do_list.id)
      ).fail (jqXHR, textStatus, errorThrown) ->
        console.log(errorThrown)

    # Eh favorito
    else if $(this).hasClass("btn-warning")
      favorite_to_do_list_id = $("#favorite-button").data("id")

      $.ajax(
        url: [ "/favorite_to_do_lists/", favorite_to_do_list_id ].join("")
        data: { "id": favorite_to_do_list_id }
        method: "DELETE"
        dataType: "html"
      ).done( (data) ->
        $("#favorite-button").removeClass("btn-warning").addClass("btn-default")
        $("#favorite-button").data("id", "")
      ).fail (jqXHR, textStatus, errorThrown) ->
        console.log(errorThrown)

