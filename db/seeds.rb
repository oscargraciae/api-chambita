
#rating
RatingType.create(name: 'Precio')
RatingType.create(name: 'Calidad')
RatingType.create(name: 'Tiempo')

# Estatus de soicitud (Carga inicial)
RequestStatus.create(name: 'Pendiente')
RequestStatus.create(name: 'En proceso')
RequestStatus.create(name: 'Terminado')
RequestStatus.create(name: 'Cancelado')
RequestStatus.create(name: 'En relamación')
RequestStatus.create(name: 'Cancelado por reclamación')

OrderStatus.create(name: 'Pagado')
OrderStatus.create(name: 'Rechazado')
OrderStatus.create(name: 'Pendiente')


# Categorias (Carga inicial)
Category.create(name: 'Hogar')
Category.create(name: 'Eventos y entretenimiento')
Category.create(name: 'Cursos y clases')

# Sub categorias (Carga inicial)
SubCategory.create(name: 'Plomería', category_id: 1)
SubCategory.create(name: 'Electricista', category_id: 1)
SubCategory.create(name: 'Pintura', category_id: 1)
SubCategory.create(name: 'Carpinteria', category_id: 1)
SubCategory.create(name: 'Cerrajería', category_id: 1)
SubCategory.create(name: 'Jardineria', category_id: 1)
SubCategory.create(name: 'Albañileria', category_id: 1)
SubCategory.create(name: 'Impermiabilización', category_id: 1)
SubCategory.create(name: 'Reparacion de computadoras', category_id: 1)
SubCategory.create(name: 'Reparacion de equipos electrónicos', category_id: 1)
SubCategory.create(name: 'Limpieza', category_id: 1)
SubCategory.create(name: 'Fletes y mudanza', category_id: 1)

SubCategory.create(name: 'Ambientación', category_id: 2)
SubCategory.create(name: 'Fotorafia y video', category_id: 2)
SubCategory.create(name: 'Juegos infantiles', category_id: 2)
SubCategory.create(name: 'Banquetes', category_id: 2)
SubCategory.create(name: 'Personajes', category_id: 2)
SubCategory.create(name: 'Música y sonido', category_id: 2)

SubCategory.create(name: 'Academico', category_id: 3)
SubCategory.create(name: 'Idiomas', category_id: 3)
SubCategory.create(name: 'Artes', category_id: 3)
SubCategory.create(name: 'Música', category_id: 3)


# Tipos de unidad de medida
UnitType.create(description: 'mts2')
UnitType.create(description: 'días')
UnitType.create(description: 'horas')
#UnitType.create(description: 'cantidad')
