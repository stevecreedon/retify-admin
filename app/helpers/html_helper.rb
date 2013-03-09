module HtmlHelper

  def love_form_helper(form, opts={})
    HtmlHelper::FormHelper.new(self, form, opts) 
  end

  class FormHelper

    def initialize(controller, form, opts={})
      @form = form
      @model = form.object
      @controller = controller
      @opts = {class: 'input-xlarge'}.merge(opts)
    end

    def control_group(field, *args)
     opts = {input_type: :text_field, :label => label(field) , help_text: nil, value: nil, input: {}, select:{}, add_on: nil, help: nil}
     arg = args.slice!(0)
     
     if arg.is_a?(Symbol)
       opts[:input_type] = arg
       opts.merge!(args.first) unless args.empty?
     elsif arg.is_a?(Hash)
       opts.merge!(arg)
     end
     opts[:help] = help_partial(field) if help_exists?(field)
     opts[:input][:class] = @opts[:class] unless opts[:input][:class]
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
