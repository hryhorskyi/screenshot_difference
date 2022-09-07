# frozen_string_literal: true

class ScreenshotsController < ApplicationController
  def new
    @screenshot = Screenshot.new
  end

  def create
    @screenshot = Screenshot.new(screenshot_params)

    respond_to do |format|
      if @screenshot.save
        format.html { redirect_to screenshot_url(@screenshot), notice: 'Screenshot was successfully made.' }
        format.json { render :show, status: :ok, location: @screenshot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @screenshot.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @screenshot = Screenshot.find(params[:id])
    make_screen
    convert_to_png
    @screenshot.image_data = save_screen
  end

  private

  def screenshot_params
    params.require(:screenshot).permit(:url)
  end

  def make_screen
    @screen = Grover.new(@screenshot.url, {
                           full_page: true
                         })
    @screen
  end

  def convert_to_png
    @png = @screen.to_png
  end

  def save_screen
    File.binwrite("app/assets/images/screenshots/#{Time.now}.png", @png)
    Cloudinary::Uploader.upload("app/assets/images/screenshots/#{Time.now}.png")
  end
end
