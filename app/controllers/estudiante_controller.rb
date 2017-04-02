class EstudianteController < ApplicationController
  def index
      @date = listyear
      if params[:nrc] and params[:semestre]
        @asignatura = Asignatura.where(:nrc => params[:nrc], :semestre => params[:semestre])
        @qcds = Qcd.where(:asignatura_id => @asignatura.ids, :estados => 1)
      end
  end
end
