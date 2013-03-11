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

   
    def control_group(*args)
     opts = {input_type: :text_field,  help_text: nil, value: nil, input: {}, select:{}, add_on: nil, help: nil}
     main = []    
 
     #extract the part of our args that is a symbol e.g. :text_field or :text_area
     while((arg = args.slice!(0)).is_a?(Symbol))
       main << arg
     end
     
     #if we have some of these symbol args then merge them into the main opts
     case main.size
     when 1 then
       zipped = [:field].zip(main) 
       opts.merge!(Hash[zipped])
     when 2 then
       zipped = [:input_type, :field].zip(main) 
       opts.merge!(Hash[zipped])
     end

     #if we still have a hash then merge it into our options
     if arg.is_a?(Hash)
       opts.merge!(arg)
     end

     opts[:label] = label(opts[:field]) unless opts[:label]
     opts[:help] = help_partial(opts[:field]) if help_exists?(opts[:field])
     opts[:input][:class] = @opts[:class] unless opts[:input][:class]
     @controller.render :template => 'widgets/_control_group', :locals => opts.merge(:form => @form, :model => @model)
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
