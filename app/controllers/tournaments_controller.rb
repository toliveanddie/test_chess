class TournamentsController < ApplicationController
  before_action :set_tournament, only: %i[ show edit update destroy ]

  # GET /tournaments or /tournaments.json
  def index
    @tournaments = Tournament.all
  end

  # GET /tournaments/1 or /tournaments/1.json
  def show
		@engine_groups = @tournament.participants.includes(:engine).map(&:engine).each_slice(9).to_a
		@round_two_groups = @tournament.round_two_participants.includes(:engine).map(&:engine).each_slice(10).to_a
		@round_three_groups = @tournament.round_three_participants.includes(:engine).map(&:engine).each_slice(9).to_a


  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /tournaments/1/edit
  def edit
  end

  # POST /tournaments or /tournaments.json
  def create
		@round_two_participant = RoundTwoParticipant.new(round_two_participant_params)
	
		if @round_two_participant.save
			respond_to do |format|
				format.html { redirect_back fallback_location: tournament_path(@round_two_participant.tournament), notice: "Engine moved to Round 2 successfully!" }
				format.js # This will render a `create.js.erb` file
			end
		else
			respond_to do |format|
				format.html { redirect_back fallback_location: tournament_path(@round_two_participant.tournament), alert: "Failed to move engine to Round 2." }
				format.js { render js: "alert('Failed to move engine to Round 2.');" }
			end
		end
	end
	

  # PATCH/PUT /tournaments/1 or /tournaments/1.json
  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to @tournament, notice: "Tournament was successfully updated." }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1 or /tournaments/1.json
  def destroy
    @tournament.destroy!

    respond_to do |format|
      format.html { redirect_to tournaments_path, status: :see_other, notice: "Tournament was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tournament_params
      params.expect(tournament: [ :name, :description ])
    end
end
