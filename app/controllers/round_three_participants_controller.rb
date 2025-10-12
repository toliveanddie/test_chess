class RoundThreeParticipantsController < ApplicationController
	def create
    @round_three_participant = RoundThreeParticipant.new(round_three_participant_params)
    @tournament = @round_three_participant.tournament

    if @round_three_participant.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("round-two-frame", partial: "tournaments/round_two", locals: { tournament: @tournament }),
            turbo_stream.replace("round-three-frame", partial: "tournaments/round_three", locals: { tournament: @tournament }),
            turbo_stream.prepend("flash-messages", partial: "shared/flash", locals: { message: "Engine moved to Round 3 successfully!", type: "success" })
          ]
        end
        format.html { redirect_back fallback_location: tournament_path(@tournament), notice: "Engine moved to Round 3 successfully!" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("flash-messages", partial: "shared/flash", locals: { message: "Failed to move engine to Round 3.", type: "error" })
        end
        format.html { redirect_back fallback_location: tournament_path(@tournament), alert: "Failed to move engine to Round 3." }
      end
    end
  end

  def destroy
    @round_three_participant = RoundThreeParticipant.find(params[:id])
    @tournament = @round_three_participant.tournament

    if @round_three_participant.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("round-two-frame", partial: "tournaments/round_two", locals: { tournament: @tournament }),
            turbo_stream.replace("round-three-frame", partial: "tournaments/round_three", locals: { tournament: @tournament }),
            turbo_stream.prepend("flash-messages", partial: "shared/flash", locals: { message: "Engine removed from Round 3 successfully!", type: "success" })
          ]
        end
        format.html { redirect_back fallback_location: tournament_path(@tournament), notice: "Engine removed from Round 3 successfully!" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("flash-messages", partial: "shared/flash", locals: { message: "Failed to remove engine from Round 3.", type: "error" })
        end
        format.html { redirect_back fallback_location: tournament_path(@tournament), alert: "Failed to remove engine from Round 3." }
      end
    end
  end

  private

  def round_three_participant_params
    params.require(:round_three_participant).permit(:engine_id, :tournament_id)
  end
	
end
