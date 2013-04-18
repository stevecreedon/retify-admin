angular.module('lovebnb.field', [])
  .directive 'field', () ->
    transclude: true
    restrict: 'E'
    compile: (element, attr, controller) ->
      formId = "field_" + attr.value.replace /\./g, '_'

      inputAttr  = "class='#{attr.class || 'input-xlarge'}' ng-model='#{attr.value}' id='#{formId}' name='#{formId}'"

      if attr.required != undefined
        inputAttr += " required"
      if attr.maxlength
        inputAttr += " ng-maxlength='{#{attr.maxlength}}'"
      if attr.minlength
        inputAttr += " ng-minlength='{#{attr.minlength}}'"
      if attr.rows
        inputAttr += " rows='#{attr.rows}'"


      if attr.type == 'textarea'
        input = "<textarea #{inputAttr}></textarea>"
      else
        input = "<input type='#{attr.type || 'text'}' #{inputAttr}/>"

      if attr.append
        input = "<div class='input-append'>"+
                  input +
                  "<span class='add-on'>#{attr.append}</span>"+
                "</div>"

      errors = ""
      if attr.required != undefined
        errors += "<span class='help-inline' ng-show='form.#{formId}.$error.required'> can't be blank</span>"
      if attr.maxlength
        errors += "<span class='help-inline' ng-show='form.#{formId}.$error.maxlength'> too long</span>"
      if attr.minlength
        errors += "<span class='help-inline' ng-show='form.#{formId}.$error.minlength'> too short</span>"

      element.html(
        "<div class='control-group' ng-class='{\"error\": submited && !form.#{formId}.$valid}'>" +
          "<label for='#{formId}' class='control-label' ng-transclude></label>" +
          "<div class='controls'>" +
            input +
            "<span class='errors' ng-show='submited'>" +
            errors +
            "</span>" +
          "</div>" +
        "</div>"
      )
