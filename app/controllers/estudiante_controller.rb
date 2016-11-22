class EstudianteController < ApplicationController
  def index
      if params[:nrc] and params[:semestre]
        @asignatura = Asignatura.search(params[:nrc], params[:semestre]).order("created_at DESC")
        @qcds = Qcd.where(:asignatura_id => @asignatura.ids, :estados => 1)
      end
  end
end
