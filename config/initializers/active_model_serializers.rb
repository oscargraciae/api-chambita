# ActiveModelSerializers.config.adapter = :json_api

# ActiveModelSerializers.config.adapter = :json

# Disable for all serializers (except ArraySerializer)
ActiveSupport.on_load(:active_model_serializers) do
  # Disable for all serializers (except ArraySerializer)
  ActiveModel::Serializer.root = false

  # Disable for ArraySerializer
  ActiveModel::ArraySerializer.root = false
end
