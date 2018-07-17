require 'api_service'

module WorkoutOfTheDayApiService 
	extend ApiService, self

	Get_Wod = 'v1/workouts/wod/%<date>s'.freeze
	Get_Wod_Multiple = 'v1/workouts/wod/%<date>s?numberOfDays=%<number_of_days>d'.freeze
	Get_Wod_file = 'v1/workouts/wod/file/%<workout_id>d?format=%<file_format>s'.freeze

	def get_file(workout_id, file_format)
		response = conn.get(sprintf(Get_Wod_file % {date: Time.now.strftime("%Y-%m-%d"), workout_id: workout_id, file_format: file_format}))
		response.env
	end

	def get_wod
		response = conn.get(sprintf(Get_Wod % {date: Time.now.strftime("%Y-%m-%d")}))
		response.env
	end

	def get_wod_multiple(number_of_days)
		response = conn.get(sprintf(Get_Wod_Multiple % {date: Time.now.strftime("%Y-%m-%d"), number_of_days: number_of_days}))
		response.env
	end
end