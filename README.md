# MoviesFinderSalesforce

Aplicación desarrollada en **Salesforce DX** con **Lightning Web Components (LWC)** que permite buscar películas en la [OMDb API](https://www.omdbapi.com/) y mostrar sus detalles directamente en tu organización de Salesforce.

Este proyecto sirve como ejemplo de integración entre Salesforce y APIs externas, siguiendo buenas prácticas de código, modularidad y despliegue con Salesforce DX.

---

## Descripción general

MoviesFinderSalesforce ofrece una experiencia de búsqueda de películas desde Salesforce mediante el consumo de datos de la OMDb API.  
El objetivo es mostrar cómo integrar servicios externos en la plataforma y estructurar un proyecto escalable con Salesforce DX.

---

## Características

- Búsqueda de películas por título o palabra clave  
- Visualización de información (título, año, póster, etc.)  
- Interfaz moderna construida con Lightning Web Components  
- Consumo de datos en tiempo real desde OMDb API  
- Código modular y fácilmente extensible  
- Compatible con despliegues en Salesforce DX  

---

## Tecnologías y herramientas

| Tecnología | Uso |
|------------|-----|
| Salesforce DX (SFDX) | Gestión del proyecto y despliegues |
| Lightning Web Components (LWC) | Interfaz de usuario moderna |
| JavaScript (ES6+) | Lógica y consumo de API |
| OMDb API | Fuente de datos de películas |
| Node.js & npm | Scripts y dependencias |
| Husky & Linter | Control de calidad del código |

---

## Estructura del repositorio

```bash
MoviesFinderSalesforce/
├── .husky/              # Hooks de Git
├── .vscode/             # Configuración de VS Code
├── config/              # Configuración del proyecto
├── force-app/           # Código principal de Salesforce (LWC)
├── manifest/            # Archivos de manifiesto
├── scripts/             # Scripts auxiliares
├── sfdx-project.json    # Configuración de Salesforce DX
├── package.json         # Dependencias Node.js
└── README.md            # Documentación
