# Automationlibrary
===================
Repository for RLCatalyst chef libraries

#Branching Strategy

1. Fork the master branch
2. Clone the repo
3. Once the changes are done, raise a pull request to the master branch.
4. We will review and merge the changes

Usage:
------
1. After chef server is configured, clone this repository on where you have configured knife (chef workstation directory).
2. Run the ruby program available in this repositry.
	```
	ruby cookbooks_upload.rb
	```
	It will upload all the cookbooks along with the dependencies to the chef server.



List of the cookbooks:
----------------------

- app_data_handler : It is used to POST the application data to catalyst App deploy API.

- database : It will provide enhanced database resources to include in recipes.

- deploy_dotNet : Configures Windows server to launch dotNet application.

- deploy_dotnet_myshopper : Configures Windows server to launch ASP.NET application

- deploy_iis : Installs IIS and creates environment ready.

- deploy_jboss_ear : It will be used to deploy war or ear file from any source.

- deploy_liferay_app : It will deploy liferay application.

- deploy_rlcatalyst  : It will install Catalyst application on a node.

- deploy_tomcat_war  : It will any war file in  tomcat server and post the application details to catalyst App_deploy API.

- deploy_upgrade_catalyst : It will install or upgrade catalyst application and POST the application details to catalyst App_deploy API.

- docker : It contains all the resource required to  operate docker images, containers and service.

- docker_pull_rl : It is used to pull the private docker image by passing the attributes mentioned in the respective metadaata.rb. 

- iis  :  It provide whole IIS features.

- java8 : It will be used to install Oracle JAVA.

- jboss7_rl : It will be used to install JBOSS application server.

- liferay : It provide all the tools to deploy liferays application.

- mongodb3 : It will be used to install mongodb version 3.2.0

- postgresql : It helps in installing postgres server and client.

- tomcat-all-rl : It will be used to install tomcat application server.


Disclaimer:
-----------
You may get warning from HTTPClient::CookieManager library, which would be thrown by httpclient-2.6.0.1 gem. 
Reference Issue: https://github.com/chef/chef-dk/issues/597
However it will not interrupt or affect the program execution. 



