class RoundTwoParticipantsController < ApplicationController
  def create
    @round_two_participant = RoundTwoParticipant.new(round_two_participant_params)

    if @round_two_participant.save
      redirect_back fallback_location: tournament_path(@round_two_participant.tournament), notice: "Engine moved to Round 2 successfully!"
    else
      redirect_back fallback_location: tournament_path(@round_two_participant.tournament), alert: "Failed to move engine to Round 2."
    end
  end

  def destroy
    @round_two_participant = RoundTwoParticipant.find(params[:id])

    if @round_two_participant.destroy
      redirect_back fallback_location: tournament_path(@round_two_participant.tournament), notice: "Engine removed from Round 2 successfully!"
    else
      redirect_back fallback_location: tournament_path(@round_two_participant.tournament), alert: "Failed to remove engine from Round 2."
    end
  end

  private

  def round_two_participant_params
    params.require(:round_two_participant).permit(:engine_id, :tournament_id)
  end
end
