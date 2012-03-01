# encoding: UTF-8
module Padrino
  module Flash
    class Storage
      include Enumerable

      attr_reader :now
      attr_reader :next

      # @private
      def initialize(session)
        @now  = session || {}
        @next = {}
      end

      ###
      # Returns the specified flash message
      #
      # @return [String]
      #   Flash message
      #
      # @example
      #   flash[:notice]
      #   # => 'Invalid login/password combination'
      #
      # @since 0.1.0
      # @api public
      def [](type)
        @now[type]
      end

      ###
      # Sets the specified flash message
      #
      # @example
      #   flash[:notice] = 'Invalid login/password combination'
      #   flash[:notice] = :invalid_login
      #
      # @since 0.1.0
      # @api public
      def []=(type, message)
        message = I18n.translate(message) if message.is_a?(Symbol)
        @next[type] = message
      end

      ###
      # Deletes the specified flash message
      #
      # @return [String]
      #   Value of the deleted flash message
      #
      # @example
      #   flash.delete :notice
      #
      # @since 0.1.0
      # @api public
      def delete(type)
        @now.delete(type)
      end

      ###
      # Returns an array of flashes that have been set
      #
      # @return [Array<Symbol>]
      #   Flashes set
      #
      # @example
      #   flash.keys
      #   # => [:notice]
      #
      # @since 0.1.0
      # @api public
      def keys
        @now.keys
      end

      ###
      # Returns whether or not the specified flash is set
      #
      # @return [Boolean]
      #   *true* if it is, *false* otherwise
      #
      # @example
      #   flash.key?(:notice)
      #   # => true
      #
      # @since 0.1.0
      # @api public
      def key?(type)
        @now.key?(type)
      end
      alias_method :has_key?, :key?
      alias_method :include?, :key?

      ###
      # Iterates through set flashes
      #
      # @example
      #   flash.each do |type, message|
      #     # ...
      #   end
      #
      # @since 0.1.0
      # @api public
      def each(&block)
        @now.each(&block)
      end

      # @since 0.1.0
      # @api public
      def replace(hash)
        @now.replace(hash)
        self
      end

      # @since 0.1.0
      # @api public
      def update(hash)
        @now.update(hash)
        self
      end
      alias_method :merge!, :update

      # @since 0.1.0
      # @api private
      def sweep
        @now.replace(@next)
        @next = {}
        self
      end

      ###
      # Keeps the specified flash for the next request
      #
      # @example
      #   flash.keep :notice
      #   flash.keep
      #
      # @since 0.1.0
      # @api public
      def keep(key = nil)
        if key
          @next[key] = @now[key]
        else
          @next.merge!(@now)
        end
      end

      ###
      # Discards the specified flash so it doesn't show up on the next request
      #
      # @example
      #   flash.discard :notice
      #   flash.discard
      #
      # @since 0.1.0
      # @api public
      def discard(key = nil)
        if key
          @next.delete(key)
        else
          @next = {}
        end
      end

      ###
      # Deletes all flashes that are currently set
      #
      # @example
      #   flash.clear
      #
      # @since 0.1.0
      # @api public
      def clear
        @now.clear
      end

      ###
      # Returns whether or not any flashes have been set
      #
      # @return [Boolean]
      #   *true* if flashes are set, *false* otherwise
      #
      # @example
      #   flash.empty?
      #   # => true
      #
      # @since 0.1.0
      # @api public
      def empty?
        @now.empty?
      end

      # @since 0.1.0
      # @api public
      def to_hash
        @now.dup
      end

      # @since 0.1.0
      # @api public
      def to_s
        @now.to_s
      end

      ###
      # Writer for the flash trinity :error (red)
      #
      # @example
      #   flash.error = 'Something really bad happened here'
      #
      # @since 0.1.0
      # @api public
      def error=(message)
        self[:error] = message
      end

      ###
      # Reader for the flash trinity :error (red)
      #
      # @return [String]
      #   Flash message
      #
      # @example
      #   flash.error
      #   # => 'Something really bad happened here'
      #
      # @since 0.1.0
      # @api public
      def error
        self[:error]
      end

      ###
      # Writer for the flash trinity :notice (yellow)
      #
      # @example
      #   flash.notice = 'Something that needs your attention happened here'
      #
      # @since 0.1.0
      # @api public
      def notice=(message)
        self[:notice] = message
      end

      ###
      # Reader for the flash trinity :notice (yellow)
      #
      # @return [String]
      #   Flash message
      #
      # @example
      #   flash.notice
      #   # => 'Something that needs your attention happened here'
      #
      # @since 0.1.0
      # @api public
      def notice
        self[:notice]
      end

      ###
      # Writer for the flash trinity :success (green)
      #
      # @example
      #   flash.success = 'Something good happened here'
      #
      # @since 0.1.0
      # @api public
      def success=(message)
        self[:success] = message
      end

      ###
      # Reader for the flash trinity :success (green)
      #
      # @return [String]
      #   Flash message
      #
      # @example
      #   flash.success
      #   # => 'Something good happened here'
      #
      # @since 0.1.0
      # @api public
      def success
        self[:success]
      end
    end # Storage
  end # Flash
end # Padrino