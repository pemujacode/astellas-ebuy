class PrReportsController < ApplicationController
layout 'report'
  def index
    @grid = PrReportsGrid.new(grid_params) do |scope|
      scope.page(params[:page])


      
    end
  end

  protected

  def grid_params
    params.fetch(:pr_reports_grid, {}).permit!
  end

end

