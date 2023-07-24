class ViprReportsController < ApplicationController
layout 'report'
  def index
    @grid = ViprReportsGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  protected

  def grid_params
    params.fetch(:vipr_reports_grid, {}).permit!
  end

end



