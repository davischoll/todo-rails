class Task < ApplicationRecord
  validates_presence_of :description
  validates :done, inclusion: [true, false]

  def symbol
    case status
      when 'pending' then '>>'
      when 'done'    then 'v'
      when 'expired' then 'x'
    end
  end

  def css_color
    case status
      when 'pending' then 'primary'
      when 'done'    then 'success'
      when 'expired' then 'danger'
    end
  end

  private

  def status
    return 'done' if done?

    due_date.past? ? 'expired' : 'pending'
  end
end
