
#puts __FILE__
require ::File.expand_path('../config/environment',  __FILE__)
#puts "config files ok"
run HotCompress::Application

#A call to `File.expand_path('../config/environment',  __FILE__)` evaluates to an 
#absolute path to `config/environment`. This enables running Rails applications from any location.
#Config.ru
#---------
#Rails uses Rack as the basis for its HTTP handling.
#Config.ru is a convention by which we indicate how to run a Rack-based application. This is also called to *rack-up* an application.

