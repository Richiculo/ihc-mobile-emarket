# Yeski-Market Mobile App

Aplicación móvil de e-commerce construida con Flutter usando Clean Architecture para la materia de Interacción Hombre Computadora.

## 🎨 Diseño

- **Figma**: [https://www.figma.com/design/vGLJjf668vfbCnHcHJFJpo/2DO-PROYECTO?node-id=0-1&t=EU7YCkAVuYB62QWz-1]
- **Paleta de colores**:
  - Primario: `#DD645F` 
  - Secundario: `#FAF8F1`
  - Sistema de colores completo implementado en `AppColors`

## 📱 Funcionalidades Implementadas

### ✅ **Pantalla de Inicio** - Completamente funcional
- [x] Navegación principal con 5 pestañas (Home, Categories, Cart, Orders, Profile)
- [x] Sección "Repite tu pedido" con scroll horizontal y productos dinámicos
- [x] Banner de descuentos con gradiente y navegación
- [x] Grid responsivo de productos en oferta (2 columnas en móvil)
- [x] Buscador con animación y funcionalidad básica
- [x] Integración con servicios de datos simulados

### ✅ **Página de Categorías** - Completamente implementada
- [x] **Listado de categorías** con contadores de productos
- [x] **Filtrado por categoría** con navegación fluida
- [x] **Grid responsivo** de productos con CategoryProductCard optimizada
- [x] **ProductService** integrado con productos reales del e-market
- [x] **Estados vacíos** manejados correctamente
- [x] **Navegación entre vista de categorías y productos**

### ✅ **Sistema de Carrito** - Completamente implementado
- [x] **CartService** con gestión de estado y persistencia
- [x] Página de carrito con lista de productos y resumen
- [x] Funcionalidades: agregar, quitar, eliminar productos
- [x] Cálculo automático de subtotales, envío y total
- [x] Estado vacío con call-to-action
- [x] Integración con checkout flow

### ✅ **Gestión de Pedidos** - Sistema completo
- [x] **OrdersService** con pedidos mock realistas
- [x] **Página de pedidos** con estadísticas y filtros
- [x] **Order tracking** con timeline visual y mapa
- [x] **Estados de pedido** (confirmado, preparando, en camino, entregado)
- [x] **Vista de detalles** de pedido completa
- [x] **Integración con productos reales** del ProductService
- [x] **Simulación de contacto** con repartidor

### ✅ **Flujo de Checkout Completo** - Wizard de 3 pasos
- [x] **Paso 1: Información Personal** con formularios validados
- [x] **Paso 2: Dirección de Envío** con direcciones guardadas y selección en mapa
- [x] **Paso 3: Método de Pago** con tarjeta de crédito y pago contra entrega
- [x] **Procesamiento simulado** con estados de carga
- [x] **Página de éxito** con confirmación y navegación
- [x] **Validación completa** en todos los formularios
- [x] **UX optimizada** para móvil con navegación fija

### ✅ **Gestión de Usuarios y Perfil**
- [x] **UserService** con datos de usuario simulados
- [x] Página de perfil completa con información personal
- [x] Gestión de direcciones guardadas
- [x] Historial de pedidos simulado
- [x] Sección de acciones y configuración

### ✅ **Navegación y UX**
- [x] **MainNavigation** con 5 pestañas principales
- [x] **Navegación controlada** entre páginas
- [x] **Manejo de errores** y estados vacíos
- [x] **Feedback visual** consistente
- [x] **Responsive design** optimizado para móvil

## 🏗️ Arquitectura del Proyecto

```
lib/
├── main.dart                 # Entry point
├── app/
│   └── my_app.dart          # Configuración de la app
├── data/                    # Capa de datos
│   └── services/
│       ├── devices/         # Servicios de dispositivo
│       ├── local/          # ✅ Servicios implementados
│       │   ├── cart_service.dart        # Gestión del carrito
│       │   ├── checkout_service.dart    # Flujo de checkout
│       │   ├── order_service.dart       # Gestión de pedidos
│       │   ├── product_service.dart     # Catálogo de productos
│       │   └── user_service.dart        # Datos de usuario
│       └── remote/         # APIs remotas (futuro)
├── domain/                  # Capa de dominio/negocio
│   ├── models/             # ✅ Modelos implementados
│   │   ├── cart_item.dart  # Elementos del carrito
│   │   ├── checkout.dart   # Datos de checkout
│   │   ├── order.dart      # Modelo de pedido completo
│   │   ├── product.dart    # Modelo de producto
│   │   └── user.dart       # Usuario y direcciones
│   └── repositories/       # Interfaces de repositorios
└── presentation/           # Capa de presentación/UI
    ├── global/            # Recursos globales
    │   ├── colors.dart    # ✅ Sistema completo de colores
    │   ├── dialogs/       # Diálogos reutilizables
    │   └── widgets/       # ✅ 18+ widgets implementados
    │       ├── address_section.dart
    │       ├── cart_item_card.dart
    │       ├── cart_summary.dart
    │       ├── category_product_card.dart   # ✅ Nueva card para grid
    │       ├── checkout_progress_indicator.dart
    │       ├── checkout_step_delivery.dart
    │       ├── checkout_step_payment.dart
    │       ├── checkout_step_personal_info.dart
    │       ├── discount_banner.dart
    │       ├── empty_cart_widget.dart
    │       ├── empty_orders_widget.dart     # ✅ Nuevo widget
    │       ├── main_navigation.dart
    │       ├── mock_map_widget.dart
    │       ├── order_card.dart              # ✅ Nuevo widget
    │       ├── product_card.dart
    │       ├── product_grid.dart
    │       ├── profile_actions_section.dart
    │       ├── profile_header.dart
    │       ├── profile_info_section.dart
    │       ├── repeat_order_section.dart
    │       └── search_bar_widget.dart
    └── modules/           # ✅ Páginas implementadas
        ├── home/          # ✅ Página principal completa
        │   └── home_page.dart
        ├── categories/    # ✅ Funcionalidad completa
        │   └── categories_page.dart
        ├── cart/         # ✅ Funcionalidad completa
        │   └── cart_page.dart
        ├── checkout/     # ✅ Flujo completo implementado
        │   ├── checkout_page.dart
        │   └── checkout_success_page.dart
        ├── orders/       # ✅ Sistema completo implementado
        │   ├── orders_page.dart
        │   ├── order_detail_page.dart
        │   └── order_tracking_page.dart
        └── profile/      # ✅ Funcionalidad completa
            └── profile_page.dart
```

## 🛒 Funcionalidades de E-commerce

### **Gestión de Productos**
- ✅ **ProductService centralizado** con productos del e-market boliviano
- ✅ **Cards responsivas** optimizadas para home y categorías
- ✅ **Grid layout** adaptativo según contexto
- ✅ **Categorías organizadas** (Frutas, Lácteos, Panadería, etc.)
- ✅ **Integración con carrito** desde cualquier vista

### **Carrito de Compras**
- ✅ **Gestión completa** de productos en carrito
- ✅ **Cálculos automáticos** de subtotales y totales
- ✅ **Persistencia** durante la sesión
- ✅ **Estados vacío/con productos** bien diferenciados
- ✅ **Validaciones** antes del checkout

### **Proceso de Checkout**
- ✅ **Wizard de 3 pasos** con navegación controlada
- ✅ **Formularios validados** con feedback en tiempo real
- ✅ **Selección de direcciones** guardadas o mapa
- ✅ **Métodos de pago múltiples** (tarjeta/efectivo)
- ✅ **Simulación de pago** con Red Enlace/Libélula
- ✅ **Confirmación final** con próximos pasos

### **Gestión de Pedidos**
- ✅ **Historial completo** con diferentes estados
- ✅ **Tracking en tiempo real** con mapa y timeline
- ✅ **Estados visuales** (confirmado, preparando, en camino, entregado)
- ✅ **Detalles de pedido** con productos y direcciones
- ✅ **Contacto con repartidor** simulado
- ✅ **Filtros por estado** de pedido

### **Gestión de Usuario**
- ✅ **Perfil completo** con información personal
- ✅ **Direcciones guardadas** para delivery
- ✅ **Historial simulado** de pedidos anteriores
- ✅ **Funcionalidad "Repetir pedido"** desde el perfil

## 🎯 Características Técnicas

### **Estado y Datos**
- ✅ **ChangeNotifier** para gestión de estado reactiva
- ✅ **ListenableBuilder** para UI que reacciona a cambios
- ✅ **Servicios singleton** para datos compartidos
- ✅ **Mock data realista** para demo completa

### **UX/UI Optimizaciones**
- ✅ **Mobile-first design** en todos los componentes
- ✅ **Navegación consistente** con AppBar y botones
- ✅ **Feedback visual** (loading, success, error states)
- ✅ **Animaciones suaves** en transiciones
- ✅ **Touch targets apropiados** para móvil
- ✅ **Overflow prevention** en textos largos

### **Validaciones y Seguridad**
- ✅ **Validación de formularios** en tiempo real
- ✅ **Input formatters** para tarjetas de crédito
- ✅ **Manejo de errores** user-friendly
- ✅ **Navegación segura** sin pérdida de datos

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

4. **Para testing completo**
```bash
# Navegar por todas las categorías y productos
# Agregar productos al carrito desde Home y Categories
# Completar el flujo de checkout de 3 pasos
# Revisar historial de pedidos y tracking
# Verificar perfil de usuario y direcciones
```

## 🔄 Git Flow

Este proyecto utiliza **Git Flow simplificado** con branches específicas:

### **Branches principales:**
- **`main`**: Código estable y listo para producción
- **`develop`**: Rama de integración para desarrollo

### **Branches de features implementadas:**
- **`feat/payment-flow`**: ✅ Flujo completo de checkout y pago
- **`feat/orders-page`**: ✅ Sistema completo de gestión de pedidos
- **`feat/categories-page`**: ✅ Página de categorías con filtrado
- **`fix/navigation-error`**: ✅ Correcciones de navegación

### **Workflow para desarrolladores:**

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

### **Convención de Commits:**

- `feat:` - Nueva funcionalidad
- `fix:` - Corrección de bugs
- `docs:` - Cambios en documentación
- `style:` - Cambios de formato
- `refactor:` - Refactorización
- `test:` - Pruebas

## 💳 Demo del Flujo Completo

### **Escenario end-to-end funcional:**
1. **Explorar productos** en home y navegar por categorías
2. **Filtrar por categoría** y ver productos específicos
3. **Agregar al carrito** desde product cards optimizadas
4. **Revisar carrito** con cálculos automáticos
5. **Proceder al checkout** con wizard de 3 pasos
6. **Simular procesamiento** de pago
7. **Ver confirmación** y navegar a pedidos
8. **Tracking de pedido** con mapa y timeline
9. **Gestionar perfil** y repetir pedidos anteriores

### **Datos de prueba incluidos:**
- **Usuario**: Richard Vargas con direcciones en Santa Cruz
- **Productos**: Manzanas de Vallegrande, Huevos, Leche Pil, Pan integral, Queso fresco
- **Categorías**: Frutas y Verduras, Lácteos y Huevos, Panadería, Bebidas, etc.
- **Pedidos**: Estados variados con productos reales y tracking simulado

## 👥 Equipo

- **Desarrollador 1**: Vargas Osinaga Richard Junior
- **Desarrollador 2**: Bulacia Paz Bruno Leandro

## 📋 Próximas Implementaciones

### 🎯 **Features prioritarias:**
- [ ] **Búsqueda avanzada** con filtros y categorías
- [ ] **Detalle de producto** con galería de imágenes
- [ ] **Favoritos/Wishlist** con persistencia
- [ ] **Notificaciones** de pedidos y ofertas
- [ ] **Onboarding** para nuevos usuarios

### 🔧 **Mejoras técnicas:**
- [ ] **Tests unitarios** para servicios y widgets
- [ ] **Integración con APIs** reales
- [ ] **Optimización de performance** y imágenes
- [ ] **Offline support** con almacenamiento local
- [ ] **Analytics** y tracking de eventos

### 🛒 **Funcionalidades de e-commerce avanzadas:**
- [ ] **Sistema de cupones** y descuentos
- [ ] **Reviews y ratings** de productos
- [ ] **Recomendaciones** personalizadas
- [ ] **Multiple métodos de pago** reales

## 🧪 Testing y Calidad

### **Scenarios de testing implementados:**
- ✅ **Flujo completo de e-commerce** end-to-end
- ✅ **Navegación entre categorías** y filtrado
- ✅ **Gestión de carrito** (agregar, quitar, limpiar)
- ✅ **Proceso de checkout** con validaciones
- ✅ **Tracking de pedidos** con estados dinámicos
- ✅ **Estados vacíos y de error** bien manejados

### **Calidad de código:**
- ✅ **Clean Architecture** bien estructurada
- ✅ **Separación de responsabilidades** clara
- ✅ **Widgets reutilizables** y modulares
- ✅ **Gestión de estado** eficiente
- ✅ **Convenciones de naming** consistentes

---

**Universidad**: Universidad Autonoma Gabriel René Moreno  
**Materia**: Interacción Hombre Computadora  
**Semestre**: 2-2025

## 📊 Progreso del Proyecto

**Completado**: 100% 🎉
- ✅ **Arquitectura completa** con Clean Architecture
- ✅ **5 páginas principales** completamente funcionales
- ✅ **Flujo de e-commerce completo** desde categorías hasta entrega
- ✅ **Sistema de gestión de pedidos** con tracking visual
- ✅ **Checkout wizard** con validaciones y UX optimizada
- ✅ **Navegación por categorías** con filtrado de productos
- ✅ **ProductService centralizado** con productos bolivianos
- ✅ **Sistema de colores** y componentes reutilizables
- ✅ **Mobile-responsive** design en toda la aplicación

### **Aplicación completa lista para demo:**
🏠 **Home**: Productos destacados y navegación  
📂 **Categories**: Filtrado por categorías con grid optimizado  
🛒 **Cart**: Gestión completa del carrito  
📦 **Orders**: Historial, detalles y tracking de pedidos  
👤 **Profile**: Gestión de usuario y direcciones  
💳 **Checkout**: Flujo completo de 3 pasos  

**¡Aplicación 100% funcional lista para presentación!** ✨