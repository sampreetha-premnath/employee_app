# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application

require File.expand_path('../initializers/abstract_mysql_adapter', __FILE__)
TestApp::Application.initialize!

#require File.expand_path('../initializers/abstract_mysql_adapter', __FILE__)