# test-django-react

Dockerfile App Django:

Este docker como va trabajar con librerías de python , lo primero que chequea es copiar el requirements.txt, donde están declaradas las librerías
especificas del backend y corre luego el comando PIP para instalarlas. Esto va exponer el puerto 8000

Dockerfile App react:

Este docker , va descargar las librerías de node necesarias para el proyecto, se va basar en 
lo declarado ya (package.json package-lock.json yarn.lock ), luego instalará con Yarn , las depedencias necesarias, va exponer el puerto 3000. 
Por último va correr "yarn start" 

En el Docker-compose, se vuelven a exponer los puertos, pero ya de forma abierta, de modo que desde mi entorno local ya puedo acceder al contenido
de los puertos. Durante el deploy del frontend, se agregaron comandos para correr startup scripts, necesarios para el funcionamiento de la app. 

Instrucciones PC local:

Primero, se debe correr un " docker build -t " para construir las imagenes de Django y React. En caso de querer subir este contenedor, 
nos logeamos en docker hub, para luego hacer un docker push de las imagenes. Para desplegar juntos los contenedores, corremos "docker-compose up -d ".
En caso de querer hacer el deploy en Kubernetes, usando mi docker-compose , puedo utilizar la tool "Kompose", para convertir la info 
declarada antes y que K8s lo pueda leer. Va crear una serie de archivos, que podemos correr con un kubectl apply.
 
Alternativa en AWS:

Primero, se debe correr un " docker build -t " para construir las imagenes de Django y React. En caso de querer subir este contenedor,
nos logeamos en docker hub, para luego hacer un docker push de las imagenes. Luego en AWS, vamos a ECS y autentificamos nuestras credenciales
de Docker hub y traemos ese repositorio a AWS, para que quede ya guardada en el ECR. A partir de acà se pueden correr los servicios
creando un EKS cluster o utilizando el servicio de Fargate.
