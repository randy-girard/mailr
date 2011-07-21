## Introduction
_Mailr_ is a IMAP mail client based on _Ruby on Rails_ platform.

**NOTE** All path and filenames are based on _Rails.root_ directory.

### Requirements

In _Rails 3_ all dependencies should be defined in file _Gemfile_. All needed gems can be installed using bundler.

### Installation procedure

* Checkout the source code.

* Install all dependiences. Use _bundler_ for that.

* Prepare config/database.yml file (see _config/database.yml.example_).
  Check if proper gems (sqlite3/mysql/postgresql) are defined in _Gemfile_ and installed.

* Migrate database (rake db:migrate)

* Start rails server if applicable

* Point Your browser to application URL:
  For local access: http://localhost:3000
  For remote access: http://some_url/mailr

* Use it.
