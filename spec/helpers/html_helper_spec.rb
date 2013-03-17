require 'spec_helper'

describe HtmlHelper do

  let(:model){PropertyDecorator.new(stub_model(Property, :name => 'steve'))}
  
  it 'should return an instance of LoveFormHelper' do
    form_for(model) do |f|
      lfh = love_form_helper(f)
      lfh.should be_a(HtmlHelper::LoveFormHelper)
    end
  end

  it 'should return an input htmlcontrol group "property_name"' do
    form_for(model) do |f|
      lfh = love_form_helper(f)
      lfh.control_group(:name).html.should == CG_NAME.html
    end
  end

  it 'should return a password htmlcontrol group "property_name"' do
    form_for(model) do |f|
      lfh = love_form_helper(f)
      lfh.control_group(:password_field, :name).html.should == CG_PASSWORD.html
    end
  end

  it 'should add help text' do
    form_for(model) do |f|
      lfh = love_form_helper(f)
      lfh.control_group(:name, :help_text => 'some help').html.should == CG_HELP_TEXT.html
    end
  end

  it 'should add an add-on span' do
    form_for(model) do |f|
      lfh = love_form_helper(f)
      lfh.control_group(:name, :add_on => 'some add on').html.should == CG_ADD_ON.html
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

CG_PASSWORD = <<CG_PASSWORD
<div class="control-group ">
         <label class="control-label" for="property_name">Name</label>
         <div class="controls">
             <input class="input-xlarge" id="property_name" name="property[name]" size="30" type="password" />
         </div>
       </div>
CG_PASSWORD

CG_HELP_TEXT = <<CG_TEXT
<div class="control-group ">
         <label class="control-label" for="property_name">Name</label>
         <div class="controls">
             <input class="input-xlarge" id="property_name" name="property[name]" size="30" type="text" value="steve" />
             <p class="help-block">some help</p>
         </div>
       </div>
CG_TEXT

CG_ADD_ON = <<CG_ADD_ON
<div class="control-group ">
         <label class="control-label" for="property_name">Name</label>
         <div class="controls">
             <input class="input-xlarge" id="property_name" name="property[name]" size="30" type="text" value="steve" /><span class="add-on">.some add on </span>
         </div>
       </div>
CG_ADD_ON


  

end
