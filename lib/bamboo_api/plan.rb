class BambooApi::Plan < BambooApi
	
	attr_reader :short_name, :short_key, :type, :enabled, :link, :key, :name,
		:is_favourite, :is_active, :is_building, :average_build_time, :actions, :stages, :branches

	def initialize short_name, short_key, type, enabled, link, key, name, is_favourite=nil, 
		is_active=nil, is_building=nil, average_build_time=nil, actions=nil, stages=nil, branches=nil

		@short_name = short_name
		@short_key = short_key
		@type = type
		@enabled = enabled
		@link = link
		@key = key
		@name = name

		# optional
		@is_favourite = is_favourite
		@is_active = is_active
		@is_building = is_building
		@average_build_time = average_build_time
		@actions = actions
		@stages = stages
		@branches = branches
	end

	def self.parse plans
		parsed_plans = []

		plans[ "plans" ][ "plan" ].each do | plan |
			parsed_plans.push( BambooApi::Plan.parse_single( plan ) )
		end

		parsed_plans
	end

	def self.parse_single plan
		BambooApi::Plan.new plan[ "shortName" ], plan[ "shortKey" ], plan[ "type" ], 
			plan[ "enabled" ], plan[ "link" ], plan[ "key" ], plan[ "name" ], plan[ "isFavourite" ],
			plan[ "isActive" ], plan[ "isBuilding" ], plan[ "averageBuildTimeInSeconds" ], plan[ "actions" ],
			plan[ "stages" ], plan[ "branches" ]
	end

	def self.all
		BambooApi::Plan.parse( BambooApi.request "plan" )
	end

	def self.find key
		BambooApi::Plan.parse_single( BambooApi.request "plan/#{key}" )
	end

end