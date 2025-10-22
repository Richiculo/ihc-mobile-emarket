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

### ✅ **Sistema de Carrito** - Completamente implementado
- [x] **CartService** con gestión de estado y persistencia
- [x] Página de carrito con lista de productos y resumen
- [x] Funcionalidades: agregar, quitar, eliminar productos
- [x] Cálculo automático de subtotales, envío y total
- [x] Estado vacío con call-to-action
- [x] Integración con checkout flow

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

### 🚧 **En Desarrollo**
- [ ] Página de Categorías (UI base implementada)
- [ ] Página de Órdenes (UI base implementada)
- [ ] Funcionalidad de búsqueda avanzada
- [ ] Notificaciones push simuladas

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
│       │   └── user_service.dart        # Datos de usuario
│       └── remote/         # APIs remotas (futuro)
├── domain/                  # Capa de dominio/negocio
│   ├── models/             # ✅ Modelos implementados
│   │   ├── cart_item.dart  # Elementos del carrito
│   │   ├── checkout.dart   # Datos de checkout
│   │   ├── product.dart    # Modelo de producto
│   │   └── user.dart       # Usuario y direcciones
│   └── repositories/       # Interfaces de repositorios
└── presentation/           # Capa de presentación/UI
    ├── global/            # Recursos globales
    │   ├── colors.dart    # ✅ Sistema completo de colores
    │   ├── dialogs/       # Diálogos reutilizables
    │   └── widgets/       # ✅ 15+ widgets implementados
    │       ├── address_section.dart
    │       ├── cart_item_card.dart
    │       ├── cart_summary.dart
    │       ├── checkout_progress_indicator.dart
    │       ├── checkout_step_delivery.dart
    │       ├── checkout_step_payment.dart
    │       ├── checkout_step_personal_info.dart
    │       ├── discount_banner.dart
    │       ├── empty_cart_widget.dart
    │       ├── main_navigation.dart
    │       ├── mock_map_widget.dart
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
        ├── categories/    # ✅ UI base implementada
        │   └── categories_page.dart
        ├── cart/         # ✅ Funcionalidad completa
        │   └── cart_page.dart
        ├── checkout/     # ✅ Flujo completo implementado
        │   ├── checkout_page.dart
        │   └── checkout_success_page.dart
        ├── orders/       # ✅ UI base implementada
        │   └── orders_page.dart
        └── profile/      # ✅ Funcionalidad completa
            └── profile_page.dart
```

## 🛒 Funcionalidades de E-commerce

### **Gestión de Productos**
- ✅ **Catálogo dinámico** con productos simulados
- ✅ **Cards responsivas** con información y precios
- ✅ **Grid layout** optimizado para móvil
- ✅ **Estados de carga** y manejo de errores
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
- ✅ **Mock data** realista para demo completa

### **UX/UI Optimizaciones**
- ✅ **Mobile-first design** en todos los componentes
- ✅ **Navegación consistente** con AppBar y botones
- ✅ **Feedback visual** (loading, success, error states)
- ✅ **Animaciones suaves** en transiciones
- ✅ **Touch targets apropiados** para móvil

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
# Agregar productos al carrito desde Home
# Navegar al carrito y proceder al checkout
# Completar el flujo de 3 pasos
# Verificar confirmación final
```

## 🔄 Git Flow

Este proyecto utiliza **Git Flow simplificado** con branches específicas:

### **Branches principales:**
- **`main`**: Código estable y listo para producción
- **`develop`**: Rama de integración para desarrollo

### **Branches de features implementadas:**
- **`feat/payment-flow`**: ✅ Flujo completo de checkout y pago
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

## 💳 Demo del Flujo de Compra

### **Escenario completo funcional:**
1. **Explorar productos** en la página principal
2. **Agregar al carrito** desde product cards
3. **Revisar carrito** con cálculos automáticos
4. **Proceder al checkout** con wizard de 3 pasos:
   - Información personal (pre-llenada)
   - Selección de dirección (guardada o mapa)
   - Método de pago (tarjeta o efectivo)
5. **Simular procesamiento** de pago
6. **Confirmación final** con navegación a próximos pasos

### **Datos de prueba incluidos:**
- **Usuario**: Richard Vargas con direcciones guardadas
- **Productos**: 8+ productos con precios y descuentos
- **Tarjeta de prueba**: Simulación de formulario completo
- **Mapa**: Widget simulado para selección de ubicación

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
- [ ] **Tracking de pedidos** en tiempo real
- [ ] **Reviews y ratings** de productos
- [ ] **Recomendaciones** personalizadas
- [ ] **Multiple métodos de pago** reales

## 🧪 Testing y Calidad

### **Scenarios de testing implementados:**
- ✅ **Flujo completo de compra** end-to-end
- ✅ **Gestión de carrito** (agregar, quitar, limpiar)
- ✅ **Navegación entre páginas** sin errores
- ✅ **Validación de formularios** con casos edge
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

**Completado**: 85% 🎉
- ✅ **Arquitectura completa** con Clean Architecture
- ✅ **Navegación principal** con 5 páginas funcionales
- ✅ **Flujo de e-commerce** completo desde productos hasta checkout
- ✅ **Gestión de carrito** y estado reactivo
- ✅ **Checkout wizard** con validaciones y UX optimizada
- ✅ **Perfil de usuario** con gestión de datos
- ✅ **Sistema de colores** y componentes reutilizables
- ✅ **Mobile-responsive** design en toda la aplicación

### **Funcionalidades principales listas para demo:**
🛒 **E-commerce core**: Productos → Carrito → Checkout → Confirmación  
👤 **Gestión de usuario**: Perfil, direcciones, historial  
📱 **UX móvil**: Navegación, feedback, estados de carga  
💳 **Pagos simulados**: Tarjeta y efectivo con validaciones  

**¡Lista para presentación y demo completa!** ✨