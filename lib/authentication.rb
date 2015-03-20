# encoding: utf-8
module Authentication
  mattr_accessor :login_regex, :bad_login_message, 
    :name_regex, :bad_name_message,
    :email_name_regex, :domain_head_regex, :domain_tld_regex, :email_regex, :bad_email_message

  # self.login_regex       = /\A\w[\w\.\-_@]+\z/                     # ASCII, strict
  self.login_regex       = /\A[[:alnum:]][[:alnum:]\.\-_@]+\z/     # Unicode, strict
  # self.login_regex       = /\A[^[:cntrl:]\\<>\/&]*\z/              # Unicode, permissive

  self.bad_login_message = lambda { I18n.t('authentication.errors.bad_login_message') }

  self.name_regex        = /\A[^[:cntrl:]\\<>\/&]*\z/              # Unicode, permissive
  self.bad_name_message  = lambda { I18n.t('authentication.errors.bad_name_message') }

  self.email_name_regex  = '[A-Za-z0-9\-\+\_]+'.freeze
  self.domain_head_regex = '(\.[A-Za-z0-9\-\+\_]+)*'.freeze
  self.domain_tld_regex  = '(([a-z0-9]([-a-z0-9]*[a-z0-9])?\.){1,4})([a-z]{2,15})'.freeze
  self.email_regex       = /#{email_name_regex}\@#{domain_head_regex}#{domain_tld_regex}/i
  self.bad_email_message = lambda { I18n.t('authentication.errors.bad_email_message') }

  def self.included(recipient)
    recipient.extend(ModelClassMethods)
    recipient.class_eval do
      include ModelInstanceMethods
    end
  end

  module ModelClassMethods
    def secure_digest(*args)
      Digest::SHA1.hexdigest(args.flatten.join('--'))
    end

    def make_token
      secure_digest(Time.now, (1..10).map{ rand.to_s })
    end
  end # class methods

  module ModelInstanceMethods
  end # instance methods
end
