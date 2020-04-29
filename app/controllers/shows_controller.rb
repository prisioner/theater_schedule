class ShowsController < ApplicationController
  def index
    shows = Show.actual

    render json: shows
  end

  def create
    show = Show.create(show_params)

    respond_with(show)
  end

  def destroy
    show = Show.find(params[:id])

    show.destroy

    render json: { success: :ok }
  end

  private

  def show_params
    params.require(:show).permit(:title, :start_date, :end_date)
  end
end
