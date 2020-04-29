class ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date

  def start_date
    object.start_date.strftime("%d-%m-%Y")
  end

  def end_date
    object.end_date.strftime("%d-%m-%Y")
  end
end
