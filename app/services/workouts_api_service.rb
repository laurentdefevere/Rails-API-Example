require 'api_service'

module WorkoutsApiService 
	extend ApiService, self

	Plan_Url = "v1/workouts/plan".freeze
	Put_Url = "v1/workouts/plan/%<workout_id>d".freeze
	Workout_By_Date = "/v1/workouts/%<start_date>s/%<end_date>s".freeze
	Athlete_Workout = "/v1/workouts/%<athlete_id>d/%<start_date>s/%<end_date>s".freeze
	Workout_By_Id = "/v1/workouts/id/%<workout_id>d".freeze
	Athlete_Workout_By_Id = "/v1/workouts/%<athlete_id>d/id/%<workout_id>d/".freeze
	Workout_Meanmaxes = "/v1/workouts/id/%<workout_id>d/meanmaxes".freeze
	Athlete_Workout_Meanmaxes = "/v1/workouts/%<athlete_id>d/id/%<workout_id>d/meanmaxes".freeze
	Workout_Details = "/v1/workouts/id/%<workout_id>d/details".freeze
	Athlete_Workout_Details = "/v1/workouts/%<athlete_id>d/id/%<workout_id>d/details".freeze
	Workout_Timeinzones = "/v1/workouts/id/%<workout_id>d/timeinzones".freeze
	Athlete_Workout_Timeinzones = "/v1/workouts/%<athlete_id>d/id/%<workout_id>d/timeinzones".freeze
	Workouts_Since = "/v1/workouts/changes/%<since_date>s?pageSize=%<page_size>d&page=%<page>d".freeze
	Athlete_Workouts_Since = "/v1/workouts/changes/%<athlete_id>d/%<since_date>s?pageSize=%<page_size>d&page=%<page>d".freeze

	def post_plan(post_data)
		response = conn.post do |req|
			req.url Plan_Url
			params = {}
			params["UploadClient"] = ENV["client_id"]
			load_api_data_into_req(post_data, params)
			req.body = params.to_json
		end
		response.env
	end

	def put_plan(put_data)
		url = sprintf(Put_Url % {workout_id: put_data[:Id]})
		response = conn.put do |req|
			req.url url
			params = {}
			params["UploadClient"] = ENV["client_id"]
			load_api_data_into_req(put_data, params)
			req.body = params.to_json
		end
		response.env
	end

	def get_by_date(start_date, end_date)
		response = conn.get(sprintf(Workout_By_Date % {start_date: start_date, end_date: end_date}))
		response.env
	end

	def get_athlete_workout_(athlete_id, start_date, end_date)
		response = conn.get(sprintf(Athlete_Workout % {athlete_id: athlete_id, start_date: start_date, end_date: end_date}))
		response.env
	end

	def get_by_id(id)
		response = conn.get(sprintf(Workout_By_Id % {workout_id: id}))
		response.env
	end

	def get_athlete_by_id(athlete_id, id)
		response = conn.get(sprintf(Athlete_Workout_By_Id % {athlete_id: athlete_id, workout_id: id}))
		response.env
	end

	def delete_workout(id)
		response = conn.delete(sprintf(Workout_By_Id % {workout_id: id}))
		response.env
	end

	def get_meanmaxes(id)
		response = conn.get(sprintf(Workout_Meanmaxes % {workout_id: id}))
		response.env
	end

	def get_athlete_meanmaxes(athlete_id, id)
		response = conn.get(sprintf(Athlete_Workout_Meanmaxes % {athlete_id: athlete_id, workout_id: id}))
		response.env
	end

	def get_details(id)
		Workout_Details
		response = conn.get(sprintf(Workout_Details % {workout_id: id}))
		response.env
	end

	def get_athlete_details(athlete_id, id)
		Workout_Details
		response = conn.get(sprintf(Athlete_Workout_Details % {athlete_id: athlete_id, workout_id: id}))
		response.env
	end

	def get_timeinzones(id)
		response = conn.get(sprintf(Workout_Timeinzones % {workout_id: id}))
		response.env
	end

	def get_athlete_timeinzones(athlete_id, id)
		response = conn.get(sprintf(Athlete_Workout_Timeinzones % {athlete_id: athlete_id, workout_id: id}))
		response.env
	end

	def get_since(since_date, page_size, page)
		response = conn.get(sprintf(Workouts_Since % {since_date: since_date, page_size: page_size, page: page}))
		response.env
	end

	def get_athlete_since(athlete_id, since_date, page_size, page)
		response = conn.get(sprintf(Athlete_Workouts_Since, 
			{athlete_id: athlete_id, since_date: since_date, page_size: page_size, page: page}))
		response.env
	end
end
