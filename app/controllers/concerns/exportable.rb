require 'csv'

module Exportable
  extend ActiveSupport::Concern

  def export_csv
    headers = ['ID', 'Descrição', 'Finalizada?', 'ID tarefa pai', 'Criada em', 'Atualizada em']

    csv = CSV.generate(write_headers: true, headers: headers) do |row|
      Task.all.each do |task|
        row << [
          task.id,
          task.description,
          task.done? ? 'Sim' : 'Não',
          task.parent_id,
          l(task.created_at, format: "%d/%m/%Y, %Hh%M"),
          l(task.updated_at, format: "%d/%m/%Y, %Hh%M")
        ]
      end
    end

    send_data csv, type: 'text/csv; charset=utf-8; header=present', disposition: 'attachment; filename=tarefas.csv'
  end
end
