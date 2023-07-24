class PoReportsController < ApplicationController
layout 'report'
  def index
    @grid = PoReportsGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  protected

  def grid_params
    params.fetch(:po_reports_grid, {}).permit!
  end

end

