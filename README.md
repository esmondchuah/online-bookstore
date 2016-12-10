# Online Bookstore
A database-centric application with features such as user authentication, book search and sorting, book orders, book recommendations, user reviews and ratings, admin panel with monthly sales statistics etc.

### System Configuration
This application is built with Ruby (v2.3.1) on Rails (v5.0.0.1). There is a great [tutorial](http://railsapps.github.io/installing-rails.html) on setting up a Ruby on Rails development environment.

### Installation
- Clone the repository to your local environment.
```sh
$ git clone https://github.com/esmondchuah/online-bookstore.git
```
- Open Terminal and navigate to the cloned repository.
```sh
$ cd online-bookstore
```
- Install existing gems.
```sh
$ bundle install
```

### Database Configuration
- Download and install [PostgreSQL](https://www.postgresql.org/download/).
- Create and configure *database.yml* and *secrets.yml* files in the *config* directory. You may refer to the samples provided in that same directory: [database.yml.sample](config/database.yml.sample) and [secrets.yml.sample](config/secrets.yml.sample).
- Turn on your database server.
- Run the following *rake* commands in your Terminal.
```sh
$ rake db:create
$ rake db:migrate
```

### Launch
- Run the following command and navigate to http://localhost:3000 in your browser.
```sh
$ rails server
```
