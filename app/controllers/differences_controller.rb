# frozen_string_literal: true

require 'open-uri'

class DifferencesController < ApplicationController
  def new
    @difference = Difference.new
  end

  def create
    @difference = Difference.new(difference_params)

    respond_to do |format|
      if @difference.save
        format.html { redirect_to difference_url(@difference), notice: 'Difference: ' }
        format.json { render :show, status: :ok, location: @difference }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @difference.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @difference = Difference.find(params[:id])
    open_images
    diff_image
    @difference.difference_data = save_image
  end

  private

  def difference_params
    params.require(:difference).permit(:original, :edited)
  end

  def open_images
    first_image = URI.open(@difference.original_url).read
    @one = ChunkyPNG::Image.from_blob(first_image)
    second_image = URI.open(@difference.edited_url).read
    @two = ChunkyPNG::Image.from_blob(second_image)
  end

  def diff_image
    @one.height.times do |y|
      @one.row(y).each_with_index do |pixel, x|
        @two[x, y] = ChunkyPNG::Color.rgb(
          ChunkyPNG::Color.r(pixel) + ChunkyPNG::Color.r(@two[x,
                                                              y]) - (2 * [ChunkyPNG::Color.r(pixel),
                                                                          ChunkyPNG::Color.r(@two[x, y])].min),
          ChunkyPNG::Color.g(pixel) + ChunkyPNG::Color.g(@two[x,
                                                              y]) - (2 * [ChunkyPNG::Color.g(pixel),
                                                                          ChunkyPNG::Color.g(@two[x, y])].min),
          ChunkyPNG::Color.b(pixel) + ChunkyPNG::Color.b(@two[x,
                                                              y]) - (2 * [ChunkyPNG::Color.b(pixel),
                                                                          ChunkyPNG::Color.b(@two[x, y])].min)
        )
      end
    end
  end

  def save_image
    path = "app/assets/images/differences/diff#{Time.now}.png"
    @two.save(path)
    Cloudinary::Uploader.upload(path)
  end
end
