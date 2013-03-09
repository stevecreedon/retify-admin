module HtmlHelper

  def love_form_helper(form)
    HtmlHelper::FormHelper.new(self, form) 
  end

  class FormHelper

    def initialize(controller, form)
      @form = form
      @model = form.object
      @controller = controller
    end

    def control_group(field, opts={})
     opts = {input_type: :text_field, :label => label(field) , help_text: nil, value: nil, input: {}, add_on: nil, help: nil}.merge(opts)
     opts[:help] = help_partial(field) if help_exists?(field)
     opts[:input].merge(class: 'input-xlarge') unless opts[:input][:class]
     @controller.render :template => 'widgets/_control_group', :locals => opts.merge(:field => field, :form => @form, :model => @model)
    end

    def label(field)
      field.to_s.capitalize.gsub("_"," ")
    end

    def help_subfolder
      @model.class.name.downcase.gsub("decorator","")
    end

    def help_exists?(field)
      File.exists?(help_template(field))
    end

    def help_partial(field)
      "help/#{help_subfolder}/#{field}"
    end

    def help_template(field)
      File.join(Rails.root,"app", "views", "help", help_subfolder, "_#{field}.html.erb")
    end

  end

  def form_box h2, &block
    render(:layout => 'widgets/box', :locals => {h2: h2}) do
      block.call
    end
  end

end
