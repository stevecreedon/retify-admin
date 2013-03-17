require 'spec_helper'

describe HtmlHelper do

  let(:model){PropertyDecorator.new(stub_model(Property, :name => 'steve'))}
  
  it 'should return an instance of LoveFormHelper' do
    form_for(model) do |f|
      lfh = love_form_helper(f)
      lfh.should be_a(HtmlHelper::LoveFormHelper)
      lfh.control_group(:name).html.should == CG_NAME.html
    end
  
  end

CG_NAME = <<CG_NAME
<div class="control-group ">
         <label class="control-label" for="property_name">Name</label>
         <div class="controls">
             <input class="input-xlarge" id="property_name" name="property[name]" size="30" type="text" value="steve" />
         </div>
       </div>
CG_NAME
  

end
