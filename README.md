# FullStack-SpringBoot-Deployment
Deploy fulltstack react frontend, spring boot backend and Mysql based application to a Linux Server


## ----- DATABASE -----

1. Create RDS MYSQL Database from the AWS Console or use Terraform
2. Keep a note of your Database name, database endpoint, username and Password
3. Open MYSQL workbench and test connection and connect to your Database 


NOTE: to build the server, use below repo for the terraform script

Use the terraform script in the Terraform_DO_LinuxServer folder to provision an Ubuntu droplet in Digital Ocean

NOTE: Run backend and front end app and test working of app first

  a. mvn clean install and java -jar of backend jarfile, carry this out in the backend directory
  b. npm install and npm start , carry this out in the frontend directory
  add your endpoint onto your applications.properties for your backend, your username and password
  add your api or backend link or url to your EmployeeService.js


## ------- BACKEND ------

## ---- BACKEND BUILD FOR PRODUCTION -----

1. Create a Prod Server
 a. Create a non root user

2. Install Java 17, Maven, Nodesjs using binaries, 

   a. nodejs install link  ---- https://github.com/nodesource/distributions
   b. # java 17 installation step. see below !

     sudo apt-get update -y
     sudo apt-get upgrade -y
     sudo apt install openjdk-17-jdk openjdk-17-jre -y
     java --version

3. Copy Jar file to Prod Server or git clone source code and build the jar
4. Test that the Application works
 a. mvn clean install -DskipTests=true for backend
 b. npm start for frontend

App - https://github.com/ooghenekaro/employee-app.git

sudo nano /etc/systemd/system/spring.service 


Copy and Paste below Content, replace jar file path with yours and also the user

[Unit]
Description=Spring init sample
After=syslog.target
[Service]
User= <YourUbuntuUser>
Restart=always
RestartSec=30s
ExecStart=/usr/bin/java -jar /home/spring/employee-app/employeemanagmentbackend/target/employeemanagmentbackend-0.0.1-SNAPSHOT.jar SuccessExitStatus=143
[Install]
WantedBy=multi-user.target



sudo systemctl enable spring.service
sudo systemctl start spring.service
sudo systemctl stop spring.service
sudo systemctl restart spring.service


NOTE: If The unit file, source configuration file or drop-ins of spring.service changed on disk. Run 'systemctl daemon-reload' to reload units.


<img src="./Screenshot 2024-03-16 at 21.36.03.png" alt="Running Backend"/>

## ------- FRONTEND -------

### -- FRONTEND BUILD FOR PROUDUCTION --

1. install nginx
2. set up firewall (ssh, nginx full, 8080)

3. cd employee-app/employeemanagement-frontend
4. npm run build

5. cd /var/www and run sudo mkdir front

5b. sudo cp -r asset-manifest.json index.html static/ /var/www/front

6. cd /etc/nginx/sites-available

7. sudo nano sping and paste below file

server {
 listen 80;
 server_name  rekeyole.site www.rekeyole.site;

location / {
 root /var/www/front;
 index  index.html index.htm;
 proxy_http_version 1.1;
 proxy_set_header Upgrade $http_upgrade;
 proxy_set_header Connection 'upgrade';
 proxy_set_header Host $host;
 proxy_cache_bypass $http_upgrade;
 try_files $uri $uri/ /index.html;
 }
}

server {
  listen 80;
  server_name spring.rekeyole.site;
  location / {
    proxy_pass http://161.35.161.173:8080;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
    }
}

8. Create a symlink
 a. sudo ln -s /etc/nginx/sites-available/spring /etc/nginx/sites-enabled/spring
9. sudo systemctl restart nginx


<img src="./Screenshot 2024-03-16 at 21.35.11.png" alt="Running Frontend"/>

## ---- INSTALL CERTBOT -----

1. Update your snapd package

  a. sudo snap install core; sudo snap refresh core

2. sudo apt remove certbot (if using a server with an older certbot)

3. Install certbot package

  a. sudo snap install --classic certbot

4. Link the certbot command from the snap install directory to our path, so you can run it by just running certbot

 a. sudo ln -s /snap/bin/certbot /usr/bin/certbot


5. Obtain SSL Certificate

Certbot provides a variety of ways to obtain SSL certificates through plugins. The Nginx plugin will take care of reconfiguring Nginx and reloading the config whenever necessary. To use this plugin, we use the below command:



   a. sudo certbot --nginx -d react.rekeyole.site -d spring.rekeyole.site -d front.reekyole.site

  b. enter requested informations like your email and accept terms and conditions etc


Your certificates are downloaded, installed, and loaded, and your Nginx configuration will now automatically redirect all web requests to https://.



## ---- RECONFIGURE YOUR EMPLOYEE.JS FILE TO REFLECT LATEST CHANGES ----

1. Go to Frontend directory
2. cd /home/spring/employee-app/employeemanagement-frontend/src/service 
3. nano or vi EmployeeService.js
4. Change your api link for your BASE_URL to your new dns name
5. Go test your app again and you will be able to connect to the backend and your application working perfectly fine

YAYYYYYYYYYY, YOU MADE IT !!!!
