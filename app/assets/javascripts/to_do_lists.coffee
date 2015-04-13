$(document).on "click", ".new-assignment .close", ->
  $(this).closest(".new-assignment").remove()

# Validar form de novo Assignment antes de enviar ao servidor
#
$(document).on "click", ".new-assignment .add-assignment", (event) ->
  assignment_name = $(this).closest(".new-assignment").find("#assignment_name")
  if assignment_name.val() == ""
    assignment_name.parent().addClass("has-error")
    event.preventDefault()

# Ao digitar algo no input #assignment_name do form de novo Assignment,
# retirar a classe 'has-error' e adicionar a classe 'has-success' se
# o input nao estiver em branco
$(document).on "keypress", ".new-assignment #assignment_name", (event) ->
  $(this).parent().removeClass("has-error") if $(this).parent().hasClass("has-error")
  $(this).parent().addClass("has-success") unless $(this).parent().hasClass("has-success")

# Ao digitar algo no input 'nome' quando esta editando um Assignment,
# retirar a class 'has-error' e adicionar a classe 'has-success' se o input nao
# estiver em branco
$(document).on "keypress",".assignments-list .assignment-name-input", (event) ->
  $(this).parent().removeClass("has-error") if $(this).parent().hasClass("has-error")
  $(this).parent().addClass("has-success") unless $(this).parent().hasClass("has-success")


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
  assignmentDescription = assignmentEntry.find(".assignment-description p").text()

  assignmentEntry.find(".assignment-name").find("b").hide()
  assignmentEntry.find(".assignment-description").find("p").hide()

  assignmentEntry.find(".assignment-name").append([
      ["<div class='form-group'>"],
        ["<input type='text' class='assignment-name-input form-control' id='edit-assignment-name' value=", assignmentName, "></input>"].join(""),
      ["</div>"]
    ].join("\n")
  )

  assignmentEntry.find(".assignment-description").append([
      ["<div class='form-group'>"],
      ["<textarea class='assignment-description-input form-control' id='edit-assignment-description'>", assignmentDescription, "</textarea>"].join(""),
      ["</div>"]
    ].join("\n")
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
# Nao deve enviar dados se o campo 'nome' estiver vazio
#
$(document).on "click", ".assignments-list .update-assignment", (event) ->
  assignmentEntry = $(this).closest(".assignment-entry")

  nameField = assignmentEntry.find(".assignment-name").find(".assignment-name-input")
  editedName = nameField.val()
  editedDescription = assignmentEntry.find(".assignment-description").find(".assignment-description-input").val()

  # Nao envia form se campo 'nome' estiver em branco e 
  # marca o campo com erro
  if editedName == ""
    event.preventDefault
    nameField.parent().addClass("has-error") unless nameField.parent().hasClass("has-error")
    return false

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

