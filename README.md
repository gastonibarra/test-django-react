Dockerfile App Django:

Este docker como va trabajar con librerías de python , lo primero que chequea es copiar el requirements.txt, donde están declaradas las librerías especificas del backend y corre luego el comando PIP para instalarlas. Esto va exponer el puerto 8000

Dockerfile App react:

Este docker , va descargar las librerías de node necesarias para el proyecto, se va basar en lo declarado ya (package.json package-lock.json yarn.lock ), luego instalará con Yarn , las depedencias necesarias, va exponer el puerto 3000. Por último va correr "yarn start"

En el Docker-compose, se vuelven a exponer los puertos, pero ya de forma abierta, de modo que desde mi entorno local ya puedo acceder al contenido de los puertos. Durante el deploy del frontend, se agregaron comandos para correr startup scripts, necesarios para el funcionamiento de la app.

Instrucciones PC local:

Primero, se debe correr un " docker build -t " para construir las imagenes de Django y React. En caso de querer subir este contenedor, nos logeamos en docker hub, para luego hacer un docker push de las imagenes. Para desplegar juntos los contenedores, corremos "docker-compose up -d ". En caso de querer hacer el deploy en Kubernetes, usando mi docker-compose , puedo utilizar la tool "Kompose", para convertir la info declarada antes y que K8s lo pueda leer. Va crear una serie de archivos, que podemos correr con un kubectl apply.

Alternativa en AWS:

Primero, se debe correr un " docker build -t " para construir las imagenes de Django y React. En caso de querer subir este contenedor, nos logeamos en docker hub, para luego hacer un docker push de las imagenes. Luego en AWS, vamos a ECS y autentificamos nuestras credenciales de Docker hub y traemos ese repositorio a AWS, para que quede ya guardada en el ECR. A partir de acà se pueden correr los servicios creando un EKS cluster o utilizando el servicio de Fargate.


------------------ CI/CD----------------------


build-and-push:

Con esta Github action , se configuró un primer step que guarda una versión de la imagen en mi docker hub, la cuenta y pass , lo guardé como una variable en secrets, dentro del mismo repo. Cada vez que modifiquemos el html, va disparar la integración y le agregará la tag del SHA del commit.

deploy-new-image:

En caso de no existir ningún deployment corriendo en Kubernetes, este job va hacer un deploy de la 
Luego lanzará un deploy a kubectl, previamente guardé la información obetenida del archivo del kube config (cat $HOME/.kube/config | base64) , en la variable secrets. Luego deja seteado el namespace y replicas, apuntando a la imagen.

deploy-to-cluster:

En caso de ya estar corriendo un deployment, va actualizar el que ya està corriendo, salteando el paso de configurar el entorno, como antes. En este caso va correr la versión que està apuntando al tag del github.sha , de la imagen. 