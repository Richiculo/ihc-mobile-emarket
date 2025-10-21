# Yeski-Market Mobile App

Aplicación móvil de e-commerce construida con Flutter usando Clean Architecture para la materia de Interacción Hombre Computadora.

## 🎨 Diseño

- **Figma**: [Link al prototipo]
- **Paleta de colores**:
  - Primario: `#DD645F`
  - Secundario: `#FAF8F1`

## 📱 Funcionalidades

- [ ] Pantalla de inicio
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
│   └── repositories/       # Interfaces de repositorios
└── presentation/           # Capa de presentación/UI
    ├── global/            # Recursos globales
    │   ├── colors.dart    # Paleta de colores
    │   ├── dialogs/       # Diálogos reutilizables
    │   └── widgets/       # Widgets globales
    └── modules/           # Páginas/características
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

- [ ] Configurar navegación entre pantallas
- [ ] Implementar pantalla Home
- [ ] Crear componentes reutilizables
- [ ] Agregar modelos de datos
- [ ] Implementar servicios de datos

---

**Universidad**: Universidad Autonoma Gabriel René Moreno
**Materia**: Interacción Hombre Computadora  
**Semestre**: 2-2025