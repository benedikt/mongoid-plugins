require 'spec_helper'

describe Mongoid::Plugins do

  let(:klass) { Class.new }
  let(:plugin) { Module.new }

  before(:each) do
    klass.send(:include, Mongoid::Document)
  end

  it 'should be auto included into Mongoid::Document' do
    klass.should include Mongoid::Plugins
  end

  it 'should add a .plugin method' do
    klass.should respond_to :plugin
  end

  it 'should add a .plugin_options_for method' do
    klass.should respond_to :plugin_options_for
  end

  describe '.plugin' do
    it 'should include the given module' do
      klass.plugin(plugin)
      klass.should include plugin
    end

    it 'should store plugin options for the given module' do
      klass.plugin(plugin)
      klass.plugin_options_for(plugin).should be_kind_of ActiveSupport::OrderedOptions
    end

    it 'should call .default_plugin_options on the given module' do
      plugin.should_receive(:respond_to?).with(:default_plugin_options).and_return(true)
      plugin.should_receive(:default_plugin_options).and_return({})
      klass.plugin(plugin)
    end

    it 'should not call .default_plugin_options on the given module if it is not defined' do
      plugin.should_receive(:respond_to?).with(:default_plugin_options).and_return(false)
      plugin.should_not_receive(:default_plugin_options).and_return({})
      klass.plugin(plugin)
    end

    it 'should use the hash returned by default_plugin_options to populate the plugin options hash' do
      plugin.should_receive(:respond_to?).with(:default_plugin_options).and_return(true)
      plugin.should_receive(:default_plugin_options).and_return({ :default => true })
      klass.plugin(plugin)
      klass.plugin_options_for(plugin).should eql({ :default => true })
    end

    it 'should pass the options hash into the block' do
      klass.plugin(plugin) do |c|
        c.should be_kind_of ActiveSupport::OrderedOptions
      end
    end
  end

  describe '.plugin_options_for' do
    before(:each) do
      plugin.stub!(:default_plugin_options).and_return({
        :active => true,
        :other => 'Option',
        :setting => 10
      })

      klass.plugin(plugin) do |c|
        c.active = false
        c.other = 'Awesome'
      end
    end

    it 'should return the options for the given module' do
      klass.plugin_options_for(plugin).should be_kind_of ActiveSupport::OrderedOptions
    end

    it 'should include the given options' do
      options = klass.plugin_options_for(plugin)
      options.active.should be_false
      options.other.should eql('Awesome')
      options.setting.should eql(10)
    end

    it 'should raise an exception when given plugin is not available' do
      expect { klass.plugin_options_for(Module.new) }.to raise_error /is not loaded/
    end
  end
end
