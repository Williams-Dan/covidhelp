# frozen_string_literal: true

#:nodoc:
class Flashes
  include Enumerable

  def initialize(session, autosave = true)
    @session  = session
    @items    = session.delete(:flashes) || []
    @autosave = autosave
  end

  # Adds a new flash message
  def push(msg, type = :info)
    @items.push(_make_flash(msg, type))
    save! if @autosave
    self
  end

  # Returns all messages and empties the session of flashes
  def consume!
    items = @items
    clear!
    save! unless @autosave
    items
  end

  # Empties the list of messages
  def clear!
    @items = []
    save! if @autosave
    self
  end

  # Saves the messages to the session
  def save!
    @session[:flashes] = all
    self
  end

  def each(&block)
    @items.each do |flash|
      block.call(flash)
    end
  end

  def all
    @items
  end

  def empty?
    @items.empty?
  end

  def _make_flash(msg, type = :info)
    class_map = { info: 'info', error: 'danger', success: 'success' }

    if msg.class == Hash
      msg = msg[:msg] || return
      type ||= msg[:type] || :info
    end

    { msg: msg, type: type, class: class_map[type] }
  end
end
