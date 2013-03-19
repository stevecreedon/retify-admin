require 'spec_helper'

describe HtmlHelper do

  let(:model){PropertyDecorator.new(stub_model(Property, :name => 'steve', :other => nil))}
  
  it 'should return an instance of LoveFormHelper' do
    form_for(model) do |f|
      lfh = helper.love_form_helper(f)
      lfh.should be_a(HtmlHelper::LoveFormHelper)
    end
  end

 
  it 'should return an input type text htmlcontrol group "property_name"' do
    form_for(model) do |f|
      lfh = helper.love_form_helper(f)
      lfh.control_group(:name).html.should == CG_NAME.html
    end
  end

  it 'should return an input type text htmlcontrol with the supplied value"' do
    form_for(model) do |f|
      lfh = helper.love_form_helper(f)
      lfh.control_group(:other, :input => {value: 'hrabal'}).html.should == CG_VALUE.html
    end
  end

  it 'should add the data-stuff attribute to the input tag' do
     form_for(model) do |f|
      lfh = helper.love_form_helper(f)
      lfh.control_group(:name, :input => {"data-stuff" => 'abc123'}).html.should == CG_INPUT_DATA_STUFF.html
    end
  end


  it 'should return a password htmlcontrol group "property_name"' do
    form_for(model) do |f|
      lfh = helper.love_form_helper(f)
      lfh.control_group(:password_field, :name).html.should == CG_PASSWORD.html
    end
  end

  it 'should add help text' do
    form_for(model) do |f|
      lfh = helper.love_form_helper(f)
      lfh.control_group(:name, :help_text => 'some help').html.should == CG_HELP_TEXT.html
    end
  end

  it 'should add an add-on span' do
    form_for(model) do |f|
      lfh = helper.love_form_helper(f)
      lfh.control_group(:name, :add_on => 'some add on').html.should == CG_ADD_ON.html
    end
  end

  it 'should set the label to the specified text not the field' do
    form_for(model) do |f|
      lfh = helper.love_form_helper(f)
      lfh.control_group(:name, :label => 'some other label').html.should == CG_LABEL.html
    end
  end

  it 'should add a help button if a help file exists' do
    form_for(model) do |f|
      lfh = helper.love_form_helper(f)
      helper.view_paths.unshift "spec/fixtures/"
      lfh.control_group(:name).html.should == CG_HELP.html
    end
  end

  it 'should render a select with the options provided' do
    form_for(model) do |f|
      lfh = helper.love_form_helper(f)
      lfh.control_group(:select, :name, select: {options: ['joe','bob','isay']}).html.should == CG_SELECT.html
    end
  end

  it 'should render a select with the options provided and the correct name selected' do
    form_for(model) do |f|
      lfh = helper.love_form_helper(f)
      lfh.control_group(:select, :name, select: {options: ['joe','steve','isay']}).html.should == CG_SELECT.html
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

CG_VALUE = <<CG_VALUE
<div class="control-group ">
         <label class="control-label" for="property_other">Other</label>
         <div class="controls">
             <input class="input-xlarge" id="property_other" name="property[other]" size="30" type="text" value="hrabal" />
         </div>
       </div>
CG_VALUE


CG_INPUT_DATA_STUFF = <<CG_INPUT_DATA_STUFF
<div class="control-group ">
         <label class="control-label" for="property_name">Name</label>
         <div class="controls">
             <input data-stuff="abc123" class="input-xlarge" id="property_name" name="property[name]" size="30" type="text" value="steve" />
         </div>
       </div>
CG_INPUT_DATA_STUFF


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

CG_LABEL = <<CG_LABEL
<div class="control-group ">
         <label class="control-label" for="property_name">some other label</label>
         <div class="controls">
             <input class="input-xlarge" id="property_name" name="property[name]" size="30" type="text" value="steve" />
         </div>
       </div>
CG_LABEL

CG_HELP = <<CG_HELP
<div class="control-group ">
     <label class="control-label" for="property_name">Name</label>
     <div class="controls">
         <input class="input-xlarge" id="property_name" name="property[name]" size="30" type="text" value="steve" />
         <a href="#" class="btn btn-small btn-danger btn-help">?</a>
         <div class="help_container">
           <div class="what">What</div>
           <div class="why">Why</div>
           <div class="example">example</div>
         </div>
     </div>
</div>
CG_HELP

CG_SELECT = <<CG_SELECT
<div class="control-group ">
     <label class="control-label" for="property_name">Name</label>
     <div class="controls">
         <select id="property_name" name="property[name]">
           <option value="joe">joe</option>
           <option value="bob">bob</option>
           <option value="isay">isay</option>
         </select>
     </div>
</div>
CG_SELECT

end
