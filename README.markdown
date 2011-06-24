## Introduction
_Mailr_ is a IMAP mail client based on _Ruby on Rails_ platform.

##  Installation guide

**NOTE** All path and filenames are based on _Rails.root_ directory.

### Requirements

In _Rails 3_ all dependencies should be defined in file _<Rails.root>.Gemfile_. All needed gems can be installed using bundler.

### Installation procedure

* Checkout the source code.

* If you need to override some of the default constants used in the application take a look at config/default_site.rb. Then create config/site.rb that contains only the keys which you want to override. Example content of config/site.rb is:

```ruby
module CDF

LOCALCONFIG = {
  :imap_server => 'your.imap.server'
}
end
```

* Configure SMTP settings

```ruby
# initializers/smtp_settings.rb
  ActionMailer::Base.smtp_settings = {
  :address => "mail.example.com.py",
  :port => 26,
  :authentication => :plain,
  :enable_starttls_auto => true,
  :user_name => "emilio@example.com.py",
  :password => "yourpass"
}
```

* Prepare config/database.yml file (see config/database.yml.example).
   Check if proper gems (sqlite3/mysql/postgresql) are defined in _Gemfile_ and installed.

* Migrate database (rake db:migrate)

* Use it.

