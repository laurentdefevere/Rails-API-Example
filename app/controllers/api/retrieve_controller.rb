class Api::RetrieveController < ApplicationController
	def show
		response = select_endpoint
		if response.success?
			render body: response.body
		else
			render json: {status: response.status, reason: response.reason_phrase  }
		end
	end

	private

	def select_endpoint
		if params[:commit] == 'Get Wod'
			ApiService.get_wod
		elsif params[:commit] == 'Get Wods'
			ApiService.get_wods(params[:api_data])
		elsif params[:commit] == 'Get Next Event'
			ApiService.get_next_event(params[:api_data])
		elsif params[:commit] == 'Get Event By Date'
			ApiService.get_event_by_date(params[:api_data])
		elsif params[:commit] == 'Get Athlete Workout'
			ApiService.get_athlete_workout(params[:commit], params[:api_data])
		elsif params[:commit] == 'Get Workout'
			ApiService.get_workout(params[:commit], params[:api_data])
		elsif params[:commit] == 'Get File'
			ApiService.get_file(params[:commit], params[:api_data])
		elsif params[:commit] == 'Get Athletes'
			ApiService.get_athletes
		elsif params[:commit] == 'Get Profile'
			ApiService.get_profile
		elsif params[:commit] == 'Get Zones'
			ApiService.get_zones
		elsif params[:commit] == 'Get Zones By Type'
			ApiService.get_zones_by_type(params[:commit], params[:api_data])
		elsif params[:commit] == 'Get Zones For Athlete'
			ApiService.get_zones_for_athlete(params[:commit], params[:api_data])
		elsif params[:commit] == 'Get Zones For Athlete By Type'
			ApiService.get_zones_by_type_for_athlete(params[:commit], params[:api_data])
		elsif params[:commit] == 'Get Athlete Workouts Since'
			ApiService.get_athlete_workout_since(params[:commit], params[:api_data])
		elsif params[:commit] == 'Get Workouts Since'
			ApiService.get_workout_since(params[:commit], params[:api_data])
		elsif params[:commit] == 'Get Coach Profile'
			ApiService.get_coach_profile
		elsif params[:commit] == 'Get Assistant Coaches'
			ApiService.get_assistant_coaches
		elsif params[:commit] == 'Get Assistant Coach'
			ApiService.get_assistant_coach(params[:commit], params[:api_data])
		elsif params[:commit] == 'Get Assistant Coaches Athletes'
			ApiService.get_assistant_coaches_atheltes(params[:commit], params[:api_data])
		end
	end
end
