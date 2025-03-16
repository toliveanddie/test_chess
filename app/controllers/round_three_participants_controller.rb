class RoundThreeParticipantsController < ApplicationController
	def create
    @round_three_participant = RoundThreeParticipant.new(round_three_participant_params)

    if @round_three_participant.save
      redirect_back fallback_location: tournament_path(@round_three_participant.tournament), notice: "Engine moved to Round 3 successfully!"
    else
      redirect_back fallback_location: tournament_path(@round_three_participant.tournament), alert: "Failed to move engine to Round 3."
    end
  end

  def destroy
    @round_three_participant = RoundThreeParticipant.find(params[:id])

    if @round_three_participant.destroy
      redirect_back fallback_location: tournament_path(@round_three_participant.tournament), notice: "Engine removed from Round 3 successfully!"
    else
      redirect_back fallback_location: tournament_path(@round_three_participant.tournament), alert: "Failed to remove engine from Round 3."
    end
  end

  private

  def round_three_participant_params
    params.require(:round_three_participant).permit(:engine_id, :tournament_id)
  end
	
end
