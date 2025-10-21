# Yeski-Market Mobile App

Aplicación móvil de e-commerce construida con Flutter usando Clean Architecture para la materia de Interacción Hombre Computadora.

## 🎨 Diseño

- **Figma**: [Link al prototipo]
- **Paleta de colores**:
  - Primario: `#DD645F`
  - Secundario: `#FAF8F1`

## 📱 Funcionalidades

- [x] ✅ **Pantalla de inicio** - Implementada completamente
  - [x] Navegación principal con 5 pestañas
  - [x] Sección "Repite tu pedido" con scroll horizontal
  - [x] Banner de descuentos con gradiente
  - [x] Grid de productos en oferta
  - [x] Buscador con animación (básico)
- [ ] Catálogo de productos
- [ ] Carrito de compras
- [ ] Historial de pedidos
- [ ] Ofertas y descuentos

## 🏗️ Arquitectura del Proyecto

```
lib/
├── main.dart                 # Entry point
├── app/
│   └── my_app.dart          # Configuración de la app
├── data/                    # Capa de datos
│   └── services/
│       ├── devices/         # Servicios de dispositivo
│       ├── local/          # Almacenamiento local
│       └── remote/         # APIs remotas
├── domain/                  # Capa de dominio/negocio
│   ├── models/             # Modelos de datos
│   │   └── product.dart    # ✅ Modelo de producto
│   └── repositories/       # Interfaces de repositorios
└── presentation/           # Capa de presentación/UI
    ├── global/            # Recursos globales
    │   ├── colors.dart    # Paleta de colores
    │   ├── dialogs/       # Diálogos reutilizables
    │   └── widgets/       # ✅ Widgets globales implementados
    │       ├── discount_banner.dart
    │       ├── main_navigation.dart
    │       ├── product_card.dart
    │       ├── product_grid.dart
    │       ├── repeat_order_section.dart
    │       └── search_bar_widget.dart
    └── modules/           # Páginas/características
        ├── home/          # ✅ Página principal completa
        │   └── home_page.dart
        ├── categories/    # 🚧 Pendiente
        ├── cart/         # 🚧 Pendiente
        ├── orders/       # 🚧 Pendiente
        └── profile/      # 🚧 Pendiente
```

## 🚀 Instalación y Ejecución

1. **Clonar el repositorio**
```bash
git clone https://github.com/Richiculo/ihc-mobile-emarket.git
cd ihc-mobile-emarket
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Ejecutar la aplicación**
```bash
flutter run
```

## 🔄 Git Flow

Este proyecto utiliza **Git Flow simplificado**:

- **`main`**: Código estable y listo para producción
- **`develop`**: Rama de integración para desarrollo
- **`feat/*`**: Ramas de características

### Workflow para desarrolladores:

```bash
# 1. Actualizar develop
git checkout develop
git pull origin develop

# 2. Crear rama de feature
git checkout -b feat/nombre-de-la-feature

# 3. Desarrollar y commitear
git add .
git commit -m "feat(scope): descripción del cambio"

# 4. Pushear y crear Pull Request
git push -u origin feat/nombre-de-la-feature
```

### Convención de Commits:

- `feat:` - Nueva funcionalidad
- `fix:` - Corrección de bugs
- `docs:` - Cambios en documentación
- `style:` - Cambios de formato
- `refactor:` - Refactorización
- `test:` - Pruebas

## 👥 Equipo

- **Desarrollador 1**: Vargas Osinaga Richard Junior
- **Desarrollador 2**: Bulacia Paz Bruno Leandro

## 📋 Tareas Pendientes

### 🎯 Próximas features prioritarias:
- [ ] **Página de Categorías** - Layout y navegación
- [ ] **Funcionalidad de búsqueda** - Completar SearchBarWidget
- [ ] **Página de detalle de producto** - Vista individual
- [ ] **Carrito de compras** - Funcionalidad básica
- [ ] **Servicios de datos** - Mock data y estructura

### 🔧 Mejoras técnicas:
- [ ] Tests unitarios para componentes
- [ ] Optimización de imágenes y performance
- [ ] Validación de formularios
- [ ] Manejo de estados con Provider/Bloc

---

**Universidad**: Universidad Autonoma Gabriel René Moreno
**Materia**: Interacción Hombre Computadora  
**Semestre**: 2-2025

## 📊 Progreso del Proyecto

**Completado**: 25% 
- ✅ Arquitectura base
- ✅ Navegación principal  
- ✅ Página de inicio completa
- ✅ Componentes reutilizables básicos


