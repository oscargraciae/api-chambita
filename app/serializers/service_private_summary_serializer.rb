class ServicePrivateSummarySerializer < ActiveModel::Serializer
  #ES UTILIZADO PARA LLENAR LOS service-card sin usuario
  #ES INFORMACION PUBLICA

  attributes :id, :name, :price, :cover, :rating_general, :published, :total_jobs, :visits
  has_one :sub_category, includes: true
end
