# frozen_string_literal: true

require 'spec_helper'

describe Flashes do
  before :each do
    @session = {}
  end

  # Class map
  it 'creates an error flash' do
    f = Flashes.new(@session).push('Error flash', :error)
    expect(f.all[0][:class]).to eq('danger')
  end

  it 'creates a success flash' do
    f = Flashes.new(@session).push('Successful flash', :success)
    expect(f.all[0][:class]).to eq('success')
  end

  it 'creates an info flash' do
    f = Flashes.new(@session).push('Info flash').push('Info flash 2', :info)
    expect(f.all[0][:class]).to eq('info')
    expect(f.all[1][:class]).to eq('info')
  end

  # Auto save
  it 'saves when autosave is on' do
    Flashes.new(@session).push('Example')
    expect(@session.key?(:flashes)).to eq(true)

    Flashes.new(@session, true).push('Example')
    expect(@session.key?(:flashes)).to eq(true)
  end

  it 'does not save when autosave is off' do
    Flashes.new(@session, false).push('Example')
    expect(@session.key?(:flashes)).to eq(false)
  end

  # Misc
  it 'consume! empties store' do
    f = Flashes.new(@session, false).push('Example')
    items = f.consume!
    expect(@session[:flashes].empty?).to eq(true)
    expect(items[0][:msg]).to eq('Example')
  end

  it 'clear! empties store' do
    f = Flashes.new(@session).push('Example').clear!
    expect(f.all.empty?).to eq(true)
  end

  it 'all returns all items' do
    f = Flashes.new(@session)
    f.push('Test 1')
    f.push('Test 2')
    f.push('Test 3')
    expect(f.all.size).to eq(3)
  end

  it 'consumes session on each new call' do
    f = Flashes.new(@session)
    f.push('Test 1')
    f.push('Test 2')
    f.push('Test 3')

    # Should consume the above list
    f = Flashes.new(@session)
    expect(f.all.size).to eq(3)

    # Should be empty since last list was consumed
    f = Flashes.new(@session)
    expect(f.all.size).to eq(0)
  end
end
