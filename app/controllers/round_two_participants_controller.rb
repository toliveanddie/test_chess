class RoundTwoParticipantsController < ApplicationController
  def create
    @round_two_participant = RoundTwoParticipant.new(round_two_participant_params)
    @tournament = @round_two_participant.tournament

    if @round_two_participant.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("round-one-frame", partial: "tournaments/round_one", locals: { tournament: @tournament }),
            turbo_stream.replace("round-two-frame", partial: "tournaments/round_two", locals: { tournament: @tournament }),
            turbo_stream.prepend("flash-messages", partial: "shared/flash", locals: { message: "Engine moved to Round 2 successfully!", type: "success" })
          ]
        end
        format.html { redirect_back fallback_location: tournament_path(@tournament), notice: "Engine moved to Round 2 successfully!" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("flash-messages", partial: "shared/flash", locals: { message: "Failed to move engine to Round 2.", type: "error" })
        end
        format.html { redirect_back fallback_location: tournament_path(@tournament), alert: "Failed to move engine to Round 2." }
      end
    end
  end

  def destroy
    @round_two_participant = RoundTwoParticipant.find(params[:id])
    @tournament = @round_two_participant.tournament

    if @round_two_participant.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("round-one-frame", partial: "tournaments/round_one", locals: { tournament: @tournament }),
            turbo_stream.replace("round-two-frame", partial: "tournaments/round_two", locals: { tournament: @tournament }),
            turbo_stream.prepend("flash-messages", partial: "shared/flash", locals: { message: "Engine removed from Round 2 successfully!", type: "success" })
          ]
        end
        format.html { redirect_back fallback_location: tournament_path(@tournament), notice: "Engine removed from Round 2 successfully!" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("flash-messages", partial: "shared/flash", locals: { message: "Failed to remove engine from Round 2.", type: "error" })
        end
        format.html { redirect_back fallback_location: tournament_path(@tournament), alert: "Failed to remove engine from Round 2." }
      end
    end
  end

  private

  def round_two_participant_params
    params.require(:round_two_participant).permit(:engine_id, :tournament_id)
  end
end
