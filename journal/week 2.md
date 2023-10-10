

# Terraform Beginner Bootcamp 2023 - Week 2

## WORKING WITH RUBY

### BUNDLER
In Ruby, Bundler is a tool that helps manage a project's dependencies. It simplifies the process of specifying and installing the gems (Ruby libraries) that your project relies on. Bundler uses a Gemfile to specify the dependencies for a Ruby project. Once you have a Gemfile, you can use the bundle install command to install the specified gems along with their dependencies. When running Ruby scripts or commands that depend on the gems specified in your Gemfile, it's a good practice to use bundle exec. For example, instead of running rails server, you would run bundle exec rails server. 

### INSTALL GEMS
To install gems in Ruby, you can use the gem command, which is Ruby's package manager. To install a specific gem

```
gem install gem_name
```

To install rails:

```
gem install rails
```

### EXECUCTING RUBY SCRIPTS IN THE CONTEXT OF BUNDLER
When running Ruby scripts in the context of Bundler, you want to make sure that your script uses the gems specified in your Gemfile. Here are the steps to run a Ruby script with Bundler:
Pass the script name to the ruby command:

bundle exec ruby [script_file_name
### SINATRA

[Sinatra](https://sinatrarb.com/) is a lightweight and flexible web application framework written in Ruby. It is often referred to as a micro-framework because of its simplicity and minimalistic design. Despite its size, Sinatra is powerful and well-suited for building small to medium-sized web applications and APIs. Here are some key features and aspects of Sinatra:


## TERRATOWNS MOCK SERVER

### RUNNING THE WEB SERVER

We can run the web server by executing the following commands:
```
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.
