#
# Cookbook Name:: app_data_handler
# Library:: app_data_handler
#
# Copyright 2015, Relevance Lab INC
#
# All rights reserved - Do Not Redistribute
#

require 'chef'
require 'chef/handler'
require 'rest-client'
require 'net/http'

class AppDataHandler < Chef::Handler
	attr_reader :options
	
	def initialize(opts = {})
		@options = {
			:cl_ws_url => "",
			:output_json => {}
		}
		@options.merge! opts
	end

	def report
	        #	Chef::Log.info("Posting Given JSON: #{options[:output_json]}")
	        puts "Posting Given JSON: #{options[:output_json]}"
            	Chef::Log.info("Making Rest call to #{options[:cl_ws_url]}")
		handler_data = Hash.new
		handler_data['appDeployData'] = {}
		#handler_data['appDeployData']["applicationStatus"] = success? ? "Successful" : "Failed"
		handler_data['appDeployData']['applicationLastDeploy'] = "#{end_time}"
		arr = Array.new
		run_status.updated_resources.each do | r |
			arr.push(r.to_s)
		end

		if run_status.failed?
			arr.push(run_status.formatted_exception)
			arr.push(Array(run_status.backtrace).join("\n"))
		end
                
                #changes made by mahendra
		#handler_data['appDeployData']['appLogs'] = arr.to_s
                
                if File.exists?("/var/log/chef/client.log") then 
                path = "/var/log/chef/client.log"
                str = File.open(path) {|f| f.read}
                else
                str="NA"
                end
		
                handler_data['appDeployData']['appLogs'] = str
                 
                handler_data['appDeployData'].merge! options[:output_json]
                
                puts handler_data, options[:cl_ws_url]

                puts "Before Posting AppDeploy"
		postData = RestClient.post(options[:cl_ws_url], handler_data)
		puts postData.body
		return postData.body
		#resp = Net::HTTP.post_form(options[:cl_ws_url], handler_data)
		#puts resp.body
		#return resp.body
	end
end
