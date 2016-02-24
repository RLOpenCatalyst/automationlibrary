# Automationlibrary
===================
Repository for RLCatalyst chef libraries

#Branching Strategy

The central repository will have two branches with infinite lifetime
* master 
* dev 

*Supported Branches* 
For contributions to RLCatalyst create a feature or hot fix branch and make changes. Usage of the branches shall be explained  in the following section.

#Code Contributions
*Step 1: Fork*
```
$ git clone git@github.com:username/core.git
$ cd core
$ git remote add upstream git://github.com/RLOpenCatalyst/core.git
```

*Step 2: Branch*

Create a feature branch and start hacking
```
$ git checkout -b my-feature-branch -t origin/master
```

*Step 3: Commit*

Make sure git knows your name and email address
```
$ git config --global user.name "J. Random User"
$ git config --global user.email "j.random.user@example.com"
```

**Writing good commit logs is important. A commit log should describe what changed and why. Follow these guidelines when writing one**

1. The first line should be 50 characters or less and contain a short description of the change prefixed with the name of the changed subsystem.
2. Keep the second line blank.
3. A good commit log can look something like this: [subsystem: explaining the commit in one line]
4. Body of commit message is a few lines of text, explaining things in more detail, possibly giving some background about the issue being fixed, etc. etc.
5. The header line should be meaningful; it is what other people see when they run git shortlog or git log --oneline.

Check the output of git log --oneline files_that_you_changed to find out what subsystem (or subsystems) your changes touch.

 *Step 4: Rebase*

 Use git rebase (not git merge) to sync your work from time to time.
```
 $ git fetch upstream
 $ git rebase upstream/master
```

*Step 5: Push*

```
 $ git push origin my-feature-branch
```

Pull requests will usually be reviewed within a few days. If there are comments to address, apply your changes in a separate  commit and push that to your feature branch. Post a comment in the pull request afterwards; GitHub does not send out   notifications when you add commits.

#Code Review

Each Github pull request will go through the following step before merge:

 1. We will execute our automated test cases against the pull request. If the tests failed the pull request will be rejected with comments provided on the failures.

 2. If tests pass, the RLCatalyst engineering team member will do the review of the changes. Technical communication possible via github.com pull request page. When ready, your pull request will be tagged with label Ready For Merge.

 3. Your patch will be merged into master including necessary documentation updates.

 4. After merge the feature branch will be deleted.

#Release Strategy 
Our primary shipping vehicle is operating system specific packages that includes all the requirements of RLCatalyst.

Our version numbering closely follows Semantic Versioning standard. Our standard version numbers look like X.Y.Z which mean:

* X is a major release, which may not be fully compatible with prior major releases
* Y is a minor release, which adds both new features and bug fixes
* Z is a patch release, which adds just bug fixes
We frequently make releases with version numbers that look like 3.0.1 or 3.0.2. These releases are still well tested but not as throughly as Minor releases.

We do a Minor release approximately every 1 months and Patch releases on a when-needed basis for regressions, significant bugs, and security issues.

Announcements of releases will be maid available to our mailing list and slack channel.

#Logging Issues
When opening new issues or commenting on existing issues please make sure discussions are related to concrete technical issues with the RLCatalyst software

RLCatalyst Issue Tracking is handled using Github Issues.

If you are familiar with RLCatalyst and know the repository that is causing you a problem or if you have a feature request on a specific component, you can file an issue in the corresponding GitHub project. All of our Open Source Software can be found in our GitHub organization.

Otherwise you can file your issue in the RLCatalyst project and we will make sure it gets filed against the appropriate project.

To decrease the back and forth in issues, and to help us get to the bottom of them quickly, we use the issue template below.  You can copy/paste this template into the issue you are opening and edit it accordingly::

```
  Version:[Version of the project installed]

  Environment:[Details about the environment such as the Operating System, cookbook details, etc.]

  Scenario:[What you are trying to achieve and you can't?]

  Steps to Reproduce:[If you are filing an issue, what are the things we need to do to reproduce your problem?]

  Expected Result:[What are you expecting to happen as the consequence of the reproduction steps above?]

  Actual Result:[What actually happens after the reproduction steps?]
```

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



